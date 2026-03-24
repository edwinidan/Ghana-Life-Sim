import 'dart:math';
import 'package:hive/hive.dart';

part 'character.g.dart';

@HiveType(typeId: 0)
class Character extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String gender;
  @HiveField(2)
  int age;
  @HiveField(3)
  bool isAlive;

  // Core stats (0-100)
  @HiveField(4)
  int health;
  @HiveField(5)
  int happiness;
  @HiveField(6)
  int smarts;
  @HiveField(7)
  int looks;
  @HiveField(8)
  int money;
  @HiveField(9)
  int reputation;
  @HiveField(10)
  int discipline;
  @HiveField(11)
  int streetSense;
  @HiveField(12)
  int connections;

  // Life info
  @HiveField(13)
  String job;
  @HiveField(14)
  String education;
  @HiveField(15)
  List<String> lifeLog;

  @HiveField(16)
  String careerPath;
  @HiveField(17)
  int careerLevel;
  @HiveField(18)
  int monthlyIncome;

  @HiveField(19)
  String educationLevel;
  @HiveField(20)
  bool isEnrolled;
  @HiveField(21)
  String enrolledIn;
  @HiveField(22)
  int yearsLeftInSchool;
  @HiveField(23)
  List<String> sideGigs;
  @HiveField(24)
  int sideGigIncome;

  @HiveField(25)
  String relationshipStatus; // 'Single', 'Dating', 'Engaged', 'Married', 'Divorced', 'Widowed'
  @HiveField(26)
  String partnerName; // name of current partner, '' if none
  @HiveField(27)
  String partnerJob; // partner's job title
  @HiveField(28)
  String partnerPersonality; // e.g. 'Ambitious', 'Clingy', 'Funny', 'Jealous', 'Calm', 'Spiritual'
  @HiveField(29)
  int relationshipScore; // 0–100, health of current relationship
  @HiveField(30)
  int numberOfChildren; // total children
  @HiveField(31)
  bool isCheating; // true if player is seeing someone on the side
  @HiveField(32)
  String sidePartnerName; // name of person being cheated with, '' if not cheating

  @HiveField(33)
  String housingStatus; // 'With Parents', 'Renting', 'Homeowner'
  @HiveField(34)
  int rentExpensePerYear; // money stat deducted per age-up while renting
  @HiveField(35)
  List<String> businessNames; // names of all owned businesses
  @HiveField(36)
  List<String> businessTypes; // type matching by index
  @HiveField(37)
  List<int> businessHealthList; // health 0–100 per business
  @HiveField(38)
  List<int> businessIncomeList; // monthly income per business in GHS
  @HiveField(39)
  int totalBusinessIncome; // sum of all business incomes

  @HiveField(40)
  String causeOfDeath; // set when character dies, '' if alive

  @HiveField(41)
  List<String> activeIllnesses; // current illnesses affecting the character

  Character({required this.name, required this.gender})
    : age = 0,
      isAlive = true,
      job = 'None',
      education = 'None',
      lifeLog = [],
      careerPath = 'None',
      careerLevel = 0,
      monthlyIncome = 0,
      educationLevel = 'None',
      isEnrolled = false,
      enrolledIn = '',
      yearsLeftInSchool = 0,
      sideGigs = [],
      sideGigIncome = 0,
      relationshipStatus = 'Single',
      partnerName = '',
      partnerJob = '',
      partnerPersonality = '',
      relationshipScore = 0,
      numberOfChildren = 0,
      isCheating = false,
      sidePartnerName = '',
      housingStatus = 'With Parents',
      rentExpensePerYear = 0,
      businessNames = [],
      businessTypes = [],
      businessHealthList = [],
      businessIncomeList = [],
      totalBusinessIncome = 0,
      causeOfDeath = '',
      activeIllnesses = [],
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
      case 'relationshipScore':
        relationshipScore = (relationshipScore + amount).clamp(0, 100);
        break;
      case 'numberOfChildren':
        numberOfChildren = (numberOfChildren + amount).clamp(0, 99);
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
