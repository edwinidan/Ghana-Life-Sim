enum LifeStage {
  infant('Infant', 0, 2),
  earlyChildhood('Early Childhood', 3, 5),
  child('Child', 6, 12),
  teenager('Teenager', 13, 17),
  youngAdult('Young Adult', 18, 25),
  adult('Adult', 26, 39),
  middleAge('Middle Age', 40, 59),
  senior('Senior', 60, 120);

  const LifeStage(this.label, this.minimumAge, this.maximumAge);

  final String label;
  final int minimumAge;
  final int maximumAge;

  static LifeStage forAge(int age) => values.firstWhere(
    (stage) => age >= stage.minimumAge && age <= stage.maximumAge,
    orElse: () => senior,
  );
}

abstract final class SimulationConfig {
  static const currentSaveSchemaVersion = 3;
  static const debtInterestRate = 0.08;
  static const maxMajorDecisionsPerYear = 2;

  static int actionsForAge(int age) {
    if (age < 6) return 1;
    if (age < 13) return 2;
    if (age < 18) return 3;
    return 3;
  }
}
