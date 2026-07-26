import 'dart:math';

import '../../data/events.dart';
import '../../models/character.dart';
import '../../models/event.dart';
import '../../services/career_service.dart';
import '../../services/housing_service.dart';
import '../../services/life_goal_service.dart';
import '../../services/relationship_service.dart';
import '../../services/school_service.dart';
import '../models/timeline_entry.dart';
import '../models/financial_transaction.dart';
import '../repositories/timeline_repository.dart';
import '../repositories/financial_ledger_repository.dart';
import '../services/event_selection_service.dart';
import '../services/family_progression_service.dart';
import '../services/illness_progression_service.dart';
import '../services/typed_business_service.dart';

class FinancialYearSummary {
  const FinancialYearSummary({
    required this.income,
    required this.expenses,
    required this.debtInterest,
    required this.netCashChange,
  });

  final int income;
  final int expenses;
  final int debtInterest;
  final int netCashChange;
}

class AgeUpResult {
  const AgeUpResult({
    required this.decisions,
    required this.entries,
    required this.finances,
    required this.stageChanged,
    required this.transactions,
  });

  final List<LifeEvent> decisions;
  final List<TimelineEntry> entries;
  final FinancialYearSummary finances;
  final bool stageChanged;
  final List<FinancialTransaction> transactions;
}

class AgeUpUseCase {
  const AgeUpUseCase({
    required EventSelectionService eventSelection,
    required TimelineRepository timelineRepository,
    FinancialLedgerRepository ledgerRepository =
        const FinancialLedgerRepository(),
  }) : _eventSelection = eventSelection,
       _timelineRepository = timelineRepository,
       _ledgerRepository = ledgerRepository;

  final EventSelectionService _eventSelection;
  final TimelineRepository _timelineRepository;
  final FinancialLedgerRepository _ledgerRepository;

  AgeUpResult execute(Character character) {
    final targetYearId = 'year-${character.lifeSeed}-${character.age + 1}';
    if (character.committedYearIds.contains(targetYearId)) {
      throw StateError('Year transaction already committed.');
    }
    final previousStage = character.lifeStage;
    final previousCash = character.cash;
    final previousDebt = character.debt;
    final logLength = character.lifeLog.length;

    character.ensureFamilySeeded();
    character.age++;
    character.expireConsequences();
    final random = Random(character.lifeSeed ^ (character.age * 104729));
    final transactions = <FinancialTransaction>[];
    var cashBeforeStep = character.cash;
    const FamilyProgressionService().progress(character, random);
    _recordCashChange(
      transactions,
      character,
      cashBeforeStep,
      TransactionCategory.family,
      'Family support and funeral contributions',
      'family',
    );
    character.resetActionEnergy();

    _progressHealth(character, random);
    final illnessResult = const IllnessProgressionService().progress(
      character,
      random,
    );
    transactions.addAll(illnessResult.transactions);
    if (character.isEnrolled) {
      cashBeforeStep = character.cash;
      SchoolService.progressSchool(character);
      _recordCashChange(
        transactions,
        character,
        cashBeforeStep,
        TransactionCategory.education,
        'Education fees',
        'education',
      );
    }
    if (CareerService.checkPromotion(character, random: random)) {
      CareerService.applyPromotion(character);
    }

    final employmentIncome = character.monthlyIncome * 12;
    final sideGigIncome = character.sideGigIncome * 12;
    character.adjustCash(employmentIncome + sideGigIncome);
    if (employmentIncome != 0) {
      transactions.add(
        FinancialTransaction(
          id: 'employment-${character.lifeSeed}-${character.age}',
          category: TransactionCategory.employmentIncome,
          amount: employmentIncome,
          age: character.age,
          description: 'Employment income',
          sourceId: character.careerPath,
        ),
      );
    }
    if (sideGigIncome != 0) {
      transactions.add(
        FinancialTransaction(
          id: 'side-gig-${character.lifeSeed}-${character.age}',
          category: TransactionCategory.sideGigIncome,
          amount: sideGigIncome,
          age: character.age,
          description: 'Side-gig income',
        ),
      );
    }

    final debtInterest = character.debt > 0
        ? max(1, (character.debt * 0.08).ceil())
        : 0;
    if (debtInterest > 0) {
      character.adjustDebt(debtInterest);
      character.adjustStat('happiness', -2);
      character.adjustStat('money', -1);
      transactions.add(
        FinancialTransaction(
          id: 'debt-interest-${character.lifeSeed}-${character.age}',
          category: TransactionCategory.debtInterest,
          amount: 0,
          age: character.age,
          description: 'GHS $debtInterest added to outstanding debt',
        ),
      );
    }

    if (_hasPartner(character)) {
      cashBeforeStep = character.cash;
      RelationshipService.progressRelationship(
        character,
        random: random,
        persist: false,
      );
      if (character.relationshipScore <= 0) {
        RelationshipService.divorce(character, persist: false);
      }
      _recordCashChange(
        transactions,
        character,
        cashBeforeStep,
        TransactionCategory.other,
        'Relationship costs',
        'relationship',
      );
    }

    cashBeforeStep = character.cash;
    HousingService.progressHousing(character);
    _recordCashChange(
      transactions,
      character,
      cashBeforeStep,
      TransactionCategory.housing,
      'Housing costs',
      'housing',
    );
    cashBeforeStep = character.cash;
    _progressChildCosts(character);
    _recordCashChange(
      transactions,
      character,
      cashBeforeStep,
      TransactionCategory.children,
      'Child support and care',
      'children',
    );
    final businessResult = const TypedBusinessService().progress(
      character,
      random,
    );
    transactions.addAll(businessResult.transactions);
    _synchroniseFlags(character);
    LifeGoalService.updateGoalProgress(character);

    final totalIncome = transactions
        .where((transaction) => transaction.amount > 0)
        .fold<int>(0, (sum, transaction) => sum + transaction.amount);
    final netCashChange = character.cash - previousCash;
    final expenses = transactions
        .where((transaction) => transaction.amount < 0)
        .fold<int>(0, (sum, transaction) => sum + transaction.amount.abs());
    final ledgerNet = transactions.fold<int>(
      0,
      (sum, transaction) => sum + transaction.amount,
    );
    if (ledgerNet != netCashChange) {
      transactions.add(
        FinancialTransaction(
          id: 'reconciliation-${character.lifeSeed}-${character.age}',
          category: TransactionCategory.other,
          amount: netCashChange - ledgerNet,
          age: character.age,
          description: 'Annual cash reconciliation',
        ),
      );
    }
    _ledgerRepository.appendAll(character, transactions);
    character.committedYearIds.add(targetYearId);

    final entries = <TimelineEntry>[
      TimelineEntry(
        id: 'year-${character.lifeSeed}-${character.age}',
        age: character.age,
        type: TimelineEntryType.milestone,
        title: 'Age ${character.age}',
        body: _yearOpening(character),
        isImportant: previousStage != character.lifeStage,
      ),
      TimelineEntry(
        id: 'finance-${character.lifeSeed}-${character.age}',
        age: character.age,
        type: TimelineEntryType.finance,
        title: 'Year in Review',
        body:
            'Income GHS $totalIncome · Expenses GHS $expenses · '
            'Cash change ${netCashChange >= 0 ? '+' : ''}GHS $netCashChange',
        deltas: [
          TimelineDelta(label: 'Cash', amount: netCashChange, isCurrency: true),
          if (character.debt != previousDebt)
            TimelineDelta(
              label: 'Debt',
              amount: character.debt - previousDebt,
              isCurrency: true,
            ),
        ],
      ),
    ];

    final newLogs = character.lifeLog
        .take(character.lifeLog.length - logLength)
        .toList()
        .reversed;
    var logIndex = 0;
    for (final log in newLogs) {
      entries.add(
        TimelineEntry(
          id: 'passive-${character.lifeSeed}-${character.age}-${logIndex++}',
          age: character.age,
          type: TimelineEntryType.story,
          title: 'Life moved forward',
          body: log.replaceFirst(RegExp(r'^Age \d+:\s*'), ''),
        ),
      );
    }
    for (final entry in entries) {
      _timelineRepository.add(character, entry);
    }

    final decisions = character.isDead
        ? <LifeEvent>[]
        : _eventSelection.select(
            character: character,
            events: allEvents,
            random: random,
          );
    character.pendingDecisionIds = decisions
        .map((event) => event.stableId)
        .toList();

    return AgeUpResult(
      decisions: decisions,
      entries: entries,
      finances: FinancialYearSummary(
        income: totalIncome,
        expenses: expenses,
        debtInterest: debtInterest,
        netCashChange: netCashChange,
      ),
      stageChanged: previousStage != character.lifeStage,
      transactions: transactions,
    );
  }

