import '../models/character.dart';

class LifeGoal {
  final String id;
  final String title;
  final String description;
  final int target;
  final int Function(Character character) currentValue;

  const LifeGoal({
    required this.id,
    required this.title,
    required this.description,
    required this.target,
    required this.currentValue,
  });

  int current(Character character) => currentValue(character).clamp(0, target);

  bool isComplete(Character character) => current(character) >= target;

  String progressText(Character character) => '${current(character)} / $target';
}

class LifeGoalService {
  static final List<LifeGoal> goals = [
    LifeGoal(
      id: 'graduate_university',
      title: 'Graduate University',
      description: 'Finish university before your life ends.',
      target: 1,
      currentValue: (character) =>
          character.educationLevel == 'University' ? 1 : 0,
    ),
    LifeGoal(
      id: 'get_married',
      title: 'Get Married',
      description: 'Build a relationship strong enough to marry.',
      target: 1,
      currentValue: (character) =>
          character.relationshipStatus == 'Married' ? 1 : 0,
    ),
    LifeGoal(
      id: 'raise_three_children',
      title: 'Raise 3 Children',
      description: 'Have at least three children in one life.',
      target: 3,
      currentValue: (character) => character.numberOfChildren,
    ),
    LifeGoal(
      id: 'own_home',
      title: 'Own A Home',
      description: 'Move from survival to stability by buying a home.',
      target: 1,
      currentValue: (character) =>
          character.housingStatus == 'Homeowner' ? 1 : 0,
    ),
    LifeGoal(
      id: 'start_business',
      title: 'Start A Business',
      description: 'Open at least one business in your lifetime.',
      target: 1,
      currentValue: (character) => character.businessNames.isNotEmpty ? 1 : 0,
    ),
    LifeGoal(
      id: 'reach_100k_cash',
      title: 'Reach GHS 100,000',
      description: 'Build serious cash reserves.',
      target: 100000,
      currentValue: (character) => character.cash,
    ),
    LifeGoal(
      id: 'die_debt_free',
      title: 'Die Debt Free',
      description: 'Finish life without owing anyone.',
      target: 1,
      currentValue: (character) =>
          character.isDead && character.debt == 0 ? 1 : 0,
    ),
    LifeGoal(
      id: 'reach_age_80',
      title: 'Reach Age 80',
      description: 'Survive long enough to become an elder.',
      target: 80,
      currentValue: (character) => character.age,
    ),
  ];

  static LifeGoal? goalById(String id) {
    for (final goal in goals) {
      if (goal.id == id) return goal;
    }
    return null;
  }

  static LifeGoal ensureActiveGoal(Character character) {
    final existing = goalById(character.activeLifeGoalId);
    if (existing != null &&
        !character.completedLifeGoalIds.contains(existing.id)) {
      return existing;
    }

    final available = goals
        .where((goal) => !character.completedLifeGoalIds.contains(goal.id))
        .toList();
    final seed =
        character.name.codeUnits.fold<int>(
          character.age,
          (sum, code) => sum + code,
        ) +
        character.smarts +
        character.streetSense +
        character.looks;
    final next = available.isEmpty
        ? goals.first
        : available[seed % available.length];
    character.activeLifeGoalId = next.id;
    return next;
  }

  static LifeGoal? activeGoal(Character character) {
    return goalById(character.activeLifeGoalId);
  }

  static bool updateGoalProgress(Character character) {
    final goal = ensureActiveGoal(character);
    if (!goal.isComplete(character)) return false;
    character.completeLifeGoal(goal.id);
    character.activeLifeGoalId = '';
    ensureActiveGoal(character);
    return true;
  }
}
