import 'package:flutter/material.dart';
import 'dart:math';
import '../models/character.dart';
import '../models/event.dart';
import '../data/events.dart';
import '../services/career_service.dart';
import '../services/school_service.dart';
import '../services/relationship_service.dart';
import 'death_screen.dart';
import 'school_screen.dart';
import 'job_screen.dart';
import 'social_screen.dart';
import 'housing_screen.dart';
import 'business_screen.dart';
import '../services/save_service.dart';
import '../services/housing_service.dart';
import '../services/business_service.dart';
import '../services/health_service.dart';
import '../services/activity_service.dart';
import '../services/life_goal_service.dart';
import '../services/event_choice_service.dart';
import 'achievements_screen.dart';
import 'life_log_screen.dart';

class LifeScreen extends StatefulWidget {
  final Character character;
  const LifeScreen({super.key, required this.character});

  @override
  State<LifeScreen> createState() => _LifeScreenState();
}

class _LifeScreenState extends State<LifeScreen> {
  LifeEvent? _currentEvent;
  final Random _rng = Random();
  final List<LifeEvent> _pendingEvents = [];
  int _selectedTab = 0; // 0=dashboard, 1=career, 2=relationships, 3=assets
  String _previousLifeStage = '';

  static const Map<String, String> _statDescriptions = {
    'health':
        'Your physical wellbeing. Reaches 0 and it\'s over. Protect it. 💪',
    'happiness':
        'How content you are. Affects relationships and life rating. 😊',
    'smarts': 'Your intelligence. Needed for education and tech careers. 🧠',
    'looks': 'Your appearance. Affects romance and entertainment careers. ✨',
    'money':
        'Your financial power. Needed for housing, business, and marriage. 💰',
    'reputation':
        'How Ghana sees you. Affects connections and opportunities. 🌟',
    'discipline':
        'Your work ethic. Needed for promotions and civil service. 📋',
    'streetSense': 'Your hustle instinct. Needed for trade and survival. 🛣️',
    'connections': 'Your network. Opens doors money alone cannot. 🤝',
  };

  @override
  void initState() {
    super.initState();
    LifeGoalService.ensureActiveGoal(widget.character);
    SaveService.saveGame(widget.character);
    _previousLifeStage = widget.character.lifeStage;
  }

  Color _lifeStageColor(String stage) {
    switch (stage) {
      case 'Toddler':
        return const Color(0xFFF8BBD0);
      case 'Child':
        return const Color(0xFFB2DFDB);
      case 'Teenager':
        return const Color(0xFFB39DDB);
      case 'Young Adult':
        return const Color(0xFF90CAF9);
      case 'Adult':
        return const Color(0xFFA5D6A7);
      case 'Middle Aged':
        return const Color(0xFFFFCC80);
      case 'Senior':
        return const Color(0xFFCFD8DC);
      default:
        return const Color(0xFFB39DDB);
    }
  }

  String _avatarEmoji(String gender, String lifeStage) {
    if (gender == 'Male') {
      switch (lifeStage) {
        case 'Toddler':
          return '👶';
        case 'Child':
          return '🧒';
        case 'Teenager':
          return '👦';
        case 'Young Adult':
          return '🧑';
        case 'Adult':
          return '👨';
        case 'Middle Aged':
          return '👨‍🦳';
        case 'Senior':
          return '👴';
        default:
          return '🧑';
      }
    } else {
      switch (lifeStage) {
        case 'Toddler':
          return '👶';
        case 'Child':
          return '🧒';
        case 'Teenager':
          return '👧';
        case 'Young Adult':
          return '🧑';
        case 'Adult':
          return '👩';
        case 'Middle Aged':
          return '👩‍🦳';
        case 'Senior':
          return '👵';
        default:
          return '🧑';
      }
    }
  }

  int _getStatValue(String stat) {
    final c = widget.character;
    switch (stat) {
      case 'health':
        return c.health;
      case 'happiness':
        return c.happiness;
      case 'smarts':
        return c.smarts;
      case 'looks':
        return c.looks;
      case 'money':
        return c.money;
      case 'reputation':
        return c.reputation;
      case 'discipline':
        return c.discipline;
      case 'streetSense':
        return c.streetSense;
      case 'connections':
        return c.connections;
      case 'relationshipScore':
        return c.relationshipScore;
      default:
        return 0;
    }
  }

  bool _isEventValid(LifeEvent event) {
    final c = widget.character;
    final ageOk = c.age >= event.minAge && c.age <= event.maxAge;
    final earlyAgeOk = c.age < 4
        ? event.maxAge <= 6
        : c.age < 6
        ? event.minAge <= 5 && event.maxAge <= 12
        : true;
    final careerOk =
        event.requiredCareer == null || event.requiredCareer == c.careerPath;
    final relationshipOk =
        event.requiredRelationshipStatus == null ||
        event.requiredRelationshipStatus == c.relationshipStatus;
    final housingOk =
        event.requiredHousingStatus == null ||
        event.requiredHousingStatus == c.housingStatus;
    final businessOk =
        event.requiresBusiness == null ||
        event.requiresBusiness == c.businessNames.isNotEmpty;
    final statsOk = event.statRequirements.entries.every(
      (entry) => _getStatValue(entry.key) >= entry.value,
    );
    final flagsOk =
        event.requiredFlags.every(c.hasFlag) &&
        event.blockedFlags.every((flag) => !c.hasFlag(flag));

    return ageOk &&
        earlyAgeOk &&
        careerOk &&
        relationshipOk &&
        housingOk &&
        businessOk &&
        statsOk &&
        flagsOk;
  }

