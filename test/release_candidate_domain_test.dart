import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ghana_life_sim/data/consequence_events.dart';
import 'package:ghana_life_sim/data/careers.dart';
import 'package:ghana_life_sim/data/migrations/save_migrator.dart';
import 'package:ghana_life_sim/domain/repositories/financial_ledger_repository.dart';
import 'package:ghana_life_sim/domain/repositories/timeline_repository.dart';
import 'package:ghana_life_sim/domain/services/event_selection_service.dart';
import 'package:ghana_life_sim/domain/use_cases/age_up_use_case.dart';
import 'package:ghana_life_sim/models/character.dart';
import 'package:ghana_life_sim/services/save_service.dart';
import 'package:ghana_life_sim/services/activity_service.dart';
import 'package:ghana_life_sim/services/job_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const timeline = TimelineRepository();
  const selector = EventSelectionService();
  const useCase = AgeUpUseCase(
    eventSelection: selector,
    timelineRepository: timeline,
  );

  test('annual ledger equals committed cash movement exactly', () {
    final character = Character(name: 'Ledger', gender: 'Female')
      ..lifeSeed = 4242
      ..age = 25
      ..cash = 9000
      ..monthlyIncome = 2200
      ..sideGigIncome = 400
      ..debt = 1200;
    final before = character.cash;

    final result = useCase.execute(character);
    final ledger = const FinancialLedgerRepository().read(
      character,
      age: character.age,
    );

    expect(
      ledger.fold<int>(0, (sum, transaction) => sum + transaction.amount),
      character.cash - before,
    );
    expect(
      result.transactions.map((item) => item.id).toSet().length,
      result.transactions.length,
    );
  });

  test('committed year cannot be applied a second time', () {
    final character = Character(name: 'Once', gender: 'Male')
      ..lifeSeed = 55
      ..age = 20
      ..committedYearIds = ['year-55-21'];

    expect(() => useCase.execute(character), throwsStateError);
    expect(character.age, 20);
  });

  test('debt repayment activity recovers without overpaying', () {
    final character = Character(name: 'Recovery', gender: 'Male')
      ..age = 25
      ..cash = 1000
      ..debt = 300;
    final option = ActivityService.options.firstWhere(
      (activity) => activity.id == 'debt_repayment',
    );

    final result = ActivityService.performActivity(character, option);

    expect(result.success, isTrue);
    expect(character.cash, 700);
    expect(character.debt, 0);
  });

  test('every major career path is reachable by a qualified graduate', () {
    final character = Character(name: 'Qualified', gender: 'Female')
      ..age = 25
      ..educationLevel = 'University'
      ..health = 100
      ..happiness = 100
      ..smarts = 100
      ..looks = 100
      ..money = 100
      ..reputation = 100
      ..discipline = 100
      ..streetSense = 100
      ..connections = 100;

    expect(
      JobService.getAvailableJobs(character).map((career) => career.name),
      containsAll(allCareers.map((career) => career.name)),
    );
  });

  test('required decisions persist as stable IDs after age-up', () {
    final character = Character(name: 'Pending', gender: 'Female')
      ..lifeSeed = 8
      ..age = 20;

    final result = useCase.execute(character);

    expect(
      character.pendingDecisionIds,
      result.decisions.map((event) => event.stableId),
    );
  });

  test('consequence delay and expiry rules are deterministic', () {
    final character = Character(name: 'Chain', gender: 'Male')
      ..age = 20
      ..lifeSeed = 9;
    character.addTimedFlag('family_disappointed', 4);
    final followUp = consequenceEvents.firstWhere(
      (event) => event.id == 'family.old_disappointment.v1',
    );

    character.age = 21;
    expect(
      selector.select(
        character: character,
        events: [followUp],
        random: Random(1),
      ),
      isEmpty,
    );
    character.age = 22;
    expect(
      selector.select(
        character: character,
        events: [followUp],
        random: Random(1),
      ),
      isNotEmpty,
    );
    character.age = 24;
    character.expireConsequences();
    expect(character.hasFlag('family_disappointed'), isFalse);
  });

  test('migration failure restores the pre-migration save', () async {
    final directory = await Directory.systemTemp.createTemp(
      'ghana_life_migration_failure_',
    );
    try {
      await SaveService.initForTests(directory.path);
      final character = Character(name: 'Safe', gender: 'Female')
        ..schemaVersion = 2
        ..cash = 7777;

      await expectLater(
        SaveService.saveGame(character, migrator: _FailingMigrator()),
        throwsStateError,
      );
      final restored = await SaveService.loadGame();
      expect(restored, isNotNull);
      expect(restored!.name, 'Safe');
      expect(restored.cash, 7777);
    } finally {
      await Hive.close();
      await directory.delete(recursive: true);
    }
  });
}

class _FailingMigrator extends SaveMigrator {
  _FailingMigrator() : super(const TimelineRepository());

  @override
  bool migrate(Character character) {
    character.cash = 0;
    throw StateError('Injected migration failure');
  }
}
