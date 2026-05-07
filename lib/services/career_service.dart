import 'dart:math';
import '../models/character.dart';
import '../data/careers.dart';

class CareerService {
  /// Returns the CareerData for the character's current path, or null if 'None'.
  static CareerData? getCareerData(Character character) {
    if (character.careerPath == 'None') return null;
    try {
      return allCareers.firstWhere((c) => c.name == character.careerPath);
    } catch (_) {
      return null;
    }
  }

  /// Checks if the character qualifies for a promotion this year (40% chance if requirements met).
  static bool checkPromotion(Character character) {
    if (character.careerPath == 'None') return false;
    if (character.careerLevel >= 3) return false;

    final career = getCareerData(character);
    if (career == null) return false;

    // careerLevel is 1-based (1=entry, 2=mid, 3=senior)
    // next level requirements are at index == current careerLevel (0-based)
    final nextIndex = character.careerLevel; // e.g. level 1 → index 1 for mid
    if (nextIndex >= career.levels.length) return false;

    final nextLevel = career.levels[nextIndex];
    for (final entry in nextLevel.statRequirements.entries) {
      int charStat = _getStat(character, entry.key);
      if (charStat < entry.value) return false;
    }

    return Random().nextDouble() < 0.40;
  }

  /// Applies a promotion: increments careerLevel, syncs income, adds a lifeLog entry.
  static void applyPromotion(Character character) {
    character.careerLevel++;
    syncIncome(character);

    final career = getCareerData(character);
    if (career == null) return;
    final title = career.levels[character.careerLevel - 1].title;

    final messages = {
      'Civil Service': 'The government finally noticed you. 🏛️',
      'Healthcare': 'More lives to save, more night shifts to work. 🏥',
      'Education': 'The students now fear you properly. 📚',
      'Tech': 'Your code actually deployed without breaking production. 💻',
      'Trade': 'The market knows your face now. 🛒',
      'Entertainment': 'Your gigs are finally paying more than exposure. 🎤',
      'Hustle': 'The streets are watching your moves. 💸',
    };
    final flavour = messages[character.careerPath] ?? 'Hard work pays off. 💼';

    character.lifeLog.insert(
      0,
      'Age ${character.age}: Promotion! You are now a $title. $flavour',
    );
  }

  /// Enters a career for the first time: sets path, level = 1, syncs income, logs entry.
  static void enterCareer(Character character, String careerName) {
    character.careerPath = careerName;
    character.careerLevel = 1;
    syncIncome(character);

    final career = getCareerData(character);
    if (career == null) return;
    final title = career.levels[0].title;

    final messages = {
      'Civil Service': 'Time to learn how to sleep with your eyes open. 🏛️',
      'Healthcare': 'Get ready for long nights and very demanding patients. 🏥',
      'Education': 'Chalk, noise, and marking scripts for the foreseeable future. 📚',
      'Tech': 'The grind begins. 💻',
      'Trade': 'Time to count every single pesewa. 🛒',
      'Entertainment': 'Make sure they spell your name right. 🎤',
      'Hustle': 'Time to eat or be eaten. 💸',
    };
    final flavour = messages[careerName] ?? 'Welcome to the workforce. 💼';

    character.lifeLog.insert(
      0,
      'Age ${character.age}: You entered the $careerName world as a $title. $flavour',
    );
  }

  /// Syncs monthlyIncome to match current careerPath + careerLevel.
  static void syncIncome(Character character) {
    if (character.careerPath == 'None' || character.careerLevel < 1) {
      character.monthlyIncome = 0;
      return;
    }
    final career = getCareerData(character);
    if (career != null && character.careerLevel <= career.levels.length) {
      character.monthlyIncome = career.levels[character.careerLevel - 1].salary;
    }
  }

  static int _getStat(Character c, String stat) {
    switch (stat) {
      case 'health': return c.health;
      case 'happiness': return c.happiness;
      case 'smarts': return c.smarts;
      case 'looks': return c.looks;
      case 'money': return c.money;
      case 'reputation': return c.reputation;
      case 'discipline': return c.discipline;
      case 'streetSense': return c.streetSense;
      case 'connections': return c.connections;
      default: return 0;
    }
  }
}
