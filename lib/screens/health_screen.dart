import 'dart:math';

import 'package:flutter/material.dart';

import '../app/theme/app_theme.dart';
import '../data/illnesses.dart';
import '../domain/models/illness_state.dart';
import '../domain/repositories/financial_ledger_repository.dart';
import '../domain/repositories/illness_state_repository.dart';
import '../domain/services/illness_progression_service.dart';
import '../models/character.dart';
import '../services/save_service.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  final Character character;
  final VoidCallback onCharacterUpdated;

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  List<ActiveIllnessState> get _illnesses =>
      const IllnessStateRepository().read(widget.character);

  @override
  Widget build(BuildContext context) {
    final active = _illnesses.where((illness) => !illness.resolved).toList();
    final resolved = _illnesses.where((illness) => illness.resolved).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Health & Treatment')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          Semantics(
            label: 'Health, ${widget.character.health} out of 100',
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Health ${widget.character.health}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: widget.character.health / 100,
                      minHeight: 10,
                      color: AppColors.green,
                      backgroundColor: AppColors.divider,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Active conditions',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (active.isEmpty)
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.health_and_safety_outlined),
              title: Text('No diagnosed active condition'),
              subtitle: Text('Health events and ageing can change this.'),
            )
          else
            ...active.map(_conditionCard),
          if (resolved.isNotEmpty) ...[
            const SizedBox(height: 22),
            Text('Resolved', style: Theme.of(context).textTheme.titleMedium),
            ...resolved.map(
              (illness) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.check_circle_outline),
                title: Text(
                  illnessById(illness.illnessDefinitionId).displayName,
                ),
                subtitle: Text('${illness.yearsActive} years active'),
              ),
            ),
          ],
          const SizedBox(height: 16),
          const Text(
            'Health outcomes in Ghana Life Sim are fictional game mechanics, '
            'not medical advice.',
            style: TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _conditionCard(ActiveIllnessState illness) {
    final definition = illnessById(illness.illnessDefinitionId);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    definition.displayName,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  definition.chronic ? 'Chronic' : 'Acute',
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Diagnosed at age ${illness.diagnosedAtAge} · '
              '${illness.treatmentStatus.name}',
            ),
            if (definition.treatments.isNotEmpty) ...[
              const SizedBox(height: 14),
              ...definition.treatments.map(
                (treatment) => FilledButton.tonal(
                  onPressed: () => _treat(illness, treatment),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(46),
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text('${treatment.name} · GHS ${treatment.cost}'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _treat(
    ActiveIllnessState illness,
    TreatmentOption treatment,
  ) async {
    final result = const IllnessProgressionService().treat(
      character: widget.character,
      illnessId: illness.id,
      treatmentId: treatment.id,
      random: Random(
        widget.character.lifeSeed ^
            widget.character.age ^
            illness.history.length,
      ),
    );
    if (result.transaction != null) {
      const FinancialLedgerRepository().appendAll(widget.character, [
        result.transaction!,
      ]);
    }
    if (result.success) await SaveService.saveGame(widget.character);
    if (!mounted) return;
    setState(() {});
    widget.onCharacterUpdated();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result.message)));
  }
}
