import '../models/character.dart';
import '../data/education.dart';

class SchoolService {
  static const int feeUnit = 500;

  /// Returns all programs the character is eligible to enroll in right now.
  static List<EducationProgram> getAvailablePrograms(Character character) {
    if (character.isEnrolled) return [];
    return allPrograms.where((p) {
      if (p.legacyOnly) return false;
      if (character.age < p.minAge) return false;
      if (!p.accepts(character.educationLevel)) return false;
      if (character.smarts < p.smartsRequired) return false;
      // Players may finance fees through the existing annual education-debt
      // flow. Requiring a full year's cash here made tertiary paths disappear.
      // Don't show programs for levels already achieved
      if (character.educationLevel == p.levelGranted) return false;
      if (p.completionFlag != null && character.hasFlag(p.completionFlag!)) {
        return false;
      }
      if (!p.preservesEducationLevel &&
          _educationRank(p.levelGranted) <=
              _educationRank(character.educationLevel)) {
        return false;
      }
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
    final yearlyCost = programYearlyCashCost(program, character: character);
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
      if (!program.preservesEducationLevel) {
        character.educationLevel = program.levelGranted;
      }
      if (program.specializationGranted.isNotEmpty) {
        character.educationSpecialization = program.specializationGranted;
      }
      if (program.nssPlacementGranted.isNotEmpty) {
        character.nssPlacement = program.nssPlacementGranted;
        character.adjustStat('connections', 6);
        character.adjustStat('reputation', 3);
        final retentionPath = _retentionCareerFor(program.nssPlacementGranted);
        if (retentionPath.isNotEmpty) {
          character.addFlag('nss_retention_$retentionPath');
        }
      }
      if (program.completionFlag != null) {
        character.addFlag(program.completionFlag!);
      }
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
        'Tertiary Diploma':
            'You completed professional tertiary training and earned your diploma. 🎓',
        'NSS':
            'You completed National Service. The allowance was modest, but the experience and connections were real. 🇬🇭',
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

  static int programYearlyCashCost(
    EducationProgram program, {
    Character? character,
  }) {
    final baseCost = program.costPerYear * feeUnit;
    if (character == null || baseCost == 0) return baseCost;
    if (character.smarts >= 80) return (baseCost * 0.2).round();
    if (character.smarts >= 65) return (baseCost * 0.5).round();
    return baseCost;
  }

  static String _retentionCareerFor(String placement) {
    return switch (placement) {
      'Health Service' => 'Healthcare',
      'Education Service' => 'Education',
      'Digital & Engineering' => 'Tech',
      'Private Enterprise' => 'Commerce',
      'Media & Sports Development' => 'Sports & Media',
      'Public Administration' => 'Civil Service',
      _ => '',
    };
  }

  static int _educationRank(String level) => switch (level) {
    'Primary' => 1,
    'JHS' => 2,
    'SHS' || 'Vocational' => 3,
    'Tertiary Diploma' => 4,
    'University' => 5,
    _ => 0,
  };
}
