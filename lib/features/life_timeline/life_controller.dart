import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/migrations/save_migrator.dart';
import '../../data/events.dart';
import '../../domain/models/timeline_entry.dart';
import '../../domain/errors/app_failure.dart';
import '../../domain/repositories/timeline_repository.dart';
import '../../domain/services/event_selection_service.dart';
import '../../domain/use_cases/age_up_use_case.dart';
import '../../models/character.dart';
import '../../models/event.dart';
import '../../services/event_choice_service.dart';
import '../../services/health_service.dart';
import '../../services/save_service.dart';

final timelineRepositoryProvider = Provider<TimelineRepository>(
  (ref) => const TimelineRepository(),
);

final saveMigratorProvider = Provider<SaveMigrator>(
  (ref) => SaveMigrator(ref.watch(timelineRepositoryProvider)),
);

final eventSelectionProvider = Provider<EventSelectionService>(
  (ref) => const EventSelectionService(),
);

final ageUpUseCaseProvider = Provider<AgeUpUseCase>(
  (ref) => AgeUpUseCase(
    eventSelection: ref.watch(eventSelectionProvider),
    timelineRepository: ref.watch(timelineRepositoryProvider),
  ),
);

final lifeControllerProvider = StateNotifierProvider.autoDispose
    .family<LifeController, LifeState, Character>(
      (ref, character) => LifeController(
        character: character,
        ageUp: ref.watch(ageUpUseCaseProvider),
        timelineRepository: ref.watch(timelineRepositoryProvider),
      ),
    );

class LifeState {
  const LifeState({
    required this.character,
    required this.timeline,
    this.pendingDecisions = const [],
    this.isBusy = false,
    this.errorMessage,
  });

  final Character character;
  final List<TimelineEntry> timeline;
  final List<LifeEvent> pendingDecisions;
  final bool isBusy;
  final String? errorMessage;

  LifeEvent? get currentDecision =>
      pendingDecisions.isEmpty ? null : pendingDecisions.first;

  LifeState copyWith({
    Character? character,
    List<TimelineEntry>? timeline,
    List<LifeEvent>? pendingDecisions,
    bool? isBusy,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LifeState(
      character: character ?? this.character,
      timeline: timeline ?? this.timeline,
      pendingDecisions: pendingDecisions ?? this.pendingDecisions,
      isBusy: isBusy ?? this.isBusy,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class LifeController extends StateNotifier<LifeState> {
  LifeController({
    required Character character,
    required AgeUpUseCase ageUp,
    required TimelineRepository timelineRepository,
  }) : _ageUp = ageUp,
       _timelineRepository = timelineRepository,
       super(
         LifeState(
           character: character,
           timeline: timelineRepository.read(character),
           pendingDecisions: character.pendingDecisionIds
               .map((id) => allEvents.where((event) => event.stableId == id))
               .where((matches) => matches.isNotEmpty)
               .map((matches) => matches.first)
               .toList(),
         ),
       );

  final AgeUpUseCase _ageUp;
  final TimelineRepository _timelineRepository;

  Future<void> ageUp() async {
    if (state.isBusy || state.pendingDecisions.isNotEmpty) return;
    state = state.copyWith(isBusy: true, clearError: true);
    try {
      final workingCharacter = state.character.detachedCopy();
      final result = _ageUp.execute(workingCharacter);
      if (workingCharacter.isDead && workingCharacter.causeOfDeath.isEmpty) {
        workingCharacter.causeOfDeath = HealthService.determineCauseOfDeath(
          workingCharacter,
        );
        workingCharacter.isAlive = false;
      }
      await SaveService.saveGame(workingCharacter);
      state = state.copyWith(
        character: workingCharacter,
        timeline: _timelineRepository.read(workingCharacter),
        pendingDecisions: result.decisions,
        isBusy: false,
      );
    } catch (error) {
      final failure = AppFailure.ageUp(error);
      state = state.copyWith(isBusy: false, errorMessage: failure.userMessage);
    }
  }

  Future<void> choose(EventChoice choice) async {
    final event = state.currentDecision;
    if (event == null || state.isBusy) return;

    state = state.copyWith(isBusy: true, clearError: true);
    final character = state.character.detachedCopy();
    final before = _snapshot(character);
    try {
      EventChoiceService.applyChoice(character, choice);
      final choiceId = choice.id ?? _slug(choice.text);
      character.eventHistory.add('${character.age}:${event.stableId}');
      character.choiceHistory.add(
        '${character.age}:${event.stableId}:$choiceId',
      );
      character.lifeLog.insert(
        0,
        'Age ${character.age}: ${event.title} — ${choice.outcome}',
      );

      _timelineRepository.add(
        character,
        TimelineEntry(
          id:
              'outcome-${character.lifeSeed}-${character.age}-'
              '${character.choiceHistory.length}',
          age: character.age,
          type: TimelineEntryType.outcome,
          title: event.title,
          body: choice.outcome,
          sourceEventId: event.stableId,
          deltas: _deltas(before, character),
          isImportant: event.priority > 0,
        ),
      );

      final remaining = state.pendingDecisions.skip(1).toList();
      character.pendingDecisionIds = remaining
          .map((pending) => pending.stableId)
          .toList();
      if (character.isDead && character.causeOfDeath.isEmpty) {
        character.causeOfDeath = HealthService.determineCauseOfDeath(character);
        character.isAlive = false;
      }
      await SaveService.saveGame(character);
      state = state.copyWith(
        timeline: _timelineRepository.read(character),
        pendingDecisions: remaining,
        isBusy: false,
      );
    } catch (error) {
      final failure = AppFailure.save(error);
      state = state.copyWith(isBusy: false, errorMessage: failure.userMessage);
    }
  }

  Future<void> refresh() async {
    await SaveService.saveGame(state.character);
    state = state.copyWith(
      timeline: _timelineRepository.read(state.character),
      clearError: true,
    );
  }

  Future<void> persistExternalMutation() async {
    if (state.isBusy) return;
    try {
      await SaveService.saveGame(state.character);
      state = state.copyWith(
        timeline: _timelineRepository.read(state.character),
        clearError: true,
      );
    } catch (error) {
      final failure = AppFailure.save(error);
      state = state.copyWith(errorMessage: failure.userMessage);
    }
  }

  Map<String, int> _snapshot(Character character) => {
    'Health': character.health,
    'Happiness': character.happiness,
    'Smarts': character.smarts,
    'Looks': character.looks,
    'Reputation': character.reputation,
    'Discipline': character.discipline,
    'Street sense': character.streetSense,
    'Connections': character.connections,
    'Cash': character.cash,
    'Debt': character.debt,
  };

  List<TimelineDelta> _deltas(Map<String, int> before, Character character) {
    final after = _snapshot(character);
    return before.entries
        .map(
          (entry) => TimelineDelta(
            label: entry.key,
            amount: (after[entry.key] ?? entry.value) - entry.value,
            isCurrency: entry.key == 'Cash' || entry.key == 'Debt',
          ),
        )
        .where((delta) => delta.amount != 0)
        .toList();
  }

  String _slug(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'^_+|_+$'), '');
}
