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
}