  int _eventWeight(LifeEvent event) {
    final c = widget.character;
    var weight = event.baseWeight.clamp(1, 100);

    if (c.health < 35 && event.title.toLowerCase().contains('health')) {
      weight += 12;
    }
    if (c.money < 25 && event.title.toLowerCase().contains('money')) {
      weight += 8;
    }
    if (c.relationshipStatus != 'Single' &&
        event.requiredRelationshipStatus == c.relationshipStatus) {
      weight += 10;
    }
    if (c.careerPath != 'None' && event.requiredCareer == c.careerPath) {
      weight += 10;
    }
    if (c.businessNames.isNotEmpty && event.requiresBusiness == true) {
      weight += 10;
    }
    if (c.lifeLog.take(8).any((log) => log.contains(event.title))) {
      weight = (weight / 3).round();
    }

    return weight.clamp(1, 150);
  }

  List<LifeEvent> _pickYearEvents(List<LifeEvent> validEvents) {
    if (validEvents.isEmpty) return [];

    final count = _eventsThisYear().clamp(1, validEvents.length);
    final pool = List<LifeEvent>.from(validEvents);
    final selected = <LifeEvent>[];

    for (var i = 0; i < count; i++) {
      final totalWeight = pool.fold<int>(
        0,
        (sum, event) => sum + _eventWeight(event),
      );
      var roll = _rng.nextInt(totalWeight);
      for (final event in pool) {
        roll -= _eventWeight(event);
        if (roll < 0) {
          selected.add(event);
          pool.remove(event);
          break;
        }
      }
      if (pool.isEmpty) break;
    }

    return selected;
  }

  LifeEvent _fallbackEventForAge() {
    final age = widget.character.age;
    if (age < 4) {
      return const LifeEvent(
        title: 'A Quiet Family Year 🏠',
        description:
            'This year was small but not empty. You grew, watched faces, listened to voices, and learned who feels safe.',
        choices: [
          EventChoice(
            text: 'Stay close to family',
            statChanges: {'happiness': 3, 'health': 2},
            familyBondChange: 3,
            outcome:
                'You stayed close to your people. The bond around you grew stronger.',
          ),
          EventChoice(
            text: 'Explore everything you can reach',
            statChanges: {'smarts': 3, 'streetSense': 2, 'health': -1},
            outcome:
                'You explored the house with tiny determination. Some lessons came from bumps.',
          ),
        ],
      );
    }
    if (age < 13) {
      return const LifeEvent(
        title: 'Ordinary Childhood Day 🌤️',
        description:
            'No big ceremony, no disaster. Just school, chores, family noise, and the small choices that shape a child.',
        choices: [
          EventChoice(
            text: 'Do your chores properly',
            statChanges: {'discipline': 3, 'reputation': 2},
            familyBondChange: 2,
            outcome:
                'You handled your chores without drama. Your family noticed the effort.',
          ),
          EventChoice(
            text: 'Sneak outside to play',
            statChanges: {'happiness': 4, 'streetSense': 2, 'discipline': -2},
            outcome:
                'You played until your name was shouted from the doorway. Worth it, mostly.',
          ),
        ],
      );
    }
    return const LifeEvent(
      title: 'A Year Of Decisions 🧭',
      description:
          'Life did not bring one huge headline this year, but pressure still arrived in small ways.',
      choices: [
        EventChoice(
          text: 'Stay disciplined',
          statChanges: {'discipline': 3, 'smarts': 1, 'happiness': -1},
          outcome: 'You kept your head down and handled the year with focus.',
        ),
        EventChoice(
          text: 'Chase joy where you can',
          statChanges: {'happiness': 4, 'discipline': -1},
          outcome:
              'You chose some joy. Not every year has to be pure struggle.',
        ),
      ],
    );
  }

  int _eventsThisYear() {
    final age = widget.character.age;
    if (age < 13) return 1;
    if (age >= 61 && _rng.nextDouble() < 0.35) return 3;
    if (age >= 13 && _rng.nextDouble() < 0.45) return 2;
    return 1;
  }

