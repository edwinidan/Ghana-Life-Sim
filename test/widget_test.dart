import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ghana_life_sim/models/character.dart';
import 'package:ghana_life_sim/models/event.dart';
import 'package:ghana_life_sim/services/activity_service.dart';
import 'package:ghana_life_sim/services/event_choice_service.dart';
import 'package:ghana_life_sim/services/health_service.dart';
import 'package:ghana_life_sim/services/life_goal_service.dart';
import 'package:ghana_life_sim/services/meta_progress_service.dart';
import 'package:ghana_life_sim/services/save_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('character creation creates a valid new life', () {
    final character = Character(name: 'Akua', gender: 'Female');

    expect(character.name, 'Akua');
    expect(character.gender, 'Female');
    expect(character.age, 0);
    expect(character.isAlive, isTrue);
    expect(character.cash, greaterThanOrEqualTo(400));
    expect(character.health, inInclusiveRange(60, 90));
    expect(character.familyNames, isNotEmpty);
  });

  test('age-up basics increase age and keep action energy usable', () {
    final character = Character(name: 'Yaw', gender: 'Male');
    final previousAge = character.age;

    character.age++;
    character.resetActionEnergy();

    expect(character.age, previousAge + 1);
    expect(character.actionEnergy, greaterThan(0));
    expect(() => character.ageFamily(), returnsNormally);
    expect(() => character.ageChildren(), returnsNormally);
  });

  test('event choices apply stat, cash, debt, flag, and status changes', () {
    final character = Character(name: 'Afia', gender: 'Female');
    character.cash = 1000;
    character.debt = 100;
    character.addFlag('temporary_pressure');

    const choice = EventChoice(
      text: 'Help at the community durbar',
      statChanges: {'reputation': 6, 'happiness': 3},
      outcome: 'People remembered your name.',
      relationshipStatusToSet: 'Dating',
      housingStatusToSet: 'Renting',
      flagToAdd: 'community_helper',
      flagToRemove: 'temporary_pressure',
      cashChange: -200,
      debtChange: 50,
    );

    EventChoiceService.applyChoice(character, choice);

    expect(character.reputation, greaterThanOrEqualTo(26));
    expect(character.happiness, greaterThanOrEqualTo(53));
    expect(character.cash, 800);
    expect(character.debt, 150);
    expect(character.relationshipStatus, 'Dating');
    expect(character.housingStatus, 'Renting');
    expect(character.hasFlag('community_helper'), isTrue);
    expect(character.hasFlag('temporary_pressure'), isFalse);
  });

  test('character tracks cash, debt, flags, and children', () {
    final character = Character(name: 'Akosua', gender: 'Female');

    character.adjustCash(500);
    character.adjustDebt(1200);
    character.addFlag('in_debt');
    character.addChild(name: 'Ama', gender: 'girl');
    character.ageChildren();

    expect(character.cash, greaterThanOrEqualTo(500));
    expect(character.debt, 1200);
    expect(character.hasFlag('in_debt'), isTrue);
    expect(character.numberOfChildren, 1);
    expect(character.childNames, contains('Ama'));
    expect(character.childAges.first, 1);
  });

  test('character tracks family, yearly action energy, and legacy ribbons', () {
    final character = Character(name: 'Kwame', gender: 'Male');
    character.age = 16;
    character.cash = 5000;
    character.actionEnergy = 3;
    character.ensureFamilySeeded();

    final result = ActivityService.performActivity(
      character,
      ActivityService.options.firstWhere(
        (option) => option.id == 'help_family',
      ),
    );

    expect(result.success, isTrue);
    expect(character.actionEnergy, 2);
    expect(character.familyNames, isNotEmpty);
    expect(character.averageFamilyBond, greaterThan(0));
    expect(HealthService.getLegacyRibbon(character), isNotEmpty);
  });

  test('activity failure does not consume action energy', () {
    final character = Character(name: 'Kofi', gender: 'Male');
    character.age = 10;
    character.actionEnergy = 1;

    final result = ActivityService.performActivity(
      character,
      ActivityService.options.firstWhere((option) => option.id == 'party'),
    );

    expect(result.success, isFalse);
    expect(character.actionEnergy, 1);
  });

  test('life goals complete and rotate to a new active goal', () {
    final character = Character(name: 'Esi', gender: 'Female');
    character.activeLifeGoalId = 'start_business';

    expect(LifeGoalService.updateGoalProgress(character), isFalse);

    character.businessNames.add('Esi Provisions');

    expect(LifeGoalService.updateGoalProgress(character), isTrue);
    expect(character.completedLifeGoalIds, contains('start_business'));
    expect(character.activeLifeGoalId, isNot('start_business'));
  });

  test(
    'meta progress records ribbons, achievements, goals, and lives',
    () async {
      SharedPreferences.setMockInitialValues({});
      final character = Character(name: 'Kojo', gender: 'Male');
      character.age = 90;
      character.cash = 120000;
      character.debt = 0;
      character.housingStatus = 'Homeowner';
      character.activeLifeGoalId = 'own_home';

      final rewards = await MetaProgressService.recordLifeCompletion(character);
      final snapshot = await MetaProgressService.loadSnapshot();

      expect(rewards.lifeCounted, isTrue);
      expect(snapshot.livesCompleted, 1);
      expect(snapshot.unlockedRibbons, isNotEmpty);
      expect(snapshot.completedLifeGoals, contains('own_home'));
      expect(snapshot.unlockedAchievements, contains('first_life_completed'));
      expect(snapshot.unlockedAchievements, contains('homeowner'));
      expect(snapshot.unlockedAchievements, contains('big_person'));
    },
  );

  test('death state and restart/new life are valid', () {
    final character = Character(name: 'Ato', gender: 'Male');
    character.age = 45;
    character.health = 0;
    character.causeOfDeath = HealthService.determineCauseOfDeath(character);

    expect(character.isDead, isTrue);
    expect(character.causeOfDeath, isNotEmpty);
    expect(
      HealthService.calculateLifeScore(character),
      inInclusiveRange(0, 100),
    );
    expect(HealthService.getLegacyRibbon(character), isNotEmpty);

    final restarted = Character(name: 'Ato Jr', gender: 'Male');

    expect(restarted.isDead, isFalse);
    expect(restarted.age, 0);
    expect(restarted.lifeLog, isEmpty);
  });

  test('save/load/delete cycle works', () async {
    final tempDir = await Directory.systemTemp.createTemp(
      'ghana_life_save_test_',
    );

    try {
      await SaveService.initForTests(tempDir.path);
      final character = Character(name: 'Nana', gender: 'Female')
        ..age = 22
        ..cash = 5000
        ..activeLifeGoalId = 'reach_100k_cash';

      await SaveService.saveGame(character);

      expect(SaveService.hasSavedGame(), isTrue);

      final loaded = await SaveService.loadGame();

      expect(loaded, isNotNull);
      expect(loaded!.name, 'Nana');
      expect(loaded.age, 22);
      expect(loaded.cash, 5000);
      expect(loaded.familyNames, isNotEmpty);

      await SaveService.deleteSave();

      expect(SaveService.hasSavedGame(), isFalse);
    } finally {
      await Hive.close();
      await tempDir.delete(recursive: true);
    }
  });
}
