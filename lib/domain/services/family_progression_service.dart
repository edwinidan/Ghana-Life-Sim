import 'dart:math';

import '../../models/character.dart';
import '../models/person_state.dart';

class FamilyProgressionResult {
  const FamilyProgressionResult({
    this.deaths = const [],
    this.childMilestones = const [],
    this.funeralCosts = 0,
  });

  final List<PersonState> deaths;
  final List<String> childMilestones;
  final int funeralCosts;
}

class FamilyProgressionService {
  const FamilyProgressionService();

  FamilyProgressionResult progress(Character character, Random random) {
    character.ensureFamilySeeded();
    character.ageFamily();
    character.ageChildren();

    final deaths = <PersonState>[];
    var funeralCosts = 0;
    for (var index = 0; index < character.familyNames.length; index++) {
      if (index >= character.familyAlive.length ||
          !character.familyAlive[index]) {
        continue;
      }
      final age = character.familyAges[index];
      final annualRisk = age >= 95
          ? 0.28
          : age >= 85
          ? 0.12
          : age >= 75
          ? 0.045
          : age >= 65
          ? 0.018
          : 0.002;
      if (random.nextDouble() >= annualRisk) continue;

      character.familyAlive[index] = false;
      final person = PersonState(
        id: 'family-${character.lifeSeed}-$index',
        name: character.familyNames[index],
        relationType: character.familyRelations[index],
        age: age,
        alive: false,
        bond: character.familyBondScores[index],
      );
      deaths.add(person);
      character.adjustStat('happiness', -(6 + person.bond ~/ 15));

      final contribution = min(5000, 800 + person.bond * 30);
      final paid = min(contribution, character.cash);
      character.adjustCash(-paid);
      if (paid < contribution) {
        character.adjustDebt(contribution - paid);
      }
      funeralCosts += contribution;
      character.lifeLog.insert(
        0,
        'Age ${character.age}: Your ${person.relationType.toLowerCase()}, '
        '${person.name}, died at age $age. You contributed GHS $contribution '
        'toward the funeral and carried the grief into the year.',
      );
    }

    final milestones = <String>[];
    for (var index = 0; index < character.childNames.length; index++) {
      final age = character.childAges[index];
      final milestone = switch (age) {
        6 => '${character.childNames[index]} started primary school.',
        13 => '${character.childNames[index]} entered the teenage years.',
        18 => '${character.childNames[index]} became an adult.',
        _ => null,
      };
      if (milestone != null) {
        milestones.add(milestone);
        character.lifeLog.insert(0, 'Age ${character.age}: $milestone');
      }
      final drift = random.nextInt(5) - 2;
      character.childBondScores[index] =
          (character.childBondScores[index] + drift).clamp(0, 100);
    }

    return FamilyProgressionResult(
      deaths: deaths,
      childMilestones: milestones,
      funeralCosts: funeralCosts,
    );
  }

  List<PersonState> people(Character character) {
    final people = <PersonState>[];
    for (var index = 0; index < character.familyNames.length; index++) {
      people.add(
        PersonState(
          id: 'family-${character.lifeSeed}-$index',
          name: character.familyNames[index],
          relationType: character.familyRelations[index],
          age: character.familyAges[index],
          alive:
              index >= character.familyAlive.length ||
              character.familyAlive[index],
          bond: character.familyBondScores[index],
        ),
      );
    }
    for (var index = 0; index < character.childNames.length; index++) {
      people.add(
        PersonState(
          id: 'child-${character.lifeSeed}-$index',
          name: character.childNames[index],
          relationType: 'Child',
          age: character.childAges[index],
          alive: true,
          bond: character.childBondScores[index],
        ),
      );
    }
    return people;
  }
}
