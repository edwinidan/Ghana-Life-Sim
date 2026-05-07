import 'package:flutter_test/flutter_test.dart';
import 'package:ghana_life_sim/models/character.dart';
import 'package:ghana_life_sim/services/activity_service.dart';
import 'package:ghana_life_sim/services/health_service.dart';
import 'package:ghana_life_sim/services/life_goal_service.dart';
import 'package:ghana_life_sim/services/meta_progress_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
}
