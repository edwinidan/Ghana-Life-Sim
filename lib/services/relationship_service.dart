import 'dart:math';
import '../models/character.dart';
import '../data/relationship_data.dart';

class RelationshipService {
  static final _random = Random();

  static String generatePotentialPartner(Character character) {
    final name = generatePartnerName(character.gender);
    final job = generatePartnerJob();
    final personality = generatePersonality();
    character.partnerName = name;
    character.partnerJob = job;
    character.partnerPersonality = personality;
    character.save();
    return name;
  }

  static bool askOut(Character character) {
    final looks = character.looks;
    final happiness = character.happiness;
    final chance = 50 + (looks - 40) * 1.0 + (happiness - 40) * 0.5;
    final roll = _random.nextInt(100);
    if (roll < chance) {
      character.relationshipStatus = 'Dating';
      character.relationshipScore = 50;
      character.lifeLog.insert(
        0,
        'Age ${character.age}: You asked ${character.partnerName} out. They said yes! Your mother will be pleased. 💕',
      );
      character.save();
      return true;
    } else {
      final failedName = character.partnerName;
      character.partnerName = '';
      character.partnerJob = '';
      character.partnerPersonality = '';
      character.lifeLog.insert(
        0,
        'Age ${character.age}: You asked $failedName out. They said no. Very painful. 😔',
      );
      character.save();
      return false;
    }
  }

  static void progressRelationship(Character character) {
    int drift = 0;
    switch (character.partnerPersonality) {
      case 'Clingy':
        drift = -3;
        break;
      case 'Jealous':
        drift = -2;
        break;
      case 'Calm':
        drift = 2;
        break;
      case 'Caring':
        drift = 2;
        break;
      default:
        drift = _random.nextInt(5) - 2; // -2 to +2
    }
    if (character.isCheating) {
      drift -= 5;
      // 15% chance of getting caught
      if (_random.nextInt(100) < 15) {
        getCaught(character);
        return;
      }
    }
    character.relationshipScore = (character.relationshipScore + drift).clamp(0, 100);
    character.save();
  }

  static bool propose(Character character) {
    if (character.relationshipStatus != 'Dating' ||
        character.age < 22 ||
        character.relationshipScore < 65) {
      return false;
    }
    character.relationshipStatus = 'Engaged';
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You proposed to ${character.partnerName}. They said yes! Now comes the family meeting. 💍',
    );
    character.save();
    return true;
  }

  static void marry(Character character) {
    if (character.relationshipStatus != 'Engaged') return;
    character.relationshipStatus = 'Married';
    character.money = (character.money - 8).clamp(0, 9999);
    character.happiness = (character.happiness + 15).clamp(0, 100);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You married ${character.partnerName}! The whole town came to the wedding. The jollof was excellent. 💒',
    );
    character.save();
  }

  static void startCheating(Character character) {
    final sideName = generatePartnerName(character.gender);
    character.isCheating = true;
    character.sidePartnerName = sideName;
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You started seeing $sideName on the side. God is watching. 👀',
    );
    character.save();
  }

  static void getCaught(Character character) {
    final sideName = character.sidePartnerName;
    character.reputation = (character.reputation - 20).clamp(0, 100);
    character.relationshipScore = (character.relationshipScore - 40).clamp(0, 100);
    character.happiness = (character.happiness - 10).clamp(0, 100);
    character.isCheating = false;
    character.sidePartnerName = '';
    character.lifeLog.insert(
      0,
      'Age ${character.age}: ${character.partnerName} found out about $sideName. The whole compound knows. Your reputation is finished. 😭',
    );
    character.save();
  }

  static void divorce(Character character) {
    final exName = character.partnerName;
    character.relationshipStatus = 'Divorced';
    character.money = (character.money - 5).clamp(0, 9999);
    character.happiness = (character.happiness - 20).clamp(0, 100);
    character.reputation = (character.reputation - 5).clamp(0, 100);
    character.partnerName = '';
    character.partnerJob = '';
    character.partnerPersonality = '';
    character.relationshipScore = 0;
    character.isCheating = false;
    character.sidePartnerName = '';
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You and $exName are divorced. The lawyer got rich. You did not. 📄',
    );
    character.save();
  }

  static void haveChild(Character character) {
    if (character.relationshipStatus != 'Married' ||
        character.age < 18 ||
        character.age > 45) {
      return;
    }
    character.numberOfChildren += 1;
    character.money = (character.money - 5).clamp(0, 9999);
    character.happiness = (character.happiness + 10).clamp(0, 100);
    // Pick a child name based on gender (random)
    final childIsBoy = _random.nextBool();
    final childName = childIsBoy
        ? ghanaianMaleNames[_random.nextInt(ghanaianMaleNames.length)]
        : ghanaianFemaleNames[_random.nextInt(ghanaianFemaleNames.length)];
    final childGender = childIsBoy ? 'boy' : 'girl';
    character.lifeLog.insert(
      0,
      'Age ${character.age}: Your ${character.partnerName} gave birth to a baby $childGender. You named them $childName. Life will never be the same. 👶',
    );
    character.save();
  }
}
