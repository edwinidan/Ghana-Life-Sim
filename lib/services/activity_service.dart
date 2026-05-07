import 'dart:math';

import '../models/character.dart';

class ActivityOption {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final int minAge;
  final int cashCost;
  final bool requiresPartner;
  final bool requiresChild;

  const ActivityOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    this.minAge = 0,
    this.cashCost = 0,
    this.requiresPartner = false,
    this.requiresChild = false,
  });
}

class ActivityResult {
  final String message;
  final bool success;

  const ActivityResult({required this.message, required this.success});
}

class ActivityService {
  static final Random _rng = Random();

  static const List<ActivityOption> options = [
    ActivityOption(
      id: 'study',
      title: 'Study Hard',
      subtitle: 'Boost smarts and discipline',
      emoji: '📚',
      minAge: 5,
    ),
    ActivityOption(
      id: 'exercise',
      title: 'Exercise',
      subtitle: 'Improve health and looks',
      emoji: '🏃',
      minAge: 12,
      cashCost: 150,
    ),
    ActivityOption(
      id: 'doctor',
      title: 'Visit Doctor',
      subtitle: 'Treat health problems',
      emoji: '🏥',
      cashCost: 600,
    ),
    ActivityOption(
      id: 'rest',
      title: 'Rest',
      subtitle: 'Recover happiness and health',
      emoji: '🛌',
    ),
    ActivityOption(
      id: 'pray',
      title: 'Go to Church',
      subtitle: 'Build peace and reputation',
      emoji: '⛪',
      minAge: 6,
    ),
    ActivityOption(
      id: 'party',
      title: 'Go Out',
      subtitle: 'Have fun, risk discipline',
      emoji: '🎉',
      minAge: 16,
      cashCost: 250,
    ),
    ActivityOption(
      id: 'gamble',
      title: 'Try Betting',
      subtitle: 'Risk cash for a quick win',
      emoji: '🎲',
      minAge: 18,
      cashCost: 300,
    ),
    ActivityOption(
      id: 'help_family',
      title: 'Help Family',
      subtitle: 'Support relatives financially',
      emoji: '👪',
      minAge: 16,
      cashCost: 700,
    ),
    ActivityOption(
      id: 'partner_time',
      title: 'Spend Time',
      subtitle: 'Improve your relationship',
      emoji: '💕',
      minAge: 16,
      cashCost: 200,
      requiresPartner: true,
    ),
    ActivityOption(
      id: 'child_time',
      title: 'Play With Kids',
      subtitle: 'Build stronger child bonds',
      emoji: '👶',
      cashCost: 150,
      requiresChild: true,
    ),
    ActivityOption(
      id: 'risky_hustle',
      title: 'Risky Hustle',
      subtitle: 'Street money, real consequences',
      emoji: '🛣️',
      minAge: 16,
    ),
  ];

  static List<ActivityOption> availableActivities(Character character) {
    return options.where((option) {
      if (character.age < option.minAge) return false;
      if (option.requiresPartner && !_hasPartner(character)) return false;
      if (option.requiresChild && character.numberOfChildren <= 0) return false;
      return true;
    }).toList();
  }

  static ActivityResult performActivity(
    Character character,
    ActivityOption option,
  ) {
    if (character.actionEnergy <= 0) {
      return const ActivityResult(
        success: false,
        message: 'You are out of energy for this year. Age up to reset it.',
      );
    }
    if (character.age < option.minAge) {
      return ActivityResult(
        success: false,
        message: '${option.title} unlocks at age ${option.minAge}.',
      );
    }
    if (option.requiresPartner && !_hasPartner(character)) {
      return ActivityResult(
        success: false,
        message: 'You need a partner before you can do this.',
      );
    }
    if (option.requiresChild && character.numberOfChildren <= 0) {
      return ActivityResult(
        success: false,
        message: 'You need children before you can do this.',
      );
    }
    if (character.cash < option.cashCost) {
      return ActivityResult(
        success: false,
        message: 'You need GHS ${option.cashCost} for ${option.title}.',
      );
    }

    character.consumeActionEnergy();
    if (option.cashCost > 0) {
      character.adjustCash(-option.cashCost);
    }

    final message = switch (option.id) {
      'study' => _study(character),
      'exercise' => _exercise(character),
      'doctor' => _doctor(character),
      'rest' => _rest(character),
      'pray' => _pray(character),
      'party' => _party(character),
      'gamble' => _gamble(character),
      'help_family' => _helpFamily(character),
      'partner_time' => _partnerTime(character),
      'child_time' => _childTime(character),
      'risky_hustle' => _riskyHustle(character),
      _ => 'You tried something new. Life moved a little.',
    };

    character.lifeLog.insert(
      0,
      'Age ${character.age}: ${option.title} — $message',
    );

    return ActivityResult(success: true, message: message);
  }

