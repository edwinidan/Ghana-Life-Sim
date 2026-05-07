import 'dart:math';
import '../models/character.dart';
import '../data/careers.dart';
import '../data/side_gigs.dart';
import 'career_service.dart';

class JobService {
  static final _rng = Random();

  /// Returns all career entry-level jobs the character can apply for right now.
  static List<CareerData> getAvailableJobs(Character character) {
    if (character.careerPath != 'None') return [];
    return allCareers.where((career) {
      if (!_meetsEducationGate(character, career.name)) return false;
      final entryReqs = career.levels[0].statRequirements;
      for (final entry in entryReqs.entries) {
        if (_getStat(character, entry.key) < entry.value) return false;
      }
      return true;
    }).toList();
  }

  /// Returns all side gigs the character can take on right now.
  static List<SideGig> getAvailableSideGigs(Character character) {
    return allSideGigs.where((gig) {
      if (character.age < gig.minAge) return false;
      if (character.sideGigs.contains(gig.name)) return false;
      if (gig.requiredCareer != null && gig.requiredCareer != character.careerPath) return false;
      for (final entry in gig.statRequirements.entries) {
        if (_getStat(character, entry.key) < entry.value) return false;
      }
      return true;
    }).toList();
  }

  /// Applies for a job. Returns true on success, false on failure.
  static bool applyForJob(Character character, CareerData career) {
    final entryReqs = career.levels[0].statRequirements;
    int statDelta = 0;
    if (entryReqs.isNotEmpty) {
      final firstEntry = entryReqs.entries.first;
      statDelta = _getStat(character, firstEntry.key) - firstEntry.value;
    }
    final successChance = (0.60 + statDelta * 0.01).clamp(0.1, 0.95);

    if (_rng.nextDouble() < successChance) {
      CareerService.enterCareer(character, career.name);
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

  static bool _meetsEducationGate(Character character, String careerName) {
    final level = character.educationLevel;
    final hasSHS = level == 'SHS' || level == 'University';
    final hasUniOrVoc = level == 'University' || level == 'Vocational';
    final hasUni = level == 'University';

    switch (careerName) {
      case 'Hustle':
      case 'Trade':
      case 'Entertainment':
        return true;
      case 'Civil Service':
      case 'Education':
        return hasSHS;
      case 'Tech':
        return hasUniOrVoc;
      case 'Healthcare':
        return hasUni;
      default:
        return true;
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
