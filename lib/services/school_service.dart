import '../models/character.dart';
import '../data/education.dart';

class SchoolService {
  /// Returns all programs the character is eligible to enroll in right now.
  static List<EducationProgram> getAvailablePrograms(Character character) {
    if (character.isEnrolled) return [];
    return allPrograms.where((p) {
      if (character.age < p.minAge) return false;
      if (p.prerequisite != null && character.educationLevel != p.prerequisite) return false;
      if (character.smarts < p.smartsRequired) return false;
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
    if (program.costPerYear > 0) {
      character.adjustStat('money', -program.costPerYear);
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
        'Primary': 'You completed Primary School. Your teacher said you show promise. Still waiting on that. 📚',
        'JHS': 'You completed Junior High School. BECE results: your mother smiled for three days. 🎓',
        'SHS': 'You completed Senior High School. WASSCE results: your mother cried. 🎓',
        'Vocational': 'Vocational Training complete. You now have a skill and a certificate to frame. 🔧',
        'University': 'You graduated from University. Four years, one degree, and a lot of sobolo. 🎓',
      };
      final msg = messages[program.levelGranted] ?? 'You completed ${program.name}. You did it! 🎓';
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
}
