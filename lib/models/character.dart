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

  @HiveField(42, defaultValue: 1000)
  int cash; // actual spendable money in GHS
  @HiveField(43, defaultValue: 0)
  int debt; // outstanding debt in GHS
  @HiveField(44, defaultValue: [])
  List<String> flags; // long-term consequences and story states
  @HiveField(45, defaultValue: [])
  List<String> childNames;
  @HiveField(46, defaultValue: [])
  List<String> childGenders;
  @HiveField(47, defaultValue: [])
  List<int> childAges;
  @HiveField(48, defaultValue: [])
  List<int> childBondScores;
  @HiveField(49, defaultValue: [])
  List<String> familyNames;
  @HiveField(50, defaultValue: [])
  List<String> familyRelations;
  @HiveField(51, defaultValue: [])
  List<int> familyAges;
  @HiveField(52, defaultValue: [])
  List<int> familyBondScores;
  @HiveField(53, defaultValue: [])
  List<bool> familyAlive;
  @HiveField(54, defaultValue: 3)
  int actionEnergy;
  @HiveField(55, defaultValue: '')
  String activeLifeGoalId;
  @HiveField(56, defaultValue: [])
  List<String> completedLifeGoalIds;
  @HiveField(57, defaultValue: false)
  bool deathRewardsRecorded;
  @HiveField(58, defaultValue: 3)
  int schemaVersion;
  @HiveField(59, defaultValue: 0)
  int lifeSeed;
  @HiveField(60, defaultValue: [])
  List<String> eventHistory;
  @HiveField(61, defaultValue: [])
  List<String> choiceHistory;
  @HiveField(62, defaultValue: [])
  List<String> timelineRecords;
  @HiveField(63, defaultValue: 'Greater Accra')
  String birthRegion;
  @HiveField(64, defaultValue: '')
  String originSummary;
  @HiveField(65, defaultValue: 'Getting By')
  String householdClass;
  @HiveField(66, defaultValue: 0)
  int birthYear;
  @HiveField(67, defaultValue: [])
  List<String> businessStateRecords;
  @HiveField(68, defaultValue: [])
  List<String> illnessStateRecords;
  @HiveField(69, defaultValue: [])
  List<String> annualLedgerRecords;
  @HiveField(70, defaultValue: [])
  List<String> committedYearIds;
  @HiveField(71, defaultValue: [])
  List<String> consequenceRecords;
  @HiveField(72, defaultValue: [])
  List<String> pendingDecisionIds;

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
      cash = _randomStat(400, 2500),
      debt = 0,
      flags = [],
      childNames = [],
      childGenders = [],
      childAges = [],
      childBondScores = [],
      familyNames = [],
      familyRelations = [],
      familyAges = [],
      familyBondScores = [],
      familyAlive = [],
      actionEnergy = 3,
      activeLifeGoalId = '',
      completedLifeGoalIds = [],
      deathRewardsRecorded = false,
      schemaVersion = 3,
      lifeSeed = Random.secure().nextInt(0x7fffffff),
      eventHistory = [],
      choiceHistory = [],
      timelineRecords = [],
      birthRegion = 'Greater Accra',
      originSummary = '',
      householdClass = 'Getting By',
      birthYear = DateTime.now().year,
      businessStateRecords = [],
      illnessStateRecords = [],
      annualLedgerRecords = [],
      committedYearIds = [],
      consequenceRecords = [],
      pendingDecisionIds = [],
      health = _randomStat(60, 90),
      happiness = _randomStat(50, 80),
      smarts = _randomStat(30, 80),
      looks = _randomStat(30, 80),
      money = _randomStat(5, 30),
      reputation = _randomStat(20, 50),
      discipline = _randomStat(20, 70),
      streetSense = _randomStat(20, 60),
      connections = _randomStat(10, 40) {
    ensureFamilySeeded();
    originSummary =
        'You were born in $birthRegion to a family that is $householdClass. '
        'Your story is only beginning.';
  }

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

  void adjustCash(int amount) {
    cash = (cash + amount).clamp(0, 1000000000);
  }

  void adjustDebt(int amount) {
    debt = (debt + amount).clamp(0, 1000000000);
  }

  void addFlag(String flag) {
    if (!flags.contains(flag)) flags.add(flag);
    if (!consequenceRecords.any((record) => record.startsWith('$flag|'))) {
      consequenceRecords.add('$flag|$age|-1');
    }
  }

  void removeFlag(String flag) {
    flags.remove(flag);
    consequenceRecords.removeWhere((record) => record.startsWith('$flag|'));
  }

  bool hasFlag(String flag) => flags.contains(flag);

  void addTimedFlag(String flag, int durationYears) {
    addFlag(flag);
    consequenceRecords.removeWhere((record) => record.startsWith('$flag|'));
    consequenceRecords.add('$flag|$age|${age + durationYears}');
  }

  int? flagSetAge(String flag) {
    final matches = consequenceRecords.where(
      (record) => record.startsWith('$flag|'),
    );
    if (matches.isEmpty) return null;
    return int.tryParse(matches.first.split('|')[1]);
  }

  void expireConsequences() {
    final expired = <String>[];
    for (final record in consequenceRecords) {
      final parts = record.split('|');
      if (parts.length < 3) continue;
      final expiresAt = int.tryParse(parts[2]) ?? -1;
      if (expiresAt >= 0 && age >= expiresAt) expired.add(parts[0]);
    }
    for (final flag in expired) {
      removeFlag(flag);
    }
  }

  void addChild({
    required String name,
    required String gender,
    int bondScore = 60,
  }) {
    final previousCount = numberOfChildren;
    childNames.add(name);
    childGenders.add(gender);
    childAges.add(0);
    childBondScores.add(bondScore.clamp(0, 100));
    numberOfChildren = previousCount > childNames.length
        ? previousCount + 1
        : childNames.length;
  }

  void adjustChildBonds(int amount) {
    for (var i = 0; i < childBondScores.length; i++) {
      childBondScores[i] = (childBondScores[i] + amount).clamp(0, 100);
    }
  }

  void ageChildren() {
    for (var i = 0; i < childAges.length; i++) {
      childAges[i]++;
    }
    numberOfChildren = childNames.length;
  }

  void ensureFamilySeeded() {
    if (familyNames.isNotEmpty) return;

    final motherNames = ['Akosua', 'Ama', 'Efua', 'Abena', 'Adjoa'];
    final fatherNames = ['Kwame', 'Kofi', 'Yaw', 'Kojo', 'Fiifi'];
    final siblingNames = ['Nana', 'Yaw', 'Afia', 'Kweku', 'Esi'];

    addFamilyMember(
      name: motherNames[Random().nextInt(motherNames.length)],
      relation: 'Mother',
      age: age + _randomStat(23, 39),
      bondScore: _randomStat(55, 85),
    );
    addFamilyMember(
      name: fatherNames[Random().nextInt(fatherNames.length)],
      relation: 'Father',
      age: age + _randomStat(25, 43),
      bondScore: _randomStat(45, 80),
    );

    if (Random().nextBool()) {
      addFamilyMember(
        name: siblingNames[Random().nextInt(siblingNames.length)],
        relation: 'Sibling',
        age: (age + _randomStat(-3, 5)).clamp(0, 99),
        bondScore: _randomStat(45, 80),
      );
    }
  }

  void addFamilyMember({
    required String name,
    required String relation,
    required int age,
    int bondScore = 60,
    bool alive = true,
  }) {
    familyNames.add(name);
    familyRelations.add(relation);
    familyAges.add(age.clamp(0, 120));
    familyBondScores.add(bondScore.clamp(0, 100));
    familyAlive.add(alive);
  }

  void adjustFamilyBonds(int amount) {
    for (var i = 0; i < familyBondScores.length; i++) {
      familyBondScores[i] = (familyBondScores[i] + amount).clamp(0, 100);
    }
  }

  void ageFamily() {
    for (var i = 0; i < familyAges.length; i++) {
      if (i < familyAlive.length && familyAlive[i]) {
        familyAges[i]++;
      }
    }
  }

  double get averageFamilyBond {
    final bonds = [
      ...familyBondScores,
      ...childBondScores,
      if (relationshipStatus == 'Dating' ||
          relationshipStatus == 'Engaged' ||
          relationshipStatus == 'Married')
        relationshipScore,
    ];
    if (bonds.isEmpty) return 0;
    return bonds.reduce((a, b) => a + b) / bonds.length;
  }

  void resetActionEnergy() {
    if (age < 6) {
      actionEnergy = 1;
    } else if (age < 13) {
      actionEnergy = 2;
    } else {
      actionEnergy = 3;
    }
  }

  bool consumeActionEnergy() {
    if (actionEnergy <= 0) return false;
    actionEnergy--;
    return true;
  }

  void completeLifeGoal(String goalId) {
    if (!completedLifeGoalIds.contains(goalId)) {
      completedLifeGoalIds.add(goalId);
    }
  }

  bool get isDead => !isAlive || health <= 0 || age >= 110;

  Character detachedCopy() {
    return Character(name: name, gender: gender)
      ..age = age
      ..isAlive = isAlive
      ..health = health
      ..happiness = happiness
      ..smarts = smarts
      ..looks = looks
      ..money = money
      ..reputation = reputation
      ..discipline = discipline
      ..streetSense = streetSense
      ..connections = connections
      ..job = job
      ..education = education
      ..lifeLog = List<String>.from(lifeLog)
      ..careerPath = careerPath
      ..careerLevel = careerLevel
      ..monthlyIncome = monthlyIncome
      ..educationLevel = educationLevel
      ..isEnrolled = isEnrolled
      ..enrolledIn = enrolledIn
      ..yearsLeftInSchool = yearsLeftInSchool
      ..sideGigs = List<String>.from(sideGigs)
      ..sideGigIncome = sideGigIncome
      ..relationshipStatus = relationshipStatus
      ..partnerName = partnerName
      ..partnerJob = partnerJob
      ..partnerPersonality = partnerPersonality
      ..relationshipScore = relationshipScore
      ..numberOfChildren = numberOfChildren
      ..isCheating = isCheating
      ..sidePartnerName = sidePartnerName
      ..housingStatus = housingStatus
      ..rentExpensePerYear = rentExpensePerYear
      ..businessNames = List<String>.from(businessNames)
      ..businessTypes = List<String>.from(businessTypes)
      ..businessHealthList = List<int>.from(businessHealthList)
      ..businessIncomeList = List<int>.from(businessIncomeList)
      ..totalBusinessIncome = totalBusinessIncome
      ..causeOfDeath = causeOfDeath
      ..activeIllnesses = List<String>.from(activeIllnesses)
      ..cash = cash
      ..debt = debt
      ..flags = List<String>.from(flags)
      ..childNames = List<String>.from(childNames)
      ..childGenders = List<String>.from(childGenders)
      ..childAges = List<int>.from(childAges)
      ..childBondScores = List<int>.from(childBondScores)
      ..familyNames = List<String>.from(familyNames)
      ..familyRelations = List<String>.from(familyRelations)
      ..familyAges = List<int>.from(familyAges)
      ..familyBondScores = List<int>.from(familyBondScores)
      ..familyAlive = List<bool>.from(familyAlive)
      ..actionEnergy = actionEnergy
      ..activeLifeGoalId = activeLifeGoalId
      ..completedLifeGoalIds = List<String>.from(completedLifeGoalIds)
      ..deathRewardsRecorded = deathRewardsRecorded
      ..schemaVersion = schemaVersion
      ..lifeSeed = lifeSeed
      ..eventHistory = List<String>.from(eventHistory)
      ..choiceHistory = List<String>.from(choiceHistory)
      ..timelineRecords = List<String>.from(timelineRecords)
      ..birthRegion = birthRegion
      ..originSummary = originSummary
      ..householdClass = householdClass
      ..birthYear = birthYear
      ..businessStateRecords = List<String>.from(businessStateRecords)
      ..illnessStateRecords = List<String>.from(illnessStateRecords)
      ..annualLedgerRecords = List<String>.from(annualLedgerRecords)
      ..committedYearIds = List<String>.from(committedYearIds)
      ..consequenceRecords = List<String>.from(consequenceRecords)
      ..pendingDecisionIds = List<String>.from(pendingDecisionIds);
  }

  String get lifeStage {
    if (age < 3) return 'Infant';
    if (age < 6) return 'Early Childhood';
    if (age < 13) return 'Child';
    if (age < 18) return 'Teenager';
    if (age < 26) return 'Young Adult';
    if (age < 40) return 'Adult';
    if (age < 60) return 'Middle Age';
    return 'Senior';
  }
}