  void _recordCashChange(
    List<FinancialTransaction> transactions,
    Character character,
    int cashBefore,
    TransactionCategory category,
    String description,
    String sourceId,
  ) {
    final amount = character.cash - cashBefore;
    if (amount == 0) return;
    transactions.add(
      FinancialTransaction(
        id:
            '${category.name}-${character.lifeSeed}-${character.age}-'
            '$sourceId',
        category: category,
        amount: amount,
        age: character.age,
        description: description,
        sourceId: sourceId,
      ),
    );
  }

  void _progressHealth(Character character, Random random) {
    final age = character.age;
    final decay = age >= 80
        ? 4
        : age >= 65
        ? 3
        : age >= 50
        ? 2
        : age >= 40
        ? 1
        : 0;
    character.adjustStat('health', -decay);

    final risk = age >= 90
        ? 0.32
        : age >= 80
        ? 0.20
        : age >= 65
        ? 0.10
        : age >= 50
        ? 0.05
        : 0.0;
    if (random.nextDouble() < risk) {
      final impact = age >= 80
          ? 12
          : age >= 65
          ? 8
          : 5;
      character.adjustStat('health', -impact);
      character.lifeLog.insert(
        0,
        'Age $age: A serious health scare took $impact points from your health.',
      );
    }
  }

  void _progressChildCosts(Character character) {
    if (character.numberOfChildren <= 0) return;
    final cost = character.numberOfChildren * 1200;
    final paid = min(cost, character.cash);
    character.adjustCash(-paid);
    if (paid < cost) {
      character.adjustDebt(cost - paid);
      character.adjustStat('happiness', -3);
    }
  }

  void _synchroniseFlags(Character character) {
    if (character.debt > 0) {
      character.addFlag('in_debt');
    } else {
      character.removeFlag('in_debt');
    }
    if (character.cash < 1000) {
      character.addFlag('low_cash');
    } else {
      character.removeFlag('low_cash');
    }
    if (character.numberOfChildren > 0) {
      character.addFlag('has_children');
    } else {
      character.removeFlag('has_children');
    }
  }

  bool _hasPartner(Character character) =>
      character.relationshipStatus == 'Dating' ||
      character.relationshipStatus == 'Engaged' ||
      character.relationshipStatus == 'Married';

  String _yearOpening(Character character) {
    if (character.age == 5) {
      return 'School age arrived, and your world widened.';
    }
    if (character.age == 13) return 'Your teenage years began.';
    if (character.age == 18) return 'Adulthood opened new paths and pressures.';
    if (character.age == 60) return 'Your senior years began.';
    return 'Another chapter of your Ghanaian life began.';
  }
}
