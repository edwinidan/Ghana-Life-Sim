import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ghana_life_sim/domain/models/business_state.dart';
import 'package:ghana_life_sim/domain/models/financial_transaction.dart';
import 'package:ghana_life_sim/domain/models/timeline_entry.dart';
import 'package:ghana_life_sim/domain/repositories/business_state_repository.dart';
import 'package:ghana_life_sim/domain/repositories/financial_ledger_repository.dart';
import 'package:ghana_life_sim/domain/repositories/timeline_repository.dart';
import 'package:ghana_life_sim/domain/services/event_selection_service.dart';
import 'package:ghana_life_sim/domain/use_cases/age_up_use_case.dart';
import 'package:ghana_life_sim/data/careers.dart';
import 'package:ghana_life_sim/data/education.dart';
import 'package:ghana_life_sim/models/character.dart';
import 'package:ghana_life_sim/models/event.dart';
import 'package:ghana_life_sim/services/business_service.dart';
import 'package:ghana_life_sim/services/activity_service.dart';
import 'package:ghana_life_sim/services/event_choice_service.dart';
import 'package:ghana_life_sim/services/health_service.dart';
import 'package:ghana_life_sim/services/job_service.dart';
import 'package:ghana_life_sim/services/school_service.dart';

enum SimulationStrategy {
  random,
  education,
  career,
  business,
  family,
  highRisk,
  passive,
}

void main(List<String> arguments) {
  final lives = _intArgument(arguments, '--lives', 10000);
  final outputDirectory = _stringArgument(
    arguments,
    '--output',
    'build/reports',
  );
  final stopwatch = Stopwatch()..start();
  final report = _BalanceRunner(lives).run();
  stopwatch.stop();
  report['runtimeSeconds'] = stopwatch.elapsedMilliseconds / 1000;
  report['headlessYearsPerSecond'] =
      (report['totalSimulatedYears'] as int) /
      (report['runtimeSeconds'] as double);

  final directory = Directory(outputDirectory)..createSync(recursive: true);
  final jsonFile = File('${directory.path}/balance_simulation.json');
  final markdownFile = File('${directory.path}/balance_simulation.md');
  jsonFile.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(report),
  );
  markdownFile.writeAsStringSync(_markdown(report));
  stdout.writeln(
    'Completed $lives lives in '
    '${report['runtimeSeconds']} seconds.\n'
    '${jsonFile.path}\n${markdownFile.path}',
  );
}

class _BalanceRunner {
  _BalanceRunner(this.lifeCount);

  final int lifeCount;
  final _ages = <int>[];
  final _causes = <String, int>{};
  final _education = <String, int>{};
  final _careers = <String, int>{};
  final _careerEntries = <String, int>{};
  final _strategyDeaths = <String, List<int>>{};
  final _strategyCash = <String, List<int>>{};
  final _genderAges = <String, List<int>>{};
  final _regionAges = <String, List<int>>{};
  final _events = <String, int>{};
  final _chains = <String, int>{};
  final _cashAtAge = <String, List<int>>{};
  final _debtAtAge = <String, List<int>>{};
  final _employmentYears = <String, int>{};
  final _stageYears = <String, int>{};
  var nssCompleted = 0;
  var everEmployed = 0;
  var businessStarted = 0;
  var profitableBusinessLives = 0;
  var failedBusinessLives = 0;
  var married = 0;
  var withChildren = 0;
  var inDebtAtDeath = 0;
  var stuckLives = 0;
  var repeatedEvents = 0;
  var totalYears = 0;
  var businessYears = 0;
  var businessLossYears = 0;
  var businessStagnantYears = 0;
  var businessRecoveryYears = 0;
  var debtRecoveryLives = 0;

