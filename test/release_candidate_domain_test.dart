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
import 'package:ghana_life_sim/services/school_service.dart';
import 'package:ghana_life_sim/services/career_service.dart';
import 'package:ghana_life_sim/data/education.dart';
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

  test('every major career path is reachable with the right qualification', () {
    const specializations = {
      'Healthcare': 'Health Sciences',
      'Education': 'Education',
      'Tech': 'Engineering & Technology',
      'Commerce': 'Business & Administration',
      'Sports & Media': 'Arts, Media & Sport',
    };
    for (final career in allCareers) {
      final character = Character(name: 'Qualified', gender: 'Female')
        ..age = 25
        ..educationLevel = 'University'
        ..educationSpecialization = specializations[career.name] ?? ''
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
        JobService.getAvailableJobs(character).map((item) => item.name),
        contains(career.name),
        reason: '${career.name} should be reachable',
      );
    }
  });

  test('locked jobs explain missing specialization and stats', () {
    final character = Character(name: 'Applicant', gender: 'Male')
      ..age = 22
      ..educationLevel = 'University'
      ..educationSpecialization = 'Business & Administration'
      ..smarts = 45
      ..health = 40;

    final healthcare = JobService.getJobListings(
      character,
    ).firstWhere((listing) => listing.career.name == 'Healthcare');

    expect(healthcare.isEligible, isFalse);
    expect(healthcare.reasons.join(' '), contains('Health Sciences'));
    expect(healthcare.reasons.join(' '), contains('Health needs'));
  });

  test('NSS placement records experience and a retention advantage', () {
    final character = Character(name: 'Service', gender: 'Female')
      ..age = 23
      ..educationLevel = 'University'
      ..educationSpecialization = 'Health Sciences';
    final programme = allPrograms.firstWhere((item) => item.id == 'nss_health');

    SchoolService.enroll(character, programme);
    SchoolService.progressSchool(character);

    expect(character.nssPlacement, 'Health Service');
    expect(character.hasFlag('nss_completed'), isTrue);
    expect(character.hasFlag('nss_retention_Healthcare'), isTrue);
  });

  test('graduates cannot re-enrol in lower education levels', () {
    final character = Character(name: 'Graduate', gender: 'Male')
      ..age = 24
      ..educationLevel = 'University'
      ..educationSpecialization = 'Health Sciences'
      ..smarts = 100;

    final programmes = SchoolService.getAvailablePrograms(character);

    expect(programmes.map((item) => item.id), isNot(contains('primary')));
    expect(programmes.map((item) => item.id), isNot(contains('jhs')));
    expect(programmes.every((item) => item.id.startsWith('nss_')), isTrue);
  });

  test('merit aid reduces fees without erasing the education cost', () {
    final programme = allPrograms.firstWhere(
      (item) => item.id == 'university_business',
    );
    final student = Character(name: 'Scholar', gender: 'Female')..smarts = 85;

    final fullCost = SchoolService.programYearlyCashCost(programme);
    final supportedCost = SchoolService.programYearlyCashCost(
      programme,
      character: student,
    );

    expect(supportedCost, lessThan(fullCost));
    expect(supportedCost, greaterThan(0));
  });

  test('career performance supports reviews and retirement pension', () {
    final character = Character(name: 'Worker', gender: 'Male')
      ..age = 60
      ..educationLevel = 'University'
      ..educationSpecialization = 'Engineering & Technology'
      ..smarts = 100
      ..connections = 100;
    CareerService.enterCareer(character, 'Tech');
    character.jobPerformance = 80;

    final review = JobService.requestCareerReview(character, random: Random(1));
    expect(review, isNot(CareerReviewResult.unavailable));
    expect(JobService.retire(character), isTrue);
    expect(character.employmentStatus, 'Retired');
    expect(character.monthlyPension, greaterThan(0));
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
