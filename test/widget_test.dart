import 'package:flutter_test/flutter_test.dart';
import 'package:ghana_life_sim/models/character.dart';
import 'package:ghana_life_sim/services/activity_service.dart';
import 'package:ghana_life_sim/services/health_service.dart';

void main() {
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
}