  Map<String, Object> run() {
    for (var seed = 1; seed <= lifeCount; seed++) {
      _runLife(seed);
    }
    _ages.sort();
    return {
      'lives': lifeCount,
      'strategies': SimulationStrategy.values.map((item) => item.name).toList(),
      'averageAgeAtDeath': _average(_ages),
      'medianAgeAtDeath': _median(_ages),
      'deathAgeDistribution': _buckets(_ages),
      'causesOfDeath': _sortedMap(_causes),
      'educationOutcomes': _sortedMap(_education),
      'careerOutcomes': _sortedMap(_careers),
      'everCareerOutcomes': _sortedMap(_careerEntries),
      'nssCompletionRate': nssCompleted / lifeCount,
      'everEmployedRate': everEmployed / lifeCount,
      'businessStartRate': businessStarted / lifeCount,
      'profitableBusinessLifeRate': profitableBusinessLives / lifeCount,
      'businessFailureLifeRate': failedBusinessLives / lifeCount,
      'businessLossYearRate': _rate(businessLossYears, businessYears),
      'businessStagnantYearRate': _rate(businessStagnantYears, businessYears),
      'businessRecoveryYearRate': _rate(businessRecoveryYears, businessYears),
      'marriageRate': married / lifeCount,
      'childrenRate': withChildren / lifeCount,
      'debtAtDeathRate': inDebtAtDeath / lifeCount,
      'debtRecoveryLifeRate': debtRecoveryLives / lifeCount,
      'stuckProgressionRate': stuckLives / lifeCount,
      'eventRepetitionCount': repeatedEvents,
      'topEvents': _top(_events, 25),
      'chainCompletions': _sortedMap(_chains),
      'strategyAverageDeathAge': _averages(_strategyDeaths),
      'strategyAverageFinalCash': _averages(_strategyCash),
      'genderAverageDeathAge': _averages(_genderAges),
      'regionAverageDeathAge': _averages(_regionAges),
      'cashAtMajorAges': _averages(_cashAtAge),
      'debtAtMajorAges': _averages(_debtAtAge),
      'employmentRateByLifeStage': {
        for (final entry in _stageYears.entries)
          entry.key: _rate(_employmentYears[entry.key] ?? 0, entry.value),
      },
      'totalSimulatedYears': totalYears,
    };
  }

