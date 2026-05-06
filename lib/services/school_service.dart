import '../models/character.dart';
import '../data/education.dart';

class SchoolService {
  static const int feeUnit = 500;

  /// Returns all programs the character is eligible to enroll in right now.
  static List<EducationProgram> getAvailablePrograms(Character character) {
    if (character.isEnrolled) return [];
    return allPrograms.where((p) {
      if (character.age < p.minAge) return false;
      if (p.prerequisite != null &&
          character.educationLevel != p.prerequisite) {
        return false;
      }
      if (character.smarts < p.smartsRequired) return false;
      if (programYearlyCashCost(p) > character.cash) return false;
      // Don't show programs for levels already achieved
      if (character.educationLevel == p.levelGranted) return false;
      return true;
    }).toList();
  }

  /// Enrolls character in a program.
  static void enroll(Character character, EducationProgram program) {
    character.isEnrolled = true;
    character.enrolledIn = program.name;
    character.yearsLeftInSchool = program.durationYears;
    character.lifeLog.insert(
      0,
      'Age ${character.age}: Enrolled in ${program.name}. The journey begins. 📖',
    );
  }

  /// Called every age-up while character is enrolled. Progresses the school year.
  static void progressSchool(Character character) {
    final program = getCurrentProgram(character);
    if (program == null) {
      character.isEnrolled = false;
      return;
    }

    // Deduct cost
    final yearlyCost = programYearlyCashCost(program);
    if (yearlyCost > 0) {
      if (character.cash >= yearlyCost) {
        character.adjustCash(-yearlyCost);
        character.adjustStat('money', -1);
      } else {
        final shortfall = yearlyCost - character.cash;
        character.adjustDebt(shortfall);
        character.cash = 0;
        character.adjustStat('happiness', -4);
        character.adjustStat('money', -3);
        character.lifeLog.insert(
          0,
          'Age ${character.age}: School fees were short, so you took on GHS $shortfall in debt. Education is not cheap. 📚',
        );
      }
    }

    character.yearsLeftInSchool--;

    if (character.yearsLeftInSchool <= 0) {
      // Graduation!
      character.educationLevel = program.levelGranted;
      character.isEnrolled = false;
      character.enrolledIn = '';
      character.yearsLeftInSchool = 0;
      character.adjustStat('smarts', 5);

      final messages = {
        'Primary':
            'You completed Primary School. Your teacher said you show promise. Still waiting on that. 📚',
        'JHS':
            'You completed Junior High School. BECE results: your mother smiled for three days. 🎓',
        'SHS':
            'You completed Senior High School. WASSCE results: your mother cried. 🎓',
        'Vocational':
            'Vocational Training complete. You now have a skill and a certificate to frame. 🔧',
        'University':
            'You graduated from University. Four years, one degree, and a lot of sobolo. 🎓',
      };
      final msg =
          messages[program.levelGranted] ??
          'You completed ${program.name}. You did it! 🎓';
      character.lifeLog.insert(0, 'Age ${character.age}: $msg');
    }
  }

  /// Returns the EducationProgram object matching character.enrolledIn.
  static EducationProgram? getCurrentProgram(Character character) {
    if (!character.isEnrolled || character.enrolledIn.isEmpty) return null;
    try {
      return allPrograms.firstWhere((p) => p.name == character.enrolledIn);
    } catch (_) {
      return null;
    }
  }

  static int programYearlyCashCost(EducationProgram program) {
    return program.costPerYear * feeUnit;
  }
}