  static bool _hasPartner(Character character) {
    return character.relationshipStatus == 'Dating' ||
        character.relationshipStatus == 'Engaged' ||
        character.relationshipStatus == 'Married';
  }

  static String _study(Character character) {
    character.adjustStat('smarts', 4);
    character.adjustStat('discipline', 2);
    character.adjustStat('happiness', -1);
    return 'You studied properly. Smarts and discipline went up.';
  }

  static String _exercise(Character character) {
    character.adjustStat('health', 5);
    character.adjustStat('looks', 2);
    character.adjustStat('happiness', 1);
    return 'You worked out and felt sharper in your body.';
  }

  static String _doctor(Character character) {
    character.adjustStat('health', 10);
    if (character.activeIllnesses.isNotEmpty && _rng.nextDouble() < 0.65) {
      final illness = character.activeIllnesses.removeLast();
      return 'The doctor treated your $illness. Your health improved.';
    }
    return 'The checkup helped. Your health improved.';
  }

  static String _rest(Character character) {
    character.adjustStat('happiness', 5);
    character.adjustStat('health', 2);
    character.adjustStat('discipline', -1);
    return 'You slowed down and recovered some peace.';
  }

  static String _pray(Character character) {
    character.adjustStat('happiness', 4);
    character.adjustStat('reputation', 2);
    character.adjustStat('connections', 1);
    if (_rng.nextDouble() < 0.25) {
      character.addFlag('church_favorite');
      return 'The church aunties noticed you. Your reputation is glowing.';
    }
    return 'You left feeling calmer and more grounded.';
  }

  static String _party(Character character) {
    character.adjustStat('happiness', 7);
    character.adjustStat('looks', 1);
    character.adjustStat('discipline', -3);
    if (_rng.nextDouble() < 0.15) {
      character.adjustStat('health', -2);
      character.addFlag('party_animal');
      return 'The night was fun, maybe too fun. People are talking.';
    }
    return 'You had a good time and forgot your stress for a while.';
  }

  static String _gamble(Character character) {
    character.adjustStat('streetSense', 2);
    if (_rng.nextDouble() < 0.42) {
      final winnings = 900 + _rng.nextInt(1800);
      character.adjustCash(winnings);
      character.adjustStat('happiness', 4);
      return 'Your bet landed. You won GHS $winnings.';
    }
    final debt = 200 + _rng.nextInt(700);
    character.adjustDebt(debt);
    character.adjustStat('happiness', -4);
    return 'The bet flopped. You added GHS $debt to your debt.';
  }

  static String _helpFamily(Character character) {
    character.ensureFamilySeeded();
    character.adjustFamilyBonds(8);
    character.adjustStat('reputation', 5);
    character.adjustStat('happiness', 2);
    character.addFlag('family_helper');
    return 'You supported the family. The bond at home grew stronger.';
  }

  static String _partnerTime(Character character) {
    character.adjustStat('relationshipScore', 8);
    character.adjustStat('happiness', 3);
    return 'You made time for ${character.partnerName}. The relationship improved.';
  }

  static String _childTime(Character character) {
    character.adjustChildBonds(8);
    character.adjustStat('happiness', 4);
    return 'The children loved the attention. Your bond with them improved.';
  }

  static String _riskyHustle(Character character) {
    character.adjustStat('streetSense', 5);
    if (_rng.nextDouble() < 0.55) {
      final payout = 800 + _rng.nextInt(2200);
      character.adjustCash(payout);
      character.adjustStat('money', 2);
      return 'The hustle paid off. You made GHS $payout.';
    }

    final penalty = 500 + _rng.nextInt(1200);
    character.adjustDebt(penalty);
    character.adjustStat('reputation', -4);
    character.addFlag('risky_hustle_trouble');
    return 'The hustle went sideways. You owe GHS $penalty now.';
  }
}