  void _runLife(int seed) {
    final strategy = SimulationStrategy
        .values[(seed - 1) % SimulationStrategy.values.length];
    final random = Random(seed);
    final character = _character(seed);
    final useCase = const AgeUpUseCase(
      eventSelection: EventSelectionService(),
      timelineRepository: _NoopTimelineRepository(),
      ledgerRepository: _NoopLedgerRepository(),
    );
    var hadJob = false;
    var hadBusiness = false;
    var hadProfit = false;
    var hadFailure = false;
    var noDecisionYears = 0;
    var recoveredDebt = false;
    final seenEvents = <String>{};
    final seenCareerPaths = <String>{};
    final previousBusinessStatuses = <String, BusinessStatus>{};

    while (!character.isDead && character.age < 110) {
      final debtEnteringYear = character.debt;
      _prepareYear(character, strategy, random);
      final debtBefore = character.debt;
      if (debtEnteringYear > 0 && debtBefore == 0) recoveredDebt = true;
      final result = useCase.execute(character);
      totalYears++;
      final stage = character.lifeStage;
      _stageYears.update(stage, (count) => count + 1, ifAbsent: () => 1);
      if (character.careerPath != 'None') {
        seenCareerPaths.add(character.careerPath);
        _employmentYears.update(stage, (count) => count + 1, ifAbsent: () => 1);
      }
      if (debtBefore > 0 && character.debt == 0) recoveredDebt = true;
      if (const [18, 30, 45, 60].contains(character.age)) {
        _add(_cashAtAge, '${character.age}', character.cash);
        _add(_debtAtAge, '${character.age}', character.debt);
      }
      if (character.careerPath != 'None') hadJob = true;
      if (character.businessStateRecords.isNotEmpty) hadBusiness = true;
      for (final business in const BusinessStateRepository().read(character)) {
        if (business.history.isNotEmpty &&
            business.history.last.age == character.age) {
          businessYears++;
          if (business.lastAnnualProfit < 0) businessLossYears++;
          if (business.annualRevenue > 0 &&
              business.lastAnnualProfit.abs() <=
                  (business.annualRevenue * 0.05).round()) {
            businessStagnantYears++;
          }
          if (previousBusinessStatuses[business.id] ==
                  BusinessStatus.struggling &&
              business.status == BusinessStatus.active) {
            businessRecoveryYears++;
          }
        }
        previousBusinessStatuses[business.id] = business.status;
        if (business.lastAnnualProfit > 0) hadProfit = true;
        if (business.status == BusinessStatus.failed) hadFailure = true;
      }
      if (result.decisions.isEmpty) noDecisionYears++;
      for (final event in result.decisions) {
        if (!seenEvents.add(event.stableId)) repeatedEvents++;
        _events.update(event.stableId, (count) => count + 1, ifAbsent: () => 1);
        if (event.chainId != null) {
          _chains.update(
            event.chainId!,
            (count) => count + 1,
            ifAbsent: () => 1,
          );
        }
        final choice = _choose(event, strategy, random);
        EventChoiceService.applyChoice(character, choice);
        character.eventHistory.add('${character.age}:${event.stableId}');
        character.choiceHistory.add(
          '${character.age}:${event.stableId}:${choice.text.hashCode}',
        );
      }
      character.pendingDecisionIds.clear();
    }

    if (character.causeOfDeath.isEmpty) {
      character.causeOfDeath = HealthService.determineCauseOfDeath(character);
    }
    _ages.add(character.age);
    _causes.update(
      _causeCategory(character),
      (count) => count + 1,
      ifAbsent: () => 1,
    );
    _education.update(
      character.educationLevel,
      (count) => count + 1,
      ifAbsent: () => 1,
    );
    _careers.update(
      character.careerPath,
      (count) => count + 1,
      ifAbsent: () => 1,
    );
    for (final path in seenCareerPaths) {
      _careerEntries.update(path, (count) => count + 1, ifAbsent: () => 1);
    }
    if (character.hasFlag('nss_completed')) nssCompleted++;
    if (hadJob) everEmployed++;
    if (hadBusiness) businessStarted++;
    if (hadProfit) profitableBusinessLives++;
    if (hadFailure) failedBusinessLives++;
    if (character.relationshipStatus == 'Married') married++;
    if (character.numberOfChildren > 0) withChildren++;
    if (character.debt > 0) inDebtAtDeath++;
    if (recoveredDebt) debtRecoveryLives++;
    if (noDecisionYears > character.age * 0.8) stuckLives++;
    _add(_strategyDeaths, strategy.name, character.age);
    _add(_strategyCash, strategy.name, character.cash);
    _add(_genderAges, character.gender, character.age);
    _add(_regionAges, character.birthRegion, character.age);
  }

  Character _character(int seed) {
    const regions = [
      'Greater Accra',
      'Ashanti',
      'Central',
      'Eastern',
      'Western',
      'Volta',
      'Northern',
      'Upper East',
      'Upper West',
      'Bono',
    ];
    return Character(name: 'Sim $seed', gender: seed.isEven ? 'Female' : 'Male')
      ..lifeSeed = seed
      ..birthRegion = regions[seed % regions.length]
      ..birthYear = 2026
      ..health = 60 + seed % 31
      ..happiness = 50 + seed * 3 % 31
      ..smarts = 30 + seed * 5 % 51
      ..looks = 30 + seed * 7 % 51
      ..money = 10 + seed % 31
      ..reputation = 25 + seed * 11 % 41
      ..discipline = 30 + seed * 13 % 51
      ..streetSense = 25 + seed * 17 % 51
      ..connections = 15 + seed * 19 % 51
      ..cash = 400 + seed * 23 % 2101
      ..familyNames = ['Parent A', 'Parent B']
      ..familyRelations = ['Mother', 'Father']
      ..familyAges = [28 + seed % 12, 30 + seed % 14]
      ..familyBondScores = [55 + seed % 25, 50 + seed % 25]
      ..familyAlive = [true, true]
      ..timelineRecords = []
      ..annualLedgerRecords = [];
  }

