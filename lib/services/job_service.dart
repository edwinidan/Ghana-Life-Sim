import 'dart:math';
import '../models/character.dart';
import '../data/careers.dart';
import '../data/side_gigs.dart';
import 'career_service.dart';

class JobEligibility {
  const JobEligibility({required this.career, required this.reasons});

  final CareerData career;
  final List<String> reasons;
  bool get isEligible => reasons.isEmpty;
}

class JobService {
  static final _rng = Random();

  /// Returns all career entry-level jobs the character can apply for right now.
  static List<CareerData> getAvailableJobs(Character character) {
    return getJobListings(character)
        .where((listing) => listing.isEligible)
        .map((listing) => listing.career)
        .toList();
  }

  static List<JobEligibility> getJobListings(Character character) {
    if (character.careerPath != 'None' ||
        character.employmentStatus == 'Retired') {
      return [];
    }
    return allCareers.map((career) {
      final reasons = <String>[];
      if (character.age < 18) reasons.add('You must be at least 18.');
      if (character.isEnrolled) {
        reasons.add('Finish your current programme first.');
      }
      if (career.acceptedEducationLevels.isNotEmpty &&
          !career.acceptedEducationLevels.contains(character.educationLevel)) {
        reasons.add(
          'Requires ${career.acceptedEducationLevels.join(' or ')} education.',
        );
      }
      if (career.acceptedSpecializations.isNotEmpty &&
          !character.hasFlag('legacy_broad_degree') &&
          !career.acceptedSpecializations.contains(
            character.educationSpecialization,
          )) {
        reasons.add(
          'Requires ${career.acceptedSpecializations.join(' or ')} training.',
        );
      }
      final entryReqs = career.levels[0].statRequirements;
      for (final entry in entryReqs.entries) {
        final actual = _getStat(character, entry.key);
        if (actual < entry.value) {
          reasons.add(
            '${_label(entry.key)} needs ${entry.value} (now $actual).',
          );
        }
      }
      return JobEligibility(career: career, reasons: reasons);
    }).toList();
  }

  /// Returns all side gigs the character can take on right now.
  static List<SideGig> getAvailableSideGigs(Character character) {
    return allSideGigs.where((gig) {
      if (character.age < gig.minAge) return false;
      if (character.sideGigs.contains(gig.name)) return false;
      if (gig.requiredCareer != null &&
          gig.requiredCareer != character.careerPath) {
        return false;
      }
      for (final entry in gig.statRequirements.entries) {
        if (_getStat(character, entry.key) < entry.value) return false;
      }
      return true;
    }).toList();
  }

  /// Applies for a job. Returns true on success, false on failure.
  static bool applyForJob(
    Character character,
    CareerData career, {
    Random? random,
  }) {
    final listing = getJobListings(
      character,
    ).where((item) => item.career.name == career.name).firstOrNull;
    if (listing == null || !listing.isEligible) return false;
    final entryReqs = career.levels[0].statRequirements;
    int statDelta = 0;
    if (entryReqs.isNotEmpty) {
      final firstEntry = entryReqs.entries.first;
      statDelta = _getStat(character, firstEntry.key) - firstEntry.value;
    }
    final nssBoost = character.hasFlag('nss_retention_${career.name}')
        ? 0.25
        : character.hasFlag('nss_completed')
        ? 0.08
        : 0.0;
    final successChance = (0.60 + statDelta * 0.01 + nssBoost).clamp(0.1, 0.98);

    if ((random ?? _rng).nextDouble() < successChance) {
      CareerService.enterCareer(character, career.name);
      character.removeFlag('nss_retention_${career.name}');
      return true;
    } else {
      character.lifeLog.insert(
        0,
        'Age ${character.age}: You applied for ${career.name}. They said no. Ghana is hard. 😔',
      );
      return false;
    }
  }

  /// Adds a side gig to the character.
  static void takeSideGig(Character character, SideGig gig) {
    character.sideGigs.add(gig.name);
    _recalculateSideGigIncome(character);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: Started a side gig as a ${gig.name}. Extra money, extra stress. 💪',
    );
  }

  /// Removes a side gig from the character.
  static void quitSideGig(Character character, SideGig gig) {
    character.sideGigs.remove(gig.name);
    _recalculateSideGigIncome(character);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: Quit the ${gig.name} side gig. One less thing to worry about. 😤',
    );
  }

  /// Quits the main career.
  static void quitJob(Character character) {
    final oldCareer = character.careerPath;
    character.careerPath = 'None';
    character.careerLevel = 0;
    character.monthlyIncome = 0;
    character.employmentStatus = 'Unemployed';
    character.jobPerformance = 50;
    character.yearsInCareer = 0;
    character.careerSalaryBonusPercent = 0;
    character.lifeLog.insert(
      0,
      'Age ${character.age}: Left the $oldCareer job. Bold move. Let\'s see how this plays out. 🚪',
    );
  }

  static void _recalculateSideGigIncome(Character character) {
    int total = 0;
    for (final gigName in character.sideGigs) {
      try {
        final gig = allSideGigs.firstWhere((g) => g.name == gigName);
        total += gig.monthlyIncome;
      } catch (_) {}
    }
    character.sideGigIncome = total;
  }

  static bool workHard(Character character) {
    if (character.careerPath == 'None' || !character.consumeActionEnergy()) {
      return false;
    }
    character.jobPerformance = (character.jobPerformance + 12).clamp(0, 100);
    character.adjustStat('discipline', 2);
    character.adjustStat('happiness', -2);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You put extra effort into work. Your performance improved. 💪',
    );
    return true;
  }

  static CareerReviewResult requestCareerReview(
    Character character, {
    Random? random,
  }) {
    if (character.careerPath == 'None' ||
        character.lastCareerReviewAge == character.age) {
      return CareerReviewResult.unavailable;
    }
    character.lastCareerReviewAge = character.age;
    if (CareerService.qualifiesForPromotion(character) &&
        character.jobPerformance >= 65) {
      CareerService.applyPromotion(character);
      return CareerReviewResult.promoted;
    }
    final chance = (0.25 + character.jobPerformance / 200).clamp(0.25, 0.75);
    if ((random ?? _rng).nextDouble() < chance) {
      character.careerSalaryBonusPercent =
          (character.careerSalaryBonusPercent + 5).clamp(0, 25);
      CareerService.syncIncome(character);
      character.lifeLog.insert(
        0,
        'Age ${character.age}: Your review earned you a 5% raise. 📈',
      );
      return CareerReviewResult.raise;
    }
    character.adjustStat('happiness', -1);
    return CareerReviewResult.declined;
  }

  static bool retire(Character character) {
    if (character.careerPath == 'None' || character.age < 60) return false;
    CareerService.retire(character);
    return true;
  }

  static String _label(String value) => switch (value) {
    'streetSense' => 'Street sense',
    _ => '${value[0].toUpperCase()}${value.substring(1)}',
  };

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

enum CareerReviewResult { unavailable, promoted, raise, declined }
