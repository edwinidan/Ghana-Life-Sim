import 'package:shared_preferences/shared_preferences.dart';

import '../models/character.dart';
import 'health_service.dart';
import 'life_goal_service.dart';

typedef AchievementChecker =
    bool Function(Character character, String legacyRibbon);

class AchievementDefinition {
  final String id;
  final String title;
  final String description;
  final AchievementChecker isUnlocked;

  const AchievementDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.isUnlocked,
  });
}

class MetaProgressSnapshot {
  final Set<String> unlockedRibbons;
  final Set<String> unlockedAchievements;
  final Set<String> completedLifeGoals;
  final int livesCompleted;

  const MetaProgressSnapshot({
    required this.unlockedRibbons,
    required this.unlockedAchievements,
    required this.completedLifeGoals,
    required this.livesCompleted,
  });

  factory MetaProgressSnapshot.empty() {
    return const MetaProgressSnapshot(
      unlockedRibbons: {},
      unlockedAchievements: {},
      completedLifeGoals: {},
      livesCompleted: 0,
    );
  }
}

class LifeCompletionRewards {
  final List<String> newlyUnlockedRibbons;
  final List<String> newlyUnlockedAchievements;
  final List<String> newlyCompletedGoals;
  final MetaProgressSnapshot snapshot;
  final bool lifeCounted;

  const LifeCompletionRewards({
    required this.newlyUnlockedRibbons,
    required this.newlyUnlockedAchievements,
    required this.newlyCompletedGoals,
    required this.snapshot,
    required this.lifeCounted,
  });

  factory LifeCompletionRewards.empty(MetaProgressSnapshot snapshot) {
    return LifeCompletionRewards(
      newlyUnlockedRibbons: const [],
      newlyUnlockedAchievements: const [],
      newlyCompletedGoals: const [],
      snapshot: snapshot,
      lifeCounted: false,
    );
  }

  bool get hasNewUnlocks =>
      newlyUnlockedRibbons.isNotEmpty ||
      newlyUnlockedAchievements.isNotEmpty ||
      newlyCompletedGoals.isNotEmpty;
}

class MetaProgressService {
  static const String _ribbonsKey = 'meta_unlocked_ribbons';
  static const String _achievementsKey = 'meta_unlocked_achievements';
  static const String _completedGoalsKey = 'meta_completed_life_goals';
  static const String _livesCompletedKey = 'meta_lives_completed';

  static final List<AchievementDefinition> achievements = [
    AchievementDefinition(
      id: 'first_life_completed',
      title: 'First Life Completed',
      description: 'Finish one full life.',
      isUnlocked: (_, _) => true,
    ),
    AchievementDefinition(
      id: 'family_hero',
      title: 'Family Hero',
      description: 'Be remembered for taking care of family.',
      isUnlocked: (character, ribbon) =>
          ribbon == 'Family Hero' || character.averageFamilyBond >= 72,
    ),
    AchievementDefinition(
      id: 'big_person',
      title: 'Big Person',
      description: 'Build major status, money, or business power.',
      isUnlocked: (character, ribbon) =>
          ribbon == 'Big Person' || character.cash >= 100000,
    ),
    AchievementDefinition(
      id: 'hustler',
      title: 'Hustler',
      description: 'Win life through street sense and side moves.',
      isUnlocked: (character, ribbon) =>
          ribbon == 'The Hustler' || character.streetSense >= 75,
    ),
    AchievementDefinition(
      id: 'university_graduate',
      title: 'University Graduate',
      description: 'Earn a university degree.',
      isUnlocked: (character, _) => character.educationLevel == 'University',
    ),
    AchievementDefinition(
      id: 'homeowner',
      title: 'Homeowner',
      description: 'Buy a home in one life.',
      isUnlocked: (character, _) => character.housingStatus == 'Homeowner',
    ),
    AchievementDefinition(
      id: 'business_owner',
      title: 'Business Owner',
      description: 'Start at least one business.',
      isUnlocked: (character, _) => character.businessNames.isNotEmpty,
    ),
    AchievementDefinition(
      id: 'debt_survivor',
      title: 'Debt Survivor',
      description: 'Finish life with no debt.',
      isUnlocked: (character, _) => character.debt == 0,
    ),
    AchievementDefinition(
      id: 'church_favorite',
      title: 'Church Favorite',
      description: 'Become known for spiritual/community respect.',
      isUnlocked: (character, ribbon) =>
          ribbon == 'Church Favorite' || character.hasFlag('church_favorite'),
    ),
    AchievementDefinition(
      id: 'scandal_magnet',
      title: 'Scandal Magnet',
      description: 'Live a life people gossip about.',
      isUnlocked: (character, ribbon) =>
          ribbon == 'Scandal Magnet' ||
          character.hasFlag('known_cheater') ||
          character.isCheating,
    ),
  ];