  void _prepareYear(
    Character character,
    SimulationStrategy strategy,
    Random random,
  ) {
    if ((strategy == SimulationStrategy.career ||
            strategy == SimulationStrategy.education) &&
        character.actionEnergy > 0) {
      if (character.careerPath != 'None') {
        JobService.workHard(character);
      } else {
        final study = ActivityService.options.firstWhere(
          (option) => option.id == 'study',
        );
        ActivityService.performActivity(character, study);
      }
    }
    if (strategy != SimulationStrategy.passive &&
        character.debt > 0 &&
        character.cash >= 500 &&
        character.actionEnergy > 0) {
      final repayment = ActivityService.options.firstWhere(
        (option) => option.id == 'debt_repayment',
      );
      ActivityService.performActivity(character, repayment);
    }
    if (!character.isEnrolled) {
      final programmes = SchoolService.getAvailablePrograms(character);
      if (programmes.isNotEmpty &&
          (strategy == SimulationStrategy.education ||
              strategy == SimulationStrategy.career ||
              random.nextDouble() < 0.45)) {
        final selected = strategy == SimulationStrategy.career
            ? _careerProgramme(character, programmes)
            : strategy == SimulationStrategy.education
            ? programmes[random.nextInt(programmes.length)]
            : programmes[random.nextInt(programmes.length)];
        SchoolService.enroll(character, selected);
      }
    }
    if (character.age >= 18 &&
        character.careerPath == 'None' &&
        (!character.isEnrolled ||
            (strategy != SimulationStrategy.education &&
                strategy != SimulationStrategy.career))) {
      final jobs = JobService.getAvailableJobs(character);
      if (jobs.isNotEmpty &&
          strategy != SimulationStrategy.passive &&
          (strategy == SimulationStrategy.career ||
              random.nextDouble() < 0.35)) {
        final selected = strategy == SimulationStrategy.career
            ? jobs.firstWhere(
                (career) =>
                    career.name ==
                    allCareers[(character.lifeSeed ~/
                                SimulationStrategy.values.length) %
                            allCareers.length]
                        .name,
                orElse: () => jobs[random.nextInt(jobs.length)],
              )
            : jobs[random.nextInt(jobs.length)];
        JobService.applyForJob(character, selected, random: random);
      }
    }
    if (character.age >= 18 &&
        character.sideGigs.isEmpty &&
        strategy != SimulationStrategy.passive) {
      final gigs = JobService.getAvailableSideGigs(character);
      if (gigs.isNotEmpty && random.nextDouble() < 0.22) {
        final gig = gigs[random.nextInt(gigs.length)];
        character.sideGigs.add(gig.name);
        character.sideGigIncome = gig.monthlyIncome;
      }
    }
    if (strategy == SimulationStrategy.business &&
        character.age >= 20 &&
        character.businessStateRecords.isEmpty) {
      final definitions = BusinessService.getAvailableBusinessTypes(character);
      if (definitions.isNotEmpty) {
        final definition = definitions.first;
        final cost = BusinessService.startupCashCost(definition);
        character.adjustCash(-cost);
        character.businessStateRecords = [
          BusinessState(
            id: 'business-${character.lifeSeed}',
            definitionId: definition.id,
            displayName: 'Sim Enterprise',
            startedAtAge: character.age,
            risk: definition.baseRisk,
          ).encode(),
        ];
      }
    }
    if (strategy == SimulationStrategy.family && character.age == 22) {
      character
        ..relationshipStatus = 'Dating'
        ..partnerName = 'Partner'
        ..relationshipScore = 75;
    }
    if (strategy == SimulationStrategy.family &&
        character.age == 25 &&
        character.relationshipStatus == 'Dating') {
      character.relationshipStatus = 'Married';
      character.relationshipScore = 80;
    }
    if (strategy == SimulationStrategy.family &&
        character.relationshipStatus == 'Married' &&
        character.age >= 27 &&
        character.numberOfChildren == 0) {
      character.addChild(name: 'Child', gender: 'girl');
    }
    if (strategy == SimulationStrategy.highRisk && character.age >= 16) {
      character.addTimedFlag('risky_hustle_trouble', 8);
      if (random.nextDouble() < 0.35) {
        character.adjustCash(700);
        character.adjustDebt(350);
      }
    }
  }

