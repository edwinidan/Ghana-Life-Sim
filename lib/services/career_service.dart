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
  static bool checkPromotion(Character character, {Random? random}) {
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

    return (random ?? Random()).nextDouble() < 0.40;
  }

  static bool qualifiesForPromotion(Character character) {
    if (character.careerPath == 'None' || character.careerLevel >= 3) {
      return false;
    }
    final career = getCareerData(character);
    if (career == null || character.careerLevel >= career.levels.length) {
      return false;
    }
    final nextLevel = career.levels[character.careerLevel];
    return nextLevel.statRequirements.entries.every(
      (entry) => _getStat(character, entry.key) >= entry.value,
    );
  }

  static CareerYearResult progressEmployment(
    Character character, {
    Random? random,
  }) {
    if (character.careerPath == 'None' ||
        character.employmentStatus == 'Retired') {
      return CareerYearResult.none;
    }
    final rng = random ?? Random();
    character.employmentStatus = 'Employed';
    character.yearsInCareer++;
    final skillSignal =
        (character.discipline + character.smarts + character.reputation) ~/ 3;
    final drift = skillSignal >= 65
        ? 5
        : skillSignal < 38
        ? -7
        : 1;
    character.jobPerformance =
        (character.jobPerformance + drift + rng.nextInt(9) - 4).clamp(0, 100);

    if (character.age >= 67) {
      retire(character);
      return CareerYearResult.retired;
    }
    if (character.jobPerformance <= 20 && rng.nextDouble() < 0.30) {
      _dismiss(
        character,
        'You were dismissed after a difficult performance review.',
      );
      return CareerYearResult.dismissed;
    }
    if (rng.nextDouble() < 0.015) {
      _dismiss(character, 'Your role was made redundant during restructuring.');
      return CareerYearResult.redundant;
    }
    if (character.jobPerformance >= 62 &&
        qualifiesForPromotion(character) &&
        rng.nextDouble() < 0.32) {
      applyPromotion(character);
      return CareerYearResult.promoted;
    }
    return CareerYearResult.continued;
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
    character.employmentStatus = 'Employed';
    character.jobPerformance = 55;
    character.yearsInCareer = 0;
    character.careerSalaryBonusPercent = 0;
    syncIncome(character);

    final career = getCareerData(character);
    if (career == null) return;
    final title = career.levels[0].title;

    final messages = {
      'Civil Service': 'Time to learn how to sleep with your eyes open. 🏛️',
      'Healthcare': 'Get ready for long nights and very demanding patients. 🏥',
      'Education':
          'Chalk, noise, and marking scripts for the foreseeable future. 📚',
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
    if (character.employmentStatus == 'Retired') {
      character.monthlyIncome = character.monthlyPension;
      return;
    }
    if (character.careerPath == 'None' || character.careerLevel < 1) {
      character.monthlyIncome = 0;
      return;
    }
    final career = getCareerData(character);
    if (career != null && character.careerLevel <= career.levels.length) {
      final base = career.levels[character.careerLevel - 1].salary;
      character.monthlyIncome =
          (base * (100 + character.careerSalaryBonusPercent) / 100).round();
    }
  }

  static void retire(Character character) {
    final career = getCareerData(character);
    if (career == null) return;
    final finalSalary = career.levels[character.careerLevel - 1].salary;
    character.monthlyPension = (finalSalary * 0.38).round();
    character.retiredCareerPath = character.careerPath;
    character.employmentStatus = 'Retired';
    character.monthlyIncome = character.monthlyPension;
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You retired from ${character.careerPath} with a pension of GHS ${character.monthlyPension}/month. 🌅',
    );
  }

  static void _dismiss(Character character, String message) {
    final formerCareer = character.careerPath;
    character.careerPath = 'None';
    character.careerLevel = 0;
    character.monthlyIncome = 0;
    character.employmentStatus = 'Unemployed';
    character.jobPerformance = 50;
    character.yearsInCareer = 0;
    character.careerSalaryBonusPercent = 0;
    character.adjustStat('happiness', -8);
    character.adjustStat('reputation', -3);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: $message Your $formerCareer chapter ended. 💼',
    );
  }

  static int _getStat(Character c, String stat) {
    switch (stat) {
      case 'health':
        return c.health;
      case 'happiness':
        return c.happiness;
      case 'smarts':
        return c.smarts;
      case 'looks':
        return c.looks;
      case 'money':
        return c.money;
      case 'reputation':
        return c.reputation;
      case 'discipline':
        return c.discipline;
      case 'streetSense':
        return c.streetSense;
      case 'connections':
        return c.connections;
      default:
        return 0;
    }
  }
}

enum CareerYearResult {
  none,
  continued,
  promoted,
  dismissed,
  redundant,
  retired,
}
