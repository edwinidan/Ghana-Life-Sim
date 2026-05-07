import '../models/character.dart';

class HealthService {
  /// Returns the cause of death string based on how the character died.
  static String determineCauseOfDeath(Character character) {
    if (character.age >= 85) {
      final messages = [
        'You lived to ${character.age}. Ghana saw you through it all. Rest well. 🕊️',
        'At ${character.age}, you finally put down the load. A life fully lived. 🙏',
        'You made it to ${character.age}. Not bad for someone who ate that much waakye. 😄🕊️',
      ];
      messages.shuffle();
      return messages.first;
    }

    if (character.health <= 0 && character.activeIllnesses.isNotEmpty) {
      final illness = character.activeIllnesses.last;
      final messages = [
        'The $illness finally won. You fought it as long as you could. 🕊️',
        '$illness took you at ${character.age}. The hospital bills came after you were gone. 💔',
      ];
      messages.shuffle();
      return messages.first;
    }

    if (character.health <= 0) {
      final messages = [
        'Your body gave up at ${character.age}. It had been sending memos for years. 😔🕊️',
        'At ${character.age}, the health stat hit zero. Ghana lost one of its own. 🕊️',
      ];
      messages.shuffle();
      return messages.first;
    }

    // Fallback: old age
    return 'At ${character.age}, you finally put down the load. A life fully lived. 🙏';
  }

  /// Calculates the life rating score (0–100) based on final stats.
  static int calculateLifeScore(Character character) {
    double score = 0;

    score += character.health * 0.10;
    score += character.happiness * 0.20;
    score += character.money * 0.15;
    score += (character.cash / 10000).clamp(0, 10);
    score -= (character.debt / 10000).clamp(0, 15);
    score += character.reputation * 0.15;
    score += character.smarts * 0.10;

    // Relationship bonus
    if (character.relationshipStatus == 'Married') {
      score += 10;
    } else if (character.relationshipStatus == 'Dating') {
      score += 5;
    }

    // Children bonus: +3 per child, capped at +15
    score += (character.numberOfChildren * 3).clamp(0, 15);

    // Homeowner bonus
    if (character.housingStatus == 'Homeowner') {
      score += 5;
    }

    // Business bonus: +3 per business, capped at +10
    score += (character.businessNames.length * 3).clamp(0, 10);

    return score.round().clamp(0, 100);
  }

  /// Returns the life rating label based on score.
  static String getLifeRating(int score) {
    if (score >= 75) return 'Legendary';
    if (score >= 55) return 'Solid Run';
    if (score >= 30) return 'Average Life';
    return 'Wasted Potential';
  }

  /// Returns a flavour subtitle for the rating in Ghanaian tone.
  static String getRatingSubtitle(String rating) {
    switch (rating) {
      case 'Legendary':
        return 'They will tell stories about you in the compound for years. 🌟';
      case 'Solid Run':
        return 'Not perfect, but respectable. Your people are proud. 👏';
      case 'Average Life':
        return 'You lived. You struggled. You managed. That\'s something. 🤷';
      case 'Wasted Potential':
      default:
        return 'Ghana expected more. But we move. 😬';
    }
  }

  /// BitLife-style final identity badge based on the strongest life pattern.
  static String getLegacyRibbon(Character character) {
    final hasScandal =
        character.hasFlag('known_cheater') ||
        character.hasFlag('family_disappointed') ||
        character.hasFlag('distant_parent') ||
        character.isCheating;
    if (hasScandal) return 'Scandal Magnet';

    if (character.streetSense >= 75 ||
        character.careerPath == 'Hustle' ||
        character.sideGigs.length >= 2 ||
        character.hasFlag('risky_hustle_trouble')) {
      return 'The Hustler';
    }

    if (character.numberOfChildren >= 3 ||
        character.averageFamilyBond >= 72 ||
        character.hasFlag('family_helper')) {
      return 'Family Hero';
    }

    if (character.cash >= 100000 ||
        (character.reputation >= 75 && character.businessNames.length >= 2)) {
      return 'Big Person';
    }

    if (character.hasFlag('church_favorite') ||
        (character.reputation >= 70 && character.connections >= 70)) {
      return 'Church Favorite';
    }

    if (character.educationLevel == 'University' &&
        character.happiness >= 70 &&
        character.reputation >= 60) {
      return 'Campus Legend';
    }

    final score = calculateLifeScore(character);
    if (character.age >= 80 && score < 55) return 'Quiet Survivor';
    if (character.smarts >= 75 && character.looks >= 65 && score < 40) {
      return 'Wasted Talent';
    }
    if (score >= 75) return 'Local Legend';
    if (score >= 55) return 'Respectable Citizen';
    return 'Tough Life';
  }

  static String getLegacyRibbonSubtitle(String ribbon) {
    switch (ribbon) {
      case 'Scandal Magnet':
        return 'Your drama had its own WhatsApp broadcast list.';
      case 'The Hustler':
        return 'You knew how to move, bargain, survive, and make something shake.';
      case 'Family Hero':
        return 'Your people remember you as someone who showed up.';
      case 'Big Person':
        return 'Money, status, and a name people recognized.';
      case 'Church Favorite':
        return 'The aunties approved, and that is not a small achievement.';
      case 'Campus Legend':
        return 'School life treated you well, and people still remember the name.';
      case 'Quiet Survivor':
        return 'No noise, no headlines, but you endured.';
      case 'Wasted Talent':
        return 'The potential was there. Life just did not cash it out.';
      case 'Local Legend':
        return 'A full life with stories worth repeating.';
      case 'Respectable Citizen':
        return 'You did enough for people to nod with respect.';
      case 'Tough Life':
      default:
        return 'It was not easy, but you still had a story.';
    }
  }
}
