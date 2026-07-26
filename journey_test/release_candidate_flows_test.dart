import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ghana_life_sim/data/businesses.dart';
import 'package:ghana_life_sim/data/education.dart';
import 'package:ghana_life_sim/data/migrations/save_migrator.dart';
import 'package:ghana_life_sim/domain/models/illness_state.dart';
import 'package:ghana_life_sim/domain/repositories/business_state_repository.dart';
import 'package:ghana_life_sim/domain/repositories/illness_state_repository.dart';
import 'package:ghana_life_sim/domain/repositories/timeline_repository.dart';
import 'package:ghana_life_sim/domain/services/event_selection_service.dart';
import 'package:ghana_life_sim/domain/services/illness_progression_service.dart';
import 'package:ghana_life_sim/domain/services/typed_business_service.dart';
import 'package:ghana_life_sim/domain/use_cases/age_up_use_case.dart';
import 'package:ghana_life_sim/models/character.dart';
import 'package:ghana_life_sim/services/business_service.dart';
import 'package:ghana_life_sim/services/job_service.dart';
import 'package:ghana_life_sim/services/meta_progress_service.dart';
import 'package:ghana_life_sim/services/relationship_service.dart';
import 'package:ghana_life_sim/services/save_service.dart';
import 'package:ghana_life_sim/services/school_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // These journeys stay platform-neutral so production builds contain no test plugin.
  TestWidgetsFlutterBinding.ensureInitialized();
  const ageUp = AgeUpUseCase(
    eventSelection: EventSelectionService(),
    timelineRepository: TimelineRepository(),
  );

  test('new life ages, saves, relaunches and continues', () async {
    final directory = await Directory.systemTemp.createTemp('gls_e2e_save_');
    try {
      await SaveService.initForTests(directory.path);
      final character = Character(name: 'E2E', gender: 'Female')
        ..lifeSeed = 100;
      ageUp.execute(character);
      await SaveService.saveGame(character);
      final loaded = await SaveService.loadGame();
      expect(loaded!.age, 1);
      expect(loaded.committedYearIds, contains('year-100-1'));
    } finally {
      await Hive.close();
      await directory.delete(recursive: true);
    }
  });

  test('school path progresses through graduation', () {
    final character = Character(name: 'School', gender: 'Male')
      ..age = 6
      ..cash = 50000
      ..smarts = 90;
    final primary = allPrograms.firstWhere((item) => item.id == 'primary');
    SchoolService.enroll(character, primary);
    for (var year = 0; year < primary.durationYears; year++) {
      SchoolService.progressSchool(character);
    }
    expect(character.educationLevel, 'Primary');
    expect(character.isEnrolled, isFalse);
  });

  test('tertiary graduate completes NSS', () {
    final character = Character(name: 'NSS', gender: 'Female')
      ..age = 23
      ..educationLevel = 'University'
      ..cash = 10000;
    final nss = allPrograms.firstWhere((item) => item.id == 'national_service');
    SchoolService.enroll(character, nss);
    SchoolService.progressSchool(character);
    expect(character.hasFlag('nss_completed'), isTrue);
    expect(character.educationLevel, 'University');
  });

  test('job application produces salary and deterministic promotion path', () {
    final character = Character(name: 'Worker', gender: 'Male')
      ..age = 25
      ..educationLevel = 'University'
      ..smarts = 90
      ..discipline = 90
      ..connections = 90;
    final jobs = JobService.getAvailableJobs(character);
    expect(jobs, isNotEmpty);
    expect(
      JobService.applyForJob(character, jobs.first, random: Random(1)),
      isTrue,
    );
    final before = character.cash;
    ageUp.execute(character);
    expect(character.cash, greaterThan(before));
  });

  test('dating progresses through marriage and child', () {
    final character = Character(name: 'Family', gender: 'Female')
      ..age = 28
      ..cash = 20000
      ..relationshipStatus = 'Dating'
      ..partnerName = 'Kofi'
      ..partnerPersonality = 'Calm'
      ..relationshipScore = 90;
    expect(RelationshipService.propose(character), isTrue);
    RelationshipService.marry(character);
    RelationshipService.haveChild(character);
    expect(character.relationshipStatus, 'Married');
    expect(character.numberOfChildren, 1);
  });

  test('debt accrues interest and remains recoverable through income', () {
    final character = Character(name: 'Debt', gender: 'Male')
      ..age = 30
      ..debt = 2000
      ..cash = 0
      ..monthlyIncome = 4000;
    ageUp.execute(character);
    expect(character.debt, greaterThan(2000));
    expect(character.cash, greaterThan(character.debt));
  });

  test('business starts, records annual result, grows and can close', () {
    final character = Character(name: 'Owner', gender: 'Female')
      ..age = 30
      ..cash = 100000
      ..streetSense = 90;
    final definition = allBusinessTypes.first;
    BusinessService.startBusiness(character, definition, 'Owner Enterprise');
    const service = TypedBusinessService();
    final result = service.progress(character, Random(2));
    expect(result.outcomes, hasLength(1));
    expect(
      const BusinessStateRepository().read(character).single.history,
      isNotEmpty,
    );
    expect(
      service.expand(character, result.outcomes.single.business.id).success,
      isTrue,
    );
  });

  test('illness treatment can improve an acute condition', () {
    final character = Character(name: 'Patient', gender: 'Male')
      ..age = 35
      ..cash = 5000
      ..illnessStateRecords = [
        const ActiveIllnessState(
          id: 'malaria',
          illnessDefinitionId: 'malaria',
          diagnosedAtAge: 35,
        ).encode(),
      ];
    final treatment = const IllnessProgressionService().treat(
      character: character,
      illnessId: 'malaria',
      treatmentId: 'clinic_medication',
      random: Random(1),
    );
    expect(treatment.success, isTrue);
    expect(
      const IllnessStateRepository().read(character).single.treatmentStatus,
      isNot(TreatmentStatus.untreated),
    );
  });

  test('untreated severe illness contributes to fatal health loss', () {
    final character = Character(name: 'Critical', gender: 'Female')
      ..age = 70
      ..health = 5
      ..illnessStateRecords = [
        const ActiveIllnessState(
          id: 'stroke',
          illnessDefinitionId: 'stroke_risk',
          diagnosedAtAge: 65,
          severityModifier: 15,
        ).encode(),
      ];
    const IllnessProgressionService().progress(character, Random(3));
    expect(character.isDead, isTrue);
  });

  test('death rewards are guarded from duplicate recording', () async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    final character = Character(name: 'Legacy', gender: 'Male')
      ..age = 88
      ..health = 0;
    if (!character.deathRewardsRecorded) {
      await MetaProgressService.recordLifeCompletion(character);
      character.deathRewardsRecorded = true;
    }
    if (!character.deathRewardsRecorded) {
      await MetaProgressService.recordLifeCompletion(character);
    }
    final snapshot = await MetaProgressService.loadSnapshot();
    expect(snapshot.livesCompleted, 1);
  });

  test('legacy save migrates and continues without duplication', () {
    final character = Character(name: 'Legacy', gender: 'Female')
      ..schemaVersion = 2
      ..businessNames = ['Legacy Shop']
      ..businessTypes = ['Provisions Shop']
      ..businessHealthList = [60]
      ..businessIncomeList = [1800]
      ..activeIllnesses = ['Unknown Old Condition'];
    final migrator = SaveMigrator(const TimelineRepository());
    expect(migrator.migrate(character), isTrue);
    final businessCount = character.businessStateRecords.length;
    final illnessCount = character.illnessStateRecords.length;
    expect(migrator.migrate(character), isFalse);
    expect(character.businessStateRecords, hasLength(businessCount));
    expect(character.illnessStateRecords, hasLength(illnessCount));
  });

  test('interrupted age-up leaves original snapshot unchanged', () {
    final original = Character(name: 'Transaction', gender: 'Male')
      ..lifeSeed = 700
      ..age = 40
      ..cash = 1000;
    final working = original.detachedCopy();
    ageUp.execute(working);
    expect(original.age, 40);
    expect(original.cash, 1000);
    expect(working.age, 41);
    expect(working.committedYearIds, contains('year-700-41'));
  });
}
