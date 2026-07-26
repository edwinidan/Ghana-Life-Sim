import 'dart:math';

import '../../data/illnesses.dart';
import '../../models/character.dart';
import '../models/financial_transaction.dart';
import '../models/illness_state.dart';
import '../repositories/illness_state_repository.dart';

class IllnessYearResult {
  const IllnessYearResult({
    required this.healthImpact,
    required this.transactions,
    required this.messages,
  });

  final int healthImpact;
  final List<FinancialTransaction> transactions;
  final List<String> messages;
}

class TreatmentResult {
  const TreatmentResult({
    required this.success,
    required this.message,
    this.transaction,
  });

  final bool success;
  final String message;
  final FinancialTransaction? transaction;
}

class IllnessProgressionService {
  const IllnessProgressionService({
    this.repository = const IllnessStateRepository(),
  });

  final IllnessStateRepository repository;

  IllnessYearResult progress(Character character, Random random) {
    final illnesses = repository.read(character);
    final updated = <ActiveIllnessState>[];
    final transactions = <FinancialTransaction>[];
    final messages = <String>[];
    var totalImpact = 0;

    for (final illness in illnesses) {
      if (illness.resolved) {
        updated.add(illness);
        continue;
      }
      final definition = illnessById(illness.illnessDefinitionId);
      var treatment = illness.treatmentStatus;
      var modifier = illness.severityModifier;
      var resolved = false;
      final history = [...illness.history];

      if ((treatment == TreatmentStatus.medication ||
              treatment == TreatmentStatus.monitoring) &&
          definition.treatments.isNotEmpty) {
        final ongoingCost = definition.treatments.first.ongoingCost;
        if (ongoingCost > 0) {
          if (character.cash >= ongoingCost) {
            character.adjustCash(-ongoingCost);
            transactions.add(
              FinancialTransaction(
                id:
                    'health-${character.lifeSeed}-${character.age}-'
                    '${illness.id}-ongoing',
                category: TransactionCategory.healthcare,
                amount: -ongoingCost,
                age: character.age,
                description: '${definition.displayName} ongoing care',
                sourceId: illness.id,
              ),
            );
          } else {
            treatment = TreatmentStatus.untreated;
            messages.add(
              '${definition.displayName} care stopped because it was unaffordable.',
            );
          }
        }
      }

      final treated = treatment != TreatmentStatus.untreated;
      final impact = max(
        0,
        definition.yearlyHealthImpact +
            modifier -
            (treated ? definition.yearlyHealthImpact ~/ 2 : 0),
      );
      totalImpact += impact;
      character.adjustStat('health', -impact);

      if (!definition.chronic && treated && random.nextDouble() < 0.58) {
        resolved = true;
        modifier = max(-5, modifier - 2);
        messages.add('${definition.displayName} resolved after treatment.');
        history.add(
          IllnessHistoryEntry(
            age: character.age,
            action: 'resolved',
            summary: '${definition.displayName} resolved.',
          ),
        );
      } else {
        final worseningChance =
            (definition.untreatedRisk + (treated ? -12 : 0) + modifier).clamp(
              0,
              95,
            );
        if (random.nextInt(100) < worseningChance) {
          modifier = (modifier + 3).clamp(-10, 25);
          messages.add('${definition.displayName} worsened this year.');
          history.add(
            IllnessHistoryEntry(
              age: character.age,
              action: 'worsened',
              summary: '${definition.displayName} became more serious.',
            ),
          );
        } else {
          messages.add('${definition.displayName} remained stable.');
        }
      }

      updated.add(
        illness.copyWith(
          yearsActive: illness.yearsActive + 1,
          treatmentStatus: treatment,
          severityModifier: modifier,
          resolved: resolved,
          history: history,
        ),
      );
    }

    repository.write(character, updated);
    _syncLegacy(character, updated);
    for (final message in messages) {
      character.lifeLog.insert(0, 'Age ${character.age}: $message');
    }
    return IllnessYearResult(
      healthImpact: totalImpact,
      transactions: transactions,
      messages: messages,
    );
  }

  TreatmentResult treat({
    required Character character,
    required String illnessId,
    required String treatmentId,
    required Random random,
  }) {
    final illnesses = repository.read(character);
    final index = illnesses.indexWhere((illness) => illness.id == illnessId);
    if (index < 0 || illnesses[index].resolved) {
      return const TreatmentResult(
        success: false,
        message: 'That condition is no longer active.',
      );
    }
    final illness = illnesses[index];
    final definition = illnessById(illness.illnessDefinitionId);
    final options = definition.treatments
        .where((option) => option.id == treatmentId)
        .toList();
    if (options.isEmpty) {
      return const TreatmentResult(
        success: false,
        message: 'That treatment is unavailable.',
      );
    }
    final option = options.first;
    if (character.cash < option.cost) {
      return TreatmentResult(
        success: false,
        message: 'You need GHS ${option.cost} for this treatment.',
      );
    }

    character.adjustCash(-option.cost);
    final improved = random.nextDouble() < option.successChance;
    final history = [
      ...illness.history,
      IllnessHistoryEntry(
        age: character.age,
        action: 'treatment',
        summary: improved
            ? '${option.name} improved the condition.'
            : '${option.name} did not produce the hoped-for improvement.',
      ),
    ];
    illnesses[index] = illness.copyWith(
      treatmentStatus: option.ongoingCost > 0
          ? TreatmentStatus.medication
          : TreatmentStatus.treated,
      severityModifier: improved
          ? (illness.severityModifier - 4).clamp(-10, 25)
          : illness.severityModifier,
      history: history,
    );
    repository.write(character, illnesses);
    final message = improved
        ? '${option.name} improved your ${definition.displayName}.'
        : '${option.name} was completed, but improvement was limited.';
    character.lifeLog.insert(0, 'Age ${character.age}: $message');
    return TreatmentResult(
      success: true,
      message: message,
      transaction: FinancialTransaction(
        id:
            'health-${character.lifeSeed}-${character.age}-'
            '${illness.id}-${history.length}',
        category: TransactionCategory.healthcare,
        amount: -option.cost,
        age: character.age,
        description: option.name,
        sourceId: illness.id,
      ),
    );
  }

  void diagnose(Character character, String definitionId) {
    final illnesses = repository.read(character);
    if (illnesses.any(
      (illness) =>
          illness.illnessDefinitionId == definitionId && !illness.resolved,
    )) {
      return;
    }
    final definition = illnessById(definitionId);
    illnesses.add(
      ActiveIllnessState(
        id:
            'illness-${character.lifeSeed}-${character.age}-'
            '${illnesses.length}',
        illnessDefinitionId: definition.id,
        diagnosedAtAge: character.age,
        history: [
          IllnessHistoryEntry(
            age: character.age,
            action: 'diagnosed',
            summary: 'Diagnosed with ${definition.displayName}.',
          ),
        ],
      ),
    );
    repository.write(character, illnesses);
    _syncLegacy(character, illnesses);
  }

  void _syncLegacy(Character character, List<ActiveIllnessState> illnesses) {
    character.activeIllnesses = illnesses
        .where((illness) => !illness.resolved)
        .map((illness) => illnessById(illness.illnessDefinitionId).displayName)
        .toList();
  }
}