  void _showNextEventDialog() {
    if (_pendingEvents.isEmpty || widget.character.isDead) return;
    _currentEvent = _pendingEvents.removeAt(0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _currentEvent != null) {
        _showEventDialog(_currentEvent!);
      }
    });
  }

  void _ageUp() {
    setState(() {
      widget.character.ensureFamilySeeded();
      widget.character.age++;
      widget.character.ageChildren();
      widget.character.ageFamily();
      widget.character.resetActionEnergy();

      // Life stage transition check
      final newStage = widget.character.lifeStage;
      if (_previousLifeStage.isNotEmpty && newStage != _previousLifeStage) {
        _previousLifeStage = newStage;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showLifeStageModal(newStage);
        });
      } else {
        _previousLifeStage = newStage;
      }

      // Refined aging health decay
      if (widget.character.age >= 80) {
        widget.character.adjustStat('health', -4);
      } else if (widget.character.age >= 65) {
        widget.character.adjustStat('health', -3);
      } else if (widget.character.age >= 50) {
        widget.character.adjustStat('health', -2);
      } else if (widget.character.age >= 40) {
        widget.character.adjustStat('health', -1);
      }
      // No decay under 40

      // Random serious health event chance increasing with age
      if (widget.character.age >= 80 && _rng.nextDouble() < 0.20) {
        widget.character.adjustStat('health', -12);
        widget.character.lifeLog.add(
          'Age ${widget.character.age}: Your body reminded you that 80 is not a joke. 😔',
        );
      } else if (widget.character.age >= 65 && _rng.nextDouble() < 0.10) {
        widget.character.adjustStat('health', -8);
        widget.character.lifeLog.add(
          'Age ${widget.character.age}: A health scare hit you hard this year. 😟',
        );
      } else if (widget.character.age >= 50 && _rng.nextDouble() < 0.05) {
        widget.character.adjustStat('health', -5);
        widget.character.lifeLog.add(
          'Age ${widget.character.age}: Your body is sending you warning signals. 😬',
        );
      }

      // School: progress if enrolled
      if (widget.character.isEnrolled) {
        SchoolService.progressSchool(widget.character);
      }

      // Career: promotion check + income
      if (CareerService.checkPromotion(widget.character)) {
        CareerService.applyPromotion(widget.character);
      }
      final jobAndGigIncome =
          widget.character.monthlyIncome + widget.character.sideGigIncome;
      if (jobAndGigIncome > 0) {
        final yearlyIncome = jobAndGigIncome * 12;
        widget.character.adjustCash(yearlyIncome);
        int incomeGain = (jobAndGigIncome / 1000).floor().clamp(1, 15);
        widget.character.adjustStat('money', incomeGain);
      }

      if (widget.character.debt > 0) {
        final interest = (widget.character.debt * 0.08).ceil().clamp(
          1,
          1000000,
        );
        widget.character.adjustDebt(interest);
        widget.character.adjustStat('happiness', -2);
        widget.character.adjustStat('money', -1);
      }
      if (widget.character.debt > 0) {
        widget.character.addFlag('in_debt');
      } else {
        widget.character.removeFlag('in_debt');
      }
      if (widget.character.cash < 1000) {
        widget.character.addFlag('low_cash');
      } else {
        widget.character.removeFlag('low_cash');
      }
      if (widget.character.numberOfChildren > 0) {
        widget.character.addFlag('has_children');
      } else {
        widget.character.removeFlag('has_children');
      }

      // Relationship progression
      if (widget.character.relationshipStatus == 'Dating' ||
          widget.character.relationshipStatus == 'Married') {
        RelationshipService.progressRelationship(widget.character);
      }

      // Auto-divorce if relationship score hits 0
      if ((widget.character.relationshipStatus == 'Dating' ||
              widget.character.relationshipStatus == 'Married') &&
          widget.character.relationshipScore <= 0) {
        RelationshipService.divorce(widget.character);
      }

      // Housing expense
      HousingService.progressHousing(widget.character);

      if (widget.character.numberOfChildren > 0) {
        final childCost = widget.character.numberOfChildren * 1200;
        if (widget.character.cash >= childCost) {
          widget.character.adjustCash(-childCost);
        } else {
          final shortfall = childCost - widget.character.cash;
          widget.character.cash = 0;
          widget.character.adjustDebt(shortfall);
          widget.character.adjustStat('happiness', -3);
          widget.character.lifeLog.insert(
            0,
            'Age ${widget.character.age}: Child expenses ran over budget, adding GHS $shortfall to debt. Parenting is not small work. 👶',
          );
        }
      }

      // Business progression
      BusinessService.progressBusinesses(widget.character);

      if (widget.character.debt > 0) {
        widget.character.addFlag('in_debt');
      } else {
        widget.character.removeFlag('in_debt');
      }
      if (widget.character.cash < 1000) {
        widget.character.addFlag('low_cash');
      } else {
        widget.character.removeFlag('low_cash');
      }

      final goalBeforeUpdate = LifeGoalService.activeGoal(widget.character);
      final completedGoal = LifeGoalService.updateGoalProgress(
        widget.character,
      );
      if (completedGoal) {
        widget.character.lifeLog.insert(
          0,
          'Age ${widget.character.age}: Life goal completed. ${goalBeforeUpdate?.title ?? 'A major goal'} is now part of your legacy.',
        );
      }

      final validEvents = allEvents.where(_isEventValid).toList();

      if (!widget.character.isDead) {
        _pendingEvents
          ..clear()
          ..addAll(
            validEvents.isEmpty
                ? [_fallbackEventForAge()]
                : _pickYearEvents(validEvents),
          );
        _showNextEventDialog();
      }

      if (widget.character.isDead) {
        _navToDeath();
      }
      SaveService.saveGame(widget.character);
    });
  }

  void _makeChoice(EventChoice choice) {
    Navigator.of(context, rootNavigator: true).pop(); // close dialog
    setState(() {
      EventChoiceService.applyChoice(widget.character, choice);
      // push to log
      widget.character.lifeLog.insert(
        0,
        'Age ${widget.character.age}: ${_currentEvent!.title} — ${choice.outcome}',
      );
      _currentEvent = null;
      SaveService.saveGame(widget.character);

      if (widget.character.isDead) {
        _navToDeath();
      } else {
        _showNextEventDialog();
      }
    });
  }

  void _navToDeath() {
    if (widget.character.causeOfDeath.isEmpty) {
      widget.character.causeOfDeath = HealthService.determineCauseOfDeath(
        widget.character,
      );
      SaveService.saveGame(widget.character);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DeathScreen(character: widget.character),
        ),
      );
    });
  }

  void _showEventDialog(LifeEvent event) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.2),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7.2,
                        vertical: 3.6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB39DDB).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6.5),
                      ),
                      child: Text(
                        'Age ${widget.character.age}',
                        style: const TextStyle(
                          color: Color(0xFF5E35B1),
                          fontSize: 10.8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.8),
                    Expanded(
                      child: Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 16.2,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF424242),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14.4),
                Text(
                  event.description,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF757575),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 21.6),
                ...event.choices.map((choice) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.8),
                    child: InkWell(
                      onTap: () => _makeChoice(choice),
                      borderRadius: BorderRadius.circular(9.7),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14.4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F7FF),
                          borderRadius: BorderRadius.circular(9.7),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                        ),
                        child: Text(
                          choice.text,
                          style: const TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 12.6,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.character;

    final tabBody = Column(
      children: [
        _buildHeader(),
        Expanded(
          child: _selectedTab == 0
              ? _buildDashboard(c)
              : SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 14.4,
                    bottom: 108,
                  ),
                  child: _buildGroupedTab(c),
                ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      body: Stack(
        children: [
          tabBody,
          Align(alignment: Alignment.bottomCenter, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildDashboard(Character c) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 108),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14.4),
          _buildStatsCard(c),
          const SizedBox(height: 14.4),
          _buildFundsCard(c),
          const SizedBox(height: 14.4),
          _buildLifeGoalCard(c),
          const SizedBox(height: 14.4),
          _buildAgePromptCard(c),
          const SizedBox(height: 14.4),
          _buildActivitiesSection(c),
          if (c.age >= 6) ...[
            const SizedBox(height: 14.4),
            _buildSystemShortcuts(c),
          ],
          const SizedBox(height: 14.4),
          Row(
            children: const [
              Icon(Icons.history, color: Color(0x99B39DDB), size: 18),
              SizedBox(width: 7.2),
              Text(
                'Recent Journey',
                style: TextStyle(
                  fontSize: 14.4,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.8),
          _buildLogList(c),
        ],
      ),
    );
  }

  Widget _buildGroupedTab(Character c) {
    switch (_selectedTab) {
      case 1:
        return _buildCareerHub(c);
      case 2:
        return _buildRelationshipsHub(c);
      case 3:
        return _buildAssetsHub(c);
      default:
        return _buildDashboard(c);
    }
  }

  String _housingBusinessLabel(Character c) {
    final housingEmoji = c.housingStatus == 'Homeowner'
        ? '🏡'
        : c.housingStatus == 'Renting'
        ? '🏠'
        : '🏘️';
    String label = '$housingEmoji ${c.housingStatus}';
    if (c.businessNames.isNotEmpty) {
      label +=
          ' • ${c.businessNames.length} business${c.businessNames.length > 1 ? 'es' : ''}';
    }
    return label;
  }

  String _relationshipLabel(Character c) {
    switch (c.relationshipStatus) {
      case 'Dating':
        return '💕 Dating ${c.partnerName}';
      case 'Engaged':
        return '💍 Engaged to ${c.partnerName}';
      case 'Married':
        return '💒 Married to ${c.partnerName}';
      case 'Divorced':
        return '💔 Divorced';
      case 'Widowed':
        return '🕊️ Widowed';
      default:
        return '';
    }
  }

  void _showLifeStageModal(String stageName) {
    final stageEmojis = {
      'Toddler': '👶',
      'Child': '🧒',
      'Teenager': '🧑',
      'Young Adult': '🧑‍🎓',
      'Adult': '👨',
      'Middle Aged': '👨‍🦳',
      'Senior': '👴',
    };
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                stageEmojis[stageName] ?? '🧑',
                style: const TextStyle(fontSize: 57.6),
              ),
              const SizedBox(height: 14.4),
              Text(
                'NEW LIFE STAGE',
                style: TextStyle(
                  fontSize: 9.9,
                  color: Colors.grey[500],
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7.2),
              Text(
                stageName,
                style: TextStyle(
                  fontSize: 25.2,
                  fontWeight: FontWeight.w900,
                  color: _lifeStageColor(stageName),
                ),
              ),
              const SizedBox(height: 7.2),
              Text(
                _getStageDescription(stageName),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.6,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 21.6),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _lifeStageColor(stageName),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.7),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.6),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Let's Go",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStageDescription(String stage) {
    switch (stage) {
      case 'Child':
        return 'School, chores, and discovering the world. 🌍';
      case 'Teenager':
        return 'Exams, crushes, and questionable decisions. 😅';
      case 'Young Adult':
        return 'University, first jobs, and figuring life out. 🎓';
      case 'Adult':
        return 'Career, relationships, and real responsibilities. 💼';
      case 'Middle Aged':
        return 'You\'ve seen things. Now you manage things. 🧠';
      case 'Senior':
        return 'Legacy time. What will they say about you? 🕊️';
      default:
        return 'A new chapter begins. 📖';
    }
  }

  void _showStatTooltip(
    String statKey,
    String label,
    IconData icon,
    int value,
    Color color,
  ) {
    final description = _statDescriptions[statKey] ?? '';
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21.6)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(21.6, 10.8, 21.6, 28.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 28.8,
              height: 3.6,
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(1.6),
              ),
            ),
            Icon(
              icon,
              size: 43.2,
              color: color == Colors.white ? Colors.grey[400] : color,
            ),
            const SizedBox(height: 10.8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 19.8,
                fontWeight: FontWeight.w900,
                color: Color(0xFF424242),
              ),
            ),
            const SizedBox(height: 14.4),
            // Progress bar
            Container(
              height: 10.8,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(6.5),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: value / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color == Colors.white
                          ? const Color(0xFFB39DDB)
                          : color,
                      borderRadius: BorderRadius.circular(6.5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7.2),
            Text(
              '$value / 100',
              style: TextStyle(
                fontSize: 11.7,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10.8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.6,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(
        top: 45,
        left: 21.6,
        right: 21.6,
        bottom: 14.4,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0x33B39DDB))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 43.2,
                height: 43.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _lifeStageColor(widget.character.lifeStage),
                    width: 2.7,
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    _avatarEmoji(
                      widget.character.gender,
                      widget.character.lifeStage,
                    ),
                    style: const TextStyle(fontSize: 23.4),
                  ),
                ),
              ),
              const SizedBox(width: 10.8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'GHANA LIFE',
                    style: TextStyle(
                      fontSize: 16.2,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF424242),
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'LIVE INTENTIONALLY',
                    style: TextStyle(
                      fontSize: 8.1,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFB39DDB),
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AchievementsScreen()),
                ),
                child: Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(right: 7.2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(9.7),
                    border: Border.all(color: const Color(0xFFFFECB3)),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Color(0xFFFFB300),
                    size: 18,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LifeLogScreen(character: widget.character),
                  ),
                ),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0x0DB39DDB),
                    borderRadius: BorderRadius.circular(9.7),
                    border: Border.all(color: const Color(0x1AB39DDB)),
                  ),
                  child: const Center(
                    child: Text('📖', style: TextStyle(fontSize: 16.2)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(Character c) {
    return Container(
      padding: const EdgeInsets.all(21.6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.4),
        gradient: const LinearGradient(
          colors: [Color(0xFFB39DDB), Color(0xFFD1C4E9), Color(0xFF90CAF9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.name,
                    style: const TextStyle(
                      fontSize: 25.2,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 5.4),
                  Row(
                    children: [
                      Container(
                        width: 7.2,
                        height: 7.2,
                        decoration: const BoxDecoration(
                          color: Color(0xFFB2DFDB),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Color(0xFFB2DFDB), blurRadius: 8),
                          ],
                        ),
                      ),
                      const SizedBox(width: 7.2),
                      Text(
                        c.lifeStage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.6,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if (c.relationshipStatus != 'Single') ...[
                    const SizedBox(height: 3.6),
                    Text(
                      _relationshipLabel(c),
                      style: TextStyle(
                        color: Colors.white.withAlpha(204),
                        fontSize: 10.8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  const SizedBox(height: 3.6),
                  Text(
                    _housingBusinessLabel(c),
                    style: TextStyle(
                      color: Colors.white.withAlpha(179),
                      fontSize: 10.8,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${c.age}',
                    style: const TextStyle(
                      fontSize: 43.2,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  const Text(
                    'YEARS OLD',
                    style: TextStyle(
                      fontSize: 8.1,
                      fontWeight: FontWeight.w900,
                      color: Colors.white70,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 21.6),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3.5,
            crossAxisSpacing: 24,
            mainAxisSpacing: 14,
            children: [
              _buildStatBar(
                'Happiness',
                Icons.sentiment_satisfied,
                c.happiness,
                const Color(0xFFFFF9C4),
                statKey: 'happiness',
                onTap: () => _showStatTooltip(
                  'happiness',
                  'Happiness',
                  Icons.sentiment_satisfied,
                  c.happiness,
                  const Color(0xFFFFF9C4),
                ),
              ),
              _buildStatBar(
                'Health',
                Icons.favorite,
                c.health,
                const Color(0xFFF8BBD0),
                statKey: 'health',
                onTap: () => _showStatTooltip(
                  'health',
                  'Health',
                  Icons.favorite,
                  c.health,
                  const Color(0xFFF8BBD0),
                ),
              ),
              _buildStatBar(
                'Smarts',
                Icons.psychology,
                c.smarts,
                const Color(0xFFB2DFDB),
                statKey: 'smarts',
                onTap: () => _showStatTooltip(
                  'smarts',
                  'Smarts',
                  Icons.psychology,
                  c.smarts,
                  const Color(0xFFB2DFDB),
                ),
              ),
              _buildStatBar(
                'Looks',
                Icons.face,
                c.looks,
                Colors.white,
                statKey: 'looks',
                onTap: () => _showStatTooltip(
                  'looks',
                  'Looks',
                  Icons.face,
                  c.looks,
                  Colors.white,
                ),
              ),
              _buildStatBar(
                'Reputation',
                Icons.star,
                c.reputation,
                const Color(0xFF7C4DFF),
                statKey: 'reputation',
                onTap: () => _showStatTooltip(
                  'reputation',
                  'Reputation',
                  Icons.star,
                  c.reputation,
                  const Color(0xFF7C4DFF),
                ),
              ),
              _buildStatBar(
                'Connect',
                Icons.hub,
                c.connections,
                const Color(0xFF009688),
                statKey: 'connections',
                onTap: () => _showStatTooltip(
                  'connections',
                  'Connections',
                  Icons.hub,
                  c.connections,
                  const Color(0xFF009688),
                ),
              ),
              _buildStatBar(
                'Streets',
                Icons.directions_run,
                c.streetSense,
                const Color(0xFFFF9800),
                statKey: 'streetSense',
                onTap: () => _showStatTooltip(
                  'streetSense',
                  'Street Sense',
                  Icons.directions_run,
                  c.streetSense,
                  const Color(0xFFFF9800),
                ),
              ),
              _buildStatBar(
                'Discipline',
                Icons.timer,
                c.discipline,
                const Color(0xFF3F51B5),
                statKey: 'discipline',
                onTap: () => _showStatTooltip(
                  'discipline',
                  'Discipline',
                  Icons.timer,
                  c.discipline,
                  const Color(0xFF3F51B5),
                ),
              ),
            ],
          ),
          if (c.careerPath != 'None') ...[
            const SizedBox(height: 14.4),
            _buildCareerRow(c),
          ],
        ],
      ),
    );
  }

  Widget _buildCareerRow(Character c) {
    final careerData = CareerService.getCareerData(c);
    final levelTitle =
        (careerData != null &&
            c.careerLevel >= 1 &&
            c.careerLevel <= careerData.levels.length)
        ? careerData.levels[c.careerLevel - 1].title
        : '';
    String fmt(int n) => n.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    final totalIncome = c.monthlyIncome + c.sideGigIncome;
    final incomeText = c.monthlyIncome > 0
        ? 'GHS ${fmt(c.monthlyIncome)} / month'
        : '';
    final totalText = c.sideGigIncome > 0
        ? 'Total: GHS ${fmt(totalIncome)} / month'
        : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.8, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(9.7),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Text('💼', style: TextStyle(fontSize: 16.2)),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${c.careerPath}${levelTitle.isNotEmpty ? ' — $levelTitle' : ''}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.8,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    if (c.educationLevel != 'None') ...[
                      const SizedBox(width: 7.2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.4,
                          vertical: 1.8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.9),
                        ),
                        child: Text(
                          c.educationLevel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (incomeText.isNotEmpty) ...[
                  const SizedBox(height: 1.8),
                  Text(
                    incomeText,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 9.9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                if (c.sideGigs.isNotEmpty) ...[
                  const SizedBox(height: 1.8),
                  Text(
                    '+ ${c.sideGigs.length} side gig${c.sideGigs.length > 1 ? 's' : ''}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 9.9,
                    ),
                  ),
                ],
                if (totalText.isNotEmpty) ...[
                  const SizedBox(height: 1.8),
                  Text(
                    totalText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9.9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(
    String label,
    IconData icon,
    int value,
    Color color, {
    String statKey = '',
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 12.6, color: color),
                  const SizedBox(width: 5.4),
                  Text(
                    label.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Text(
                '$value%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5.4),
          Container(
            height: 9,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.1),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width:
                    (value / 100) * (MediaQuery.of(context).size.width / 2.8),
                height: 9,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundsCard(Character c) {
    String fmt(int n) => n.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.2),
        border: Border.all(color: const Color(0x0DB39DDB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 43.2,
                height: 43.2,
                decoration: BoxDecoration(
                  color: const Color(0xFFB2DFDB).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Color(0xFF009688),
                  size: 21.6,
                ),
              ),
              const SizedBox(width: 14.4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AVAILABLE FUNDS',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF9E9E9E),
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    'GHS ${fmt(c.cash)}',
                    style: const TextStyle(
                      fontSize: 25.2,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF424242),
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                  if (c.debt > 0)
                    Text(
                      'Debt: GHS ${fmt(c.debt)}',
                      style: const TextStyle(
                        fontSize: 10.8,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE53935),
                      ),
                    )
                  else
                    Text(
                      'Financial stability: ${c.money}/100',
                      style: const TextStyle(
                        fontSize: 10.8,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF757575),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Container(
            width: 54,
            height: 5.4,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4.9),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 27,
                decoration: BoxDecoration(
                  color: const Color(0xFFB2DFDB).withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(4.9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogList(Character c) {
    if (c.lifeLog.isEmpty) {
      return const Center(
        child: Text(
          'No journey details yet.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: c.lifeLog.length,
      itemBuilder: (context, index) {
        final log = c.lifeLog[index];
        // Parse format "Age X: Title — Outcome"
        final firstColon = log.indexOf(':');
        String ageStr = '--';
        String outcome = log;
        if (firstColon != -1) {
          ageStr = log.substring(4, firstColon).trim(); // Skip "Age "
          outcome = log.substring(firstColon + 1).trim();
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 14.4),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: const Color(0x0DB39DDB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 32.4,
                      height: 32.4,
                      decoration: BoxDecoration(
                        color: index == 0
                            ? const Color(0xFFB39DDB)
                            : const Color(0xFFF0F0F7),
                        borderRadius: BorderRadius.circular(9.7),
                        boxShadow: index == 0
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFFB39DDB,
                                  ).withValues(alpha: 0.4),
                                  blurRadius: 8,
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          ageStr,
                          style: TextStyle(
                            color: index == 0
                                ? Colors.white
                                : const Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w900,
                            fontSize: 12.6,
                          ),
                        ),
                      ),
                    ),
                    if (index < c.lifeLog.length - 1)
                      Container(
                        width: 1.8,
                        height: 27,
                        margin: const EdgeInsets.symmetric(vertical: 7.2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB39DDB).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(1.6),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 14.4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'AGE $ageStr',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF9E9E9E),
                              letterSpacing: 1.5,
                            ),
                          ),
                          const Icon(
                            Icons.schedule,
                            size: 14.4,
                            color: Color(0xFFE0E0E0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.4),
                      Text(
                        outcome,
                        style: const TextStyle(
                          fontSize: 12.6,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _performActivity(ActivityOption option) {
    final result = ActivityService.performActivity(widget.character, option);
    LifeGoalService.updateGoalProgress(widget.character);
    setState(() {});
    SaveService.saveGame(widget.character);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result.message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: result.success
            ? const Color(0xFF5E35B1)
            : const Color(0xFFE53935),
      ),
    );
  }

  Widget _buildLifeGoalCard(Character c) {
    final goal = LifeGoalService.ensureActiveGoal(c);
    final current = goal.current(c);
    final isComplete = goal.isComplete(c);
    final progress = goal.target == 0 ? 0.0 : current / goal.target;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.2),
        border: Border.all(
          color: isComplete ? const Color(0xFFB2DFDB) : const Color(0x0DB39DDB),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 43.2,
            height: 43.2,
            decoration: BoxDecoration(
              color: isComplete
                  ? const Color(0xFFE0F2F1)
                  : const Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              isComplete ? Icons.check_circle : Icons.flag,
              color: isComplete
                  ? const Color(0xFF009688)
                  : const Color(0xFF7E57C2),
              size: 21.6,
            ),
          ),
          const SizedBox(width: 14.4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ACTIVE LIFE GOAL',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF9E9E9E),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 3.6),
                Text(
                  goal.title,
                  style: const TextStyle(
                    fontSize: 14.4,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF424242),
                  ),
                ),
                const SizedBox(height: 3.6),
                Text(
                  goal.description,
                  style: const TextStyle(
                    fontSize: 10.8,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF757575),
                  ),
                ),
                const SizedBox(height: 9),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.9),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 7.2,
                    backgroundColor: const Color(0xFFF5F5F5),
                    color: isComplete
                        ? const Color(0xFF009688)
                        : const Color(0xFFB39DDB),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.8),
          Text(
            isComplete ? 'DONE' : goal.progressText(c),
            style: TextStyle(
              fontSize: 10.8,
              fontWeight: FontWeight.w900,
              color: isComplete
                  ? const Color(0xFF009688)
                  : const Color(0xFF7E57C2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesSection(Character c) {
    final activities = ActivityService.availableActivities(c);
    final isTired = c.actionEnergy <= 0;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.2),
        border: Border.all(color: const Color(0x0DB39DDB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVITIES',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF9E9E9E),
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 3.6),
                    Text(
                      'Use your yearly energy before aging up.',
                      style: TextStyle(
                        fontSize: 10.8,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.8,
                  vertical: 5.4,
                ),
                decoration: BoxDecoration(
                  color: isTired
                      ? const Color(0xFFFFEBEE)
                      : const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(9.7),
                ),
                child: Text(
                  '${c.actionEnergy} left',
                  style: TextStyle(
                    fontSize: 10.8,
                    fontWeight: FontWeight.w900,
                    color: isTired
                        ? const Color(0xFFE53935)
                        : const Color(0xFF5E35B1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.4),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.55,
              crossAxisSpacing: 10.8,
              mainAxisSpacing: 10.8,
            ),
            itemBuilder: (context, index) {
              return _activityCard(activities[index], isTired);
            },
          ),
        ],
      ),
    );
  }

  Widget _activityCard(ActivityOption option, bool isTired) {
    final cannotAfford = widget.character.cash < option.cashCost;
    final disabled = isTired || cannotAfford;

    return GestureDetector(
      onTap: disabled ? null : () => _performActivity(option),
      child: Opacity(
        opacity: disabled ? 0.55 : 1,
        child: Container(
          padding: const EdgeInsets.all(12.6),
          decoration: BoxDecoration(
            color: const Color(0xFFFCFAFF),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: disabled
                  ? const Color(0xFFE0E0E0)
                  : const Color(0x33B39DDB),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(option.emoji, style: const TextStyle(fontSize: 18)),
                  const Spacer(),
                  if (option.cashCost > 0)
                    Text(
                      'GHS ${option.cashCost}',
                      style: TextStyle(
                        fontSize: 8.8,
                        fontWeight: FontWeight.w900,
                        color: cannotAfford
                            ? const Color(0xFFE53935)
                            : const Color(0xFF009688),
                      ),
                    ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.7,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF424242),
                    ),
                  ),
                  const SizedBox(height: 2.7),
                  Text(
                    cannotAfford ? 'Not enough cash' : option.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 9.9,
                      height: 1.25,
                      color: cannotAfford
                          ? const Color(0xFFE53935)
                          : const Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgePromptCard(Character c) {
    final message = c.age < 4
        ? 'Your world is family, health, first words, and tiny chaos. Age up to live each year through events.'
        : c.age < 13
        ? 'School, chores, church, siblings, and small trouble shape who you become.'
        : c.age < 18
        ? 'Teen years bring exams, reputation, peer pressure, crushes, and first independence.'
        : 'Adult systems are open. Build your career, relationships, assets, and legacy.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.2),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1),
        borderRadius: BorderRadius.circular(16.2),
        border: Border.all(color: const Color(0xFFB2DFDB)),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_stories, color: Color(0xFF00897B), size: 23),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 12.2,
                height: 1.35,
                fontWeight: FontWeight.w700,
                color: Color(0xFF424242),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemShortcuts(Character c) {
    final shortcuts = <Widget>[
      _flowNavCard(
        icon: Icons.school,
        emoji: '📚',
        label: 'Career',
        subtitle: c.age < 13
            ? 'School and childhood growth'
            : 'School, jobs, and side gigs',
        color: const Color(0xFFEDE7F6),
        borderColor: const Color(0xFFB39DDB),
        onTap: () => setState(() => _selectedTab = 1),
      ),
      _flowNavCard(
        icon: Icons.group,
        emoji: '💕',
        label: 'Relationships',
        subtitle: c.age < 13
            ? 'Family bonds for now'
            : 'Family, romance, and children',
        color: const Color(0xFFFFF3F6),
        borderColor: const Color(0xFFF8BBD0),
        onTap: () => setState(() => _selectedTab = 2),
      ),
    ];

    if (c.age >= 13 ||
        c.businessNames.isNotEmpty ||
        c.housingStatus != 'With Parents') {
      shortcuts.add(
        _flowNavCard(
          icon: Icons.account_balance,
          emoji: '🏠',
          label: 'Assets',
          subtitle: c.age < 18
              ? 'Housing unlocks later'
              : 'Housing and businesses',
          color: const Color(0xFFE0F2F1),
          borderColor: const Color(0xFFB2DFDB),
          onTap: () => setState(() => _selectedTab = 3),
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < shortcuts.length; i++) ...[
          shortcuts[i],
          if (i < shortcuts.length - 1) const SizedBox(height: 10.8),
        ],
      ],
    );
  }

  Widget _buildCareerHub(Character c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hubTitle('Career', 'School, work, side gigs'),
        const SizedBox(height: 14.4),
        if (c.age < 4)
          _unlockCard(
            icon: Icons.school,
            title: 'School Starts Soon',
            message:
                'For now, your life is family, health, and early childhood events. School begins around age 4.',
          )
        else
          _flowNavCard(
            icon: Icons.school,
            emoji: '📚',
            label: c.isEnrolled ? c.enrolledIn : 'Education',
            subtitle: c.isEnrolled
                ? '${c.yearsLeftInSchool} year${c.yearsLeftInSchool == 1 ? '' : 's'} left'
                : 'Study paths and graduation',
            color: const Color(0xFFEDE7F6),
            borderColor: const Color(0xFFB39DDB),
            onTap: () => _openScreen(
              SchoolScreen(
                character: c,
                onCharacterUpdated: () => setState(() {}),
              ),
            ),
          ),
        const SizedBox(height: 10.8),
        if (c.age < 13)
          _unlockCard(
            icon: Icons.work,
            title: 'Jobs Unlock Later',
            message:
                'Jobs and side gigs unlock when you become a teenager or young adult. Keep building smarts and discipline.',
          )
        else
          _flowNavCard(
            icon: Icons.work,
            emoji: '💼',
            label: c.careerPath == 'None' ? 'Jobs & Side Gigs' : c.careerPath,
            subtitle: c.careerPath == 'None'
                ? 'Find work or start a hustle'
                : 'GHS ${_fmt(c.monthlyIncome + c.sideGigIncome)} / month',
            color: const Color(0xFFE0F2F1),
            borderColor: const Color(0xFFB2DFDB),
            onTap: () => _openScreen(
              JobScreen(
                character: c,
                onCharacterUpdated: () => setState(() {}),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRelationshipsHub(Character c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hubTitle('Relationships', 'Family, romance, children'),
        const SizedBox(height: 14.4),
        _familySummaryCard(c),
        const SizedBox(height: 10.8),
        if (c.age < 13)
          _unlockCard(
            icon: Icons.favorite,
            title: 'Romance Unlocks When You Are Older',
            message:
                'Childhood relationships are about family, siblings, classmates, and learning how people work.',
          )
        else
          _flowNavCard(
            icon: Icons.favorite,
            emoji: '💕',
            label: c.relationshipStatus == 'Single'
                ? 'Romance'
                : c.relationshipStatus,
            subtitle: c.relationshipStatus == 'Single'
                ? 'Meet someone when life is ready'
                : _relationshipLabel(c),
            color: const Color(0xFFFFF3F6),
            borderColor: const Color(0xFFF8BBD0),
            onTap: () => _openScreen(
              SocialScreen(
                character: c,
                onCharacterUpdated: () => setState(() {}),
              ),
            ),
          ),
        if (c.numberOfChildren > 0) ...[
          const SizedBox(height: 10.8),
          _unlockCard(
            icon: Icons.child_care,
            title:
                '${c.numberOfChildren} Child${c.numberOfChildren == 1 ? '' : 'ren'}',
            message:
                'Children are tracked in your family life and influence expenses, happiness, and legacy.',
          ),
        ],
      ],
    );
  }

  Widget _buildAssetsHub(Character c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hubTitle('Assets', 'Housing and businesses'),
        const SizedBox(height: 14.4),
        if (c.age < 18 && c.housingStatus == 'With Parents')
          _unlockCard(
            icon: Icons.home,
            title: 'Housing Unlocks In Adulthood',
            message:
                'For now, you live with family. Focus on school, choices, and growing your stats.',
          )
        else
          _flowNavCard(
            icon: Icons.home,
            emoji: '🏠',
            label: 'Housing',
            subtitle: c.housingStatus,
            color: const Color(0xFFEDE7F6),
            borderColor: const Color(0xFFB39DDB),
            onTap: () => _openScreen(
              HousingScreen(
                character: c,
                onCharacterUpdated: () => setState(() {}),
              ),
            ),
          ),
        const SizedBox(height: 10.8),
        if (c.age < 18 && c.businessNames.isEmpty)
          _unlockCard(
            icon: Icons.storefront,
            title: 'Businesses Unlock In Adulthood',
            message:
                'Businesses need adult money and responsibility. You will get there.',
          )
        else
          _flowNavCard(
            icon: Icons.storefront,
            emoji: '🏪',
            label: 'Businesses',
            subtitle: c.businessNames.isEmpty
                ? 'Start your first business'
                : '${c.businessNames.length} running',
            color: const Color(0xFFE0F2F1),
            borderColor: const Color(0xFFB2DFDB),
            onTap: () => _openScreen(
              BusinessScreen(
                character: c,
                onCharacterUpdated: () => setState(() {}),
              ),
            ),
          ),
      ],
    );
  }

  Widget _hubTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w900,
            color: Color(0xFF424242),
          ),
        ),
        const SizedBox(height: 3.6),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12.6,
            fontWeight: FontWeight.w700,
            color: Color(0xFF757575),
          ),
        ),
      ],
    );
  }

  Widget _familySummaryCard(Character c) {
    c.ensureFamilySeeded();
    final aliveFamily = <String>[];
    for (var i = 0; i < c.familyNames.length; i++) {
      final alive = i >= c.familyAlive.length || c.familyAlive[i];
      if (!alive) continue;
      final relation = i < c.familyRelations.length
          ? c.familyRelations[i]
          : 'Family';
      final name = c.familyNames[i];
      aliveFamily.add('$relation: $name');
    }

    return _unlockCard(
      icon: Icons.family_restroom,
      title: 'Family',
      message: aliveFamily.isEmpty
          ? 'Your family story is still unfolding.'
          : '${aliveFamily.take(3).join(' • ')}\nBond: ${c.averageFamilyBond.round()}/100',
    );
  }

  Widget _unlockCard({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.2),
        border: Border.all(color: const Color(0x1AB39DDB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 39.6,
            height: 39.6,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF7E57C2), size: 20),
          ),
          const SizedBox(width: 12.6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF424242),
                  ),
                ),
                const SizedBox(height: 3.6),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 11.7,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _flowNavCard({
    required IconData icon,
    required String emoji,
    required String label,
    required String subtitle,
    required Color color,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12.6, vertical: 12.6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: borderColor.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 19.8)),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11.7,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF424242),
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9.9,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
            Icon(icon, color: borderColor, size: 16.2),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFFBDBDBD),
              size: 16.2,
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(int n) => n.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );

  void _openScreen(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.only(
        top: 18,
        bottom: 28.8,
        left: 14.4,
        right: 14.4,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(21.6)),
        border: const Border(top: BorderSide(color: Color(0x1AB39DDB))),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(child: _buildNavItem(Icons.home, 'Home', 0)),
              Expanded(child: _buildNavItem(Icons.work, 'Career', 1)),
              Expanded(
                child: GestureDetector(
                  onTap: _ageUp,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 43.2,
                        height: 43.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFB2DFDB), Color(0xFF90CAF9)],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFFB2DFDB,
                              ).withValues(alpha: 0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25.2,
                        ),
                      ),
                      const SizedBox(height: 5.4),
                      const Text(
                        'AGE',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFB2DFDB),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: _buildNavItem(Icons.group, 'Relations', 2)),
              Expanded(
                child: _buildNavItem(Icons.account_balance, 'Assets', 3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int tabIndex) {
    final isActive = _selectedTab == tabIndex;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = tabIndex),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? const Color(0xFFB39DDB)
                  : const Color(0xFFBDBDBD),
              size: 25.2,
            ),
            const SizedBox(height: 5.4),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: isActive
                    ? const Color(0xFFB39DDB)
                    : const Color(0xFFBDBDBD),
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