  static Future<MetaProgressSnapshot> loadSnapshot() async {
    final prefs = await SharedPreferences.getInstance();
    return MetaProgressSnapshot(
      unlockedRibbons: (prefs.getStringList(_ribbonsKey) ?? []).toSet(),
      unlockedAchievements: (prefs.getStringList(_achievementsKey) ?? [])
          .toSet(),
      completedLifeGoals: (prefs.getStringList(_completedGoalsKey) ?? [])
          .toSet(),
      livesCompleted: prefs.getInt(_livesCompletedKey) ?? 0,
    );
  }

  static Future<LifeCompletionRewards> recordLifeCompletion(
    Character character,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final before = await loadSnapshot();
    final ribbon = HealthService.getLegacyRibbon(character);
    final unlockedRibbons = {...before.unlockedRibbons};
    final unlockedAchievements = {...before.unlockedAchievements};
    final completedGoals = {...before.completedLifeGoals};
    final newlyUnlockedRibbons = <String>[];
    final newlyUnlockedAchievements = <String>[];
    final newlyCompletedGoals = <String>[];

    if (unlockedRibbons.add(ribbon)) {
      newlyUnlockedRibbons.add(ribbon);
    }

    final activeGoal = LifeGoalService.activeGoal(character);
    if (activeGoal != null && activeGoal.isComplete(character)) {
      character.completeLifeGoal(activeGoal.id);
    }

    for (final goalId in character.completedLifeGoalIds) {
      if (completedGoals.add(goalId)) {
        newlyCompletedGoals.add(goalId);
      }
    }

    for (final achievement in achievements) {
      if (achievement.isUnlocked(character, ribbon) &&
          unlockedAchievements.add(achievement.id)) {
        newlyUnlockedAchievements.add(achievement.id);
      }
    }

    final livesCompleted = before.livesCompleted + 1;
    await prefs.setStringList(_ribbonsKey, unlockedRibbons.toList()..sort());
    await prefs.setStringList(
      _achievementsKey,
      unlockedAchievements.toList()..sort(),
    );
    await prefs.setStringList(
      _completedGoalsKey,
      completedGoals.toList()..sort(),
    );
    await prefs.setInt(_livesCompletedKey, livesCompleted);

    return LifeCompletionRewards(
      newlyUnlockedRibbons: newlyUnlockedRibbons,
      newlyUnlockedAchievements: newlyUnlockedAchievements,
      newlyCompletedGoals: newlyCompletedGoals,
      snapshot: MetaProgressSnapshot(
        unlockedRibbons: unlockedRibbons,
        unlockedAchievements: unlockedAchievements,
        completedLifeGoals: completedGoals,
        livesCompleted: livesCompleted,
      ),
      lifeCounted: true,
    );
  }

  static AchievementDefinition? achievementById(String id) {
    for (final achievement in achievements) {
      if (achievement.id == id) return achievement;
    }
    return null;
  }
}
