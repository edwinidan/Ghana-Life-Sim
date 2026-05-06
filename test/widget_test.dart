import 'package:flutter_test/flutter_test.dart';
import 'package:ghana_life_sim/models/character.dart';

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
}