  EducationProgram _careerProgramme(
    Character character,
    List<EducationProgram> programmes,
  ) {
    final target =
        allCareers[(character.lifeSeed ~/ SimulationStrategy.values.length) %
                allCareers.length]
            .name;
    final preferredIds = switch (target) {
      'Healthcare' => [
        'nss_health',
        'university_health',
        'nursing_training',
        'shs',
      ],
      'Education' => [
        'nss_education',
        'university_education',
        'teacher_training',
        'shs',
      ],
      'Tech' => [
        'nss_technology',
        'university_technology',
        'technical_university',
        'shs',
        'tvet',
      ],
      'Commerce' => ['nss_private', 'university_business', 'shs'],
      'Sports & Media' ||
      'Entertainment' => ['nss_media', 'university_media', 'shs'],
      'Civil Service' => ['nss_public', 'university_business', 'shs'],
      'Trade' => ['tvet', 'apprenticeship', 'shs'],
      _ => ['shs'],
    };
    for (final id in preferredIds) {
      for (final programme in programmes) {
        if (programme.id == id) return programme;
      }
    }
    return programmes.first;
  }

  EventChoice _choose(
    LifeEvent event,
    SimulationStrategy strategy,
    Random random,
  ) {
    if (strategy == SimulationStrategy.random ||
        strategy == SimulationStrategy.passive) {
      return event.choices[random.nextInt(event.choices.length)];
    }
    int score(EventChoice choice) {
      final stats = choice.statChanges;
      return switch (strategy) {
        SimulationStrategy.education =>
          (stats['smarts'] ?? 0) * 4 + (stats['discipline'] ?? 0) * 2,
        SimulationStrategy.career =>
          (stats['discipline'] ?? 0) * 3 +
              (stats['connections'] ?? 0) * 2 +
              choice.cashChange ~/ 100,
        SimulationStrategy.business =>
          (stats['streetSense'] ?? 0) * 3 +
              (stats['connections'] ?? 0) * 2 +
              choice.cashChange ~/ 100,
        SimulationStrategy.family =>
          (stats['happiness'] ?? 0) * 2 +
              (stats['reputation'] ?? 0) * 2 +
              choice.familyBondChange * 3,
        SimulationStrategy.highRisk =>
          (stats['streetSense'] ?? 0) * 4 + choice.cashChange ~/ 100,
        _ => 0,
      };
    }

    return event.choices.reduce(
      (best, candidate) => score(candidate) > score(best) ? candidate : best,
    );
  }

  String _causeCategory(Character character) {
    if (character.activeIllnesses.isNotEmpty) {
      return character.activeIllnesses.last;
    }
    if (character.age >= 100) return 'advanced_age';
    if (character.health <= 0) return 'health_failure';
    return 'other';
  }

  void _add(Map<String, List<int>> map, String key, int value) {
    map.putIfAbsent(key, () => []).add(value);
  }
}

class _NoopTimelineRepository extends TimelineRepository {
  const _NoopTimelineRepository();

  @override
  void add(Character character, TimelineEntry entry) {}
}

class _NoopLedgerRepository extends FinancialLedgerRepository {
  const _NoopLedgerRepository();

  @override
  void appendAll(
    Character character,
    Iterable<FinancialTransaction> transactions,
  ) {}
}

int _intArgument(List<String> arguments, String name, int fallback) {
  final value = _stringArgument(arguments, name, '$fallback');
  return int.tryParse(value) ?? fallback;
}

