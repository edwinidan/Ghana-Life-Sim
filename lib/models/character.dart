import 'dart:math';

class Character {
  String name;
  String gender;
  int age;
  bool isAlive;

  // Core stats (0-100)
  int health;
  int happiness;
  int smarts;
  int looks;
  int money;
  int reputation;
  int discipline;
  int streetSense;
  int connections;

  // Life info
  String job;
  String education;
  List<String> lifeLog;

  Character({required this.name, required this.gender})
    : age = 0,
      isAlive = true,
      job = 'None',
      education = 'None',
      lifeLog = [],
      health = _randomStat(60, 90),
      happiness = _randomStat(50, 80),
      smarts = _randomStat(30, 80),
      looks = _randomStat(30, 80),
      money = _randomStat(5, 30),
      reputation = _randomStat(20, 50),
      discipline = _randomStat(20, 70),
      streetSense = _randomStat(20, 60),
      connections = _randomStat(10, 40);

  static int _randomStat(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  // Clamp a stat between 0 and 100
  void adjustStat(String stat, int amount) {
    switch (stat) {
      case 'health':
        health = (health + amount).clamp(0, 100);
        break;
      case 'happiness':
        happiness = (happiness + amount).clamp(0, 100);
        break;
      case 'smarts':
        smarts = (smarts + amount).clamp(0, 100);
        break;
      case 'looks':
        looks = (looks + amount).clamp(0, 100);
        break;
      case 'money':
        money = (money + amount).clamp(0, 100);
        break;
      case 'reputation':
        reputation = (reputation + amount).clamp(0, 100);
        break;
      case 'discipline':
        discipline = (discipline + amount).clamp(0, 100);
        break;
      case 'streetSense':
        streetSense = (streetSense + amount).clamp(0, 100);
        break;
      case 'connections':
        connections = (connections + amount).clamp(0, 100);
        break;
    }
  }

  bool get isDead => health <= 0 || age >= 90;

  String get lifeStage {
    if (age < 6) return 'Toddler';
    if (age < 13) return 'Child';
    if (age < 18) return 'Teenager';
    if (age < 25) return 'Young Adult';
    if (age < 50) return 'Adult';
    if (age < 70) return 'Middle Aged';
    return 'Senior';
  }
}
