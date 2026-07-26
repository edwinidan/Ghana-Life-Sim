import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ghana_life_sim/data/migrations/save_migrator.dart';
import 'package:ghana_life_sim/data/events.dart';
import 'package:ghana_life_sim/domain/models/timeline_entry.dart';
import 'package:ghana_life_sim/domain/models/business_state.dart';
import 'package:ghana_life_sim/domain/models/illness_state.dart';
import 'package:ghana_life_sim/domain/repositories/business_state_repository.dart';
import 'package:ghana_life_sim/domain/repositories/illness_state_repository.dart';
import 'package:ghana_life_sim/domain/repositories/timeline_repository.dart';
import 'package:ghana_life_sim/domain/services/event_selection_service.dart';
import 'package:ghana_life_sim/domain/services/illness_progression_service.dart';
import 'package:ghana_life_sim/domain/services/typed_business_service.dart';
import 'package:ghana_life_sim/domain/services/event_catalog_validator.dart';
import 'package:ghana_life_sim/domain/use_cases/age_up_use_case.dart';
import 'package:ghana_life_sim/models/character.dart';
import 'package:ghana_life_sim/models/event.dart';

void main() {
  const timelineRepository = TimelineRepository();
  const eventSelection = EventSelectionService();

  test('detached character copies do not mutate the source', () {
    final source = Character(name: 'Ama', gender: 'Female')
      ..cash = 2500
      ..flags = ['remember_me'];
    final copy = source.detachedCopy()
      ..cash = 10
      ..flags.add('copy_only');

    expect(source.cash, 2500);
    expect(source.flags, ['remember_me']);
    expect(copy.lifeSeed, source.lifeSeed);
  });

  test('save migration adds seed, origin, schema and birth timeline', () {
    final character = Character(name: 'Kojo', gender: 'Male')
      ..lifeSeed = 0
      ..birthYear = 0
      ..originSummary = ''
      ..timelineRecords = []
      ..schemaVersion = 1;

    final changed = SaveMigrator(timelineRepository).migrate(character);

    expect(changed, isTrue);
    expect(character.lifeSeed, isNonZero);
    expect(character.birthYear, isNonZero);
    expect(character.originSummary, isNotEmpty);
    expect(character.schemaVersion, 3);
    expect(
      timelineRepository.read(character).single.type,
      TimelineEntryType.birth,
    );
  });

  test('timeline entries encode and decode without losing deltas', () {
    const entry = TimelineEntry(
      id: 'test',
      age: 18,
      type: TimelineEntryType.finance,
      title: 'Year in Review',
      body: 'A financial year.',
      deltas: [TimelineDelta(label: 'Cash', amount: 500, isCurrency: true)],
    );

    final decoded = TimelineEntry.decode(entry.encode());

    expect(decoded.id, entry.id);
    expect(decoded.type, TimelineEntryType.finance);
    expect(decoded.deltas.single.amount, 500);
    expect(decoded.deltas.single.isCurrency, isTrue);
  });

  test('event cooldown and occurrence limits are enforced', () {
    final character = Character(name: 'Esi', gender: 'Female')..age = 20;
    const event = LifeEvent(
      id: 'test.once.v1',
      title: 'One time',
      description: 'Only once.',
      minAge: 18,
      maxAge: 30,
      baseWeight: 10,
      choices: [
        EventChoice(text: 'Continue', statChanges: {}, outcome: 'Done'),
      ],
    );

    expect(
      eventSelection.select(
        character: character,
        events: const [event],
        random: Random(1),
      ),
      isNotEmpty,
    );

    character.eventHistory.add('20:${event.stableId}');
    character.age = 25;
    expect(
      eventSelection.select(
        character: character,
        events: const [event],
        random: Random(1),
      ),
      isEmpty,
    );
  });

  test('age-up is deterministic for the same life seed and snapshot', () {
    final original = Character(name: 'Yaw', gender: 'Male')
      ..lifeSeed = 987654
      ..age = 19
      ..cash = 4000
      ..debt = 500
      ..health = 80
      ..timelineRecords = [];
    final first = original.detachedCopy();
    final second = original.detachedCopy();
    final useCase = AgeUpUseCase(
      eventSelection: eventSelection,
      timelineRepository: timelineRepository,
    );

    final firstResult = useCase.execute(first);
    final secondResult = useCase.execute(second);

    expect(second.age, first.age);
    expect(second.cash, first.cash);
    expect(second.debt, first.debt);
    expect(second.health, first.health);
    expect(
      secondResult.decisions.map((event) => event.stableId),
      firstResult.decisions.map((event) => event.stableId),
    );
    expect(second.timelineRecords, first.timelineRecords);
  });

  test('production event catalog has valid IDs and authoring structure', () {
    final issues = const EventCatalogValidator().validate(allEvents);

    expect(issues, isEmpty, reason: issues.take(20).join('\n'));
  });

  test('legacy businesses and illnesses migrate once into typed state', () {
    final character = Character(name: 'Adwoa', gender: 'Female')
      ..schemaVersion = 2
      ..businessNames = ['Adwoa Chop Bar']
      ..businessTypes = ['Chop Bar']
      ..businessHealthList = [72]
      ..businessIncomeList = [2500]
      ..activeIllnesses = ['Hypertension', 'Mystery Fever'];
    final migrator = SaveMigrator(timelineRepository);

    expect(migrator.migrate(character), isTrue);
    final businesses = const BusinessStateRepository().read(character);
    final illnesses = const IllnessStateRepository().read(character);
    expect(businesses, hasLength(1));
    expect(businesses.single.displayName, 'Adwoa Chop Bar');
    expect(illnesses, hasLength(2));
    expect(illnesses.first.illnessDefinitionId, 'hypertension');
    expect(illnesses.last.illnessDefinitionId, 'unknown_legacy_condition');

    final businessRecords = [...character.businessStateRecords];
    final illnessRecords = [...character.illnessStateRecords];
    expect(migrator.migrate(character), isFalse);
    expect(character.businessStateRecords, businessRecords);
    expect(character.illnessStateRecords, illnessRecords);
  });

  test('typed business annual outcome is deterministic and explainable', () {
    final first = Character(name: 'Kofi', gender: 'Male')
      ..age = 30
      ..cash = 10000
      ..businessStateRecords = [
        const BusinessState(
          id: 'business-1',
          definitionId: 'chop_bar',
          displayName: 'Kofi Foods',
          startedAtAge: 25,
          reputation: 65,
          risk: 35,
        ).encode(),
      ];
    final second = first.detachedCopy();

    final firstResult = const TypedBusinessService().progress(
      first,
      Random(42),
    );
    final secondResult = const TypedBusinessService().progress(
      second,
      Random(42),
    );

    expect(firstResult.outcomes.single.revenue, greaterThan(0));
    expect(firstResult.outcomes.single.expenses, greaterThan(0));
    expect(
      firstResult.outcomes.single.profit,
      firstResult.outcomes.single.revenue -
          firstResult.outcomes.single.expenses,
    );
    expect(
      secondResult.outcomes.single.profit,
      firstResult.outcomes.single.profit,
    );
    expect(second.cash, first.cash);
  });

  test('acute and chronic illness paths progress deterministically', () {
    final acute = Character(name: 'Ama', gender: 'Female')
      ..age = 28
      ..illnessStateRecords = [
        const ActiveIllnessState(
          id: 'acute',
          illnessDefinitionId: 'malaria',
          diagnosedAtAge: 27,
          treatmentStatus: TreatmentStatus.treated,
        ).encode(),
      ];
    final chronic = Character(name: 'Yaw', gender: 'Male')
      ..age = 50
      ..cash = 5000
      ..illnessStateRecords = [
        const ActiveIllnessState(
          id: 'chronic',
          illnessDefinitionId: 'hypertension',
          diagnosedAtAge: 45,
          treatmentStatus: TreatmentStatus.medication,
        ).encode(),
      ];

    const service = IllnessProgressionService();
    service.progress(acute, Random(1));
    service.progress(chronic, Random(1));

    expect(const IllnessStateRepository().read(acute).single.yearsActive, 1);
    expect(const IllnessStateRepository().read(chronic).single.yearsActive, 1);
    expect(chronic.cash, lessThan(5000));
  });
}