String _stringArgument(List<String> arguments, String name, String fallback) {
  final prefix = '$name=';
  for (final argument in arguments) {
    if (argument.startsWith(prefix)) return argument.substring(prefix.length);
  }
  return fallback;
}

double _average(List<int> values) =>
    values.isEmpty ? 0 : values.reduce((a, b) => a + b) / values.length;

double _rate(int numerator, int denominator) =>
    denominator == 0 ? 0 : numerator / denominator;

double _median(List<int> sorted) {
  if (sorted.isEmpty) return 0;
  final middle = sorted.length ~/ 2;
  return sorted.length.isOdd
      ? sorted[middle].toDouble()
      : (sorted[middle - 1] + sorted[middle]) / 2;
}

Map<String, int> _buckets(List<int> ages) {
  final buckets = <String, int>{};
  for (final age in ages) {
    final lower = age ~/ 10 * 10;
    final key = '$lower-${lower + 9}';
    buckets.update(key, (count) => count + 1, ifAbsent: () => 1);
  }
  return buckets;
}

Map<String, int> _sortedMap(Map<String, int> values) {
  final entries = values.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return {for (final entry in entries) entry.key: entry.value};
}

Map<String, int> _top(Map<String, int> values, int count) =>
    Map.fromEntries(_sortedMap(values).entries.take(count));

Map<String, double> _averages(Map<String, List<int>> values) => {
  for (final entry in values.entries) entry.key: _average(entry.value),
};

String _markdown(Map<String, Object> report) {
  String percent(String key) =>
      '${((report[key] as num) * 100).toStringAsFixed(1)}%';
  return '''
# Ghana Life Sim Balance Simulation

- Lives: ${report['lives']}
- Runtime: ${report['runtimeSeconds']} seconds
- Average age at death: ${report['averageAgeAtDeath']}
- Median age at death: ${report['medianAgeAtDeath']}
- Ever employed: ${percent('everEmployedRate')}
- NSS completion: ${percent('nssCompletionRate')}
- Business started: ${percent('businessStartRate')}
- Profitable business life: ${percent('profitableBusinessLifeRate')}
- Business failure life: ${percent('businessFailureLifeRate')}
- Business loss years: ${percent('businessLossYearRate')}
- Business stagnant years: ${percent('businessStagnantYearRate')}
- Business recovery years: ${percent('businessRecoveryYearRate')}
- Married at death: ${percent('marriageRate')}
- Had children: ${percent('childrenRate')}
- Debt at death: ${percent('debtAtDeathRate')}
- Recovered from debt at least once: ${percent('debtRecoveryLifeRate')}
- Stuck progression: ${percent('stuckProgressionRate')}
- Repeated events: ${report['eventRepetitionCount']}
- Simulated years: ${report['totalSimulatedYears']}
- Headless years/second: ${report['headlessYearsPerSecond']}

## Strategy average death age

`${jsonEncode(report['strategyAverageDeathAge'])}`

## Strategy average final cash

`${jsonEncode(report['strategyAverageFinalCash'])}`

## Education outcomes

`${jsonEncode(report['educationOutcomes'])}`

## Career outcomes

`${jsonEncode(report['careerOutcomes'])}`

## Ever entered career paths

`${jsonEncode(report['everCareerOutcomes'])}`

## Death causes

`${jsonEncode(report['causesOfDeath'])}`

## Gender comparison

`${jsonEncode(report['genderAverageDeathAge'])}`

## Region comparison

`${jsonEncode(report['regionAverageDeathAge'])}`

## Economy at major ages

Cash: `${jsonEncode(report['cashAtMajorAges'])}`

Debt: `${jsonEncode(report['debtAtMajorAges'])}`

## Employment by life stage

`${jsonEncode(report['employmentRateByLifeStage'])}`

## Consequence-chain appearances

`${jsonEncode(report['chainCompletions'])}`
''';
}
