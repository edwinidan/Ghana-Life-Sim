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
import 'life_log_screen.dart';

class LifeScreen extends StatefulWidget {
  final Character character;
  const LifeScreen({super.key, required this.character});

  @override
  State<LifeScreen> createState() => _LifeScreenState();
}

class _LifeScreenState extends State<LifeScreen> {
  LifeEvent? _currentEvent;
  int _selectedTab = 4; // 0=life, 1=job, 2=age(unused), 3=school, 4=doing
  String _previousLifeStage = '';

  static const Map<String, String> _statDescriptions = {
    'health':      'Your physical wellbeing. Reaches 0 and it\'s over. Protect it. 💪',
    'happiness':   'How content you are. Affects relationships and life rating. 😊',
    'smarts':      'Your intelligence. Needed for education and tech careers. 🧠',
    'looks':       'Your appearance. Affects romance and entertainment careers. ✨',
    'money':       'Your financial power. Needed for housing, business, and marriage. 💰',
    'reputation':  'How Ghana sees you. Affects connections and opportunities. 🌟',
    'discipline':  'Your work ethic. Needed for promotions and civil service. 📋',
    'streetSense': 'Your hustle instinct. Needed for trade and survival. 🛣️',
    'connections': 'Your network. Opens doors money alone cannot. 🤝',
  };

  @override
  void initState() {
    super.initState();
    _previousLifeStage = widget.character.lifeStage;
  }

  Color _lifeStageColor(String stage) {
    switch (stage) {
      case 'Toddler':     return const Color(0xFFF8BBD0);
      case 'Child':       return const Color(0xFFB2DFDB);
      case 'Teenager':    return const Color(0xFFB39DDB);
      case 'Young Adult': return const Color(0xFF90CAF9);
      case 'Adult':       return const Color(0xFFA5D6A7);
      case 'Middle Aged': return const Color(0xFFFFCC80);
      case 'Senior':      return const Color(0xFFCFD8DC);
      default:            return const Color(0xFFB39DDB);
    }
  }

  String _avatarEmoji(String gender, String lifeStage) {
    if (gender == 'Male') {
      switch (lifeStage) {
        case 'Toddler':     return '👶';
        case 'Child':       return '🧒';
        case 'Teenager':    return '👦';
        case 'Young Adult': return '🧑';
        case 'Adult':       return '👨';
        case 'Middle Aged': return '👨‍🦳';
        case 'Senior':      return '👴';
        default:            return '🧑';
      }
    } else {
      switch (lifeStage) {
        case 'Toddler':     return '👶';
        case 'Child':       return '🧒';
        case 'Teenager':    return '👧';
        case 'Young Adult': return '🧑';
        case 'Adult':       return '👩';
        case 'Middle Aged': return '👩‍🦳';
        case 'Senior':      return '👵';
        default:            return '🧑';
      }
    }
  }

  void _ageUp() {
    setState(() {
      widget.character.age++;
      SaveService.saveGame(widget.character);

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
      final healthRng = Random();
      if (widget.character.age >= 80 && healthRng.nextDouble() < 0.20) {
        widget.character.adjustStat('health', -12);
        widget.character.lifeLog.add('Age ${widget.character.age}: Your body reminded you that 80 is not a joke. 😔');
      } else if (widget.character.age >= 65 && healthRng.nextDouble() < 0.10) {
        widget.character.adjustStat('health', -8);
        widget.character.lifeLog.add('Age ${widget.character.age}: A health scare hit you hard this year. 😟');
      } else if (widget.character.age >= 50 && healthRng.nextDouble() < 0.05) {
        widget.character.adjustStat('health', -5);
        widget.character.lifeLog.add('Age ${widget.character.age}: Your body is sending you warning signals. 😬');
      }

      // School: progress if enrolled
      if (widget.character.isEnrolled) {
        SchoolService.progressSchool(widget.character);
      }

      // Career: promotion check + income
      if (CareerService.checkPromotion(widget.character)) {
        CareerService.applyPromotion(widget.character);
      }
      if (widget.character.monthlyIncome > 0) {
        int incomeGain = (widget.character.monthlyIncome / 1000).floor().clamp(
          1,
          15,
        );
        widget.character.adjustStat('money', incomeGain);
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

      // Business progression
      BusinessService.progressBusinesses(widget.character);

      final validEvents = allEvents.where((e) {
        final ageOk =
            widget.character.age >= e.minAge &&
            widget.character.age <= e.maxAge;
        final careerOk =
            e.requiredCareer == null ||
            e.requiredCareer == widget.character.careerPath;
        final relationshipOk =
            e.requiredRelationshipStatus == null ||
            e.requiredRelationshipStatus == widget.character.relationshipStatus;
        final housingOk =
            e.requiredHousingStatus == null ||
            e.requiredHousingStatus == widget.character.housingStatus;
        final businessOk =
            e.requiresBusiness == null ||
            e.requiresBusiness == widget.character.businessNames.isNotEmpty;
        return ageOk && careerOk && relationshipOk && housingOk && businessOk;
      }).toList();

      if (validEvents.isNotEmpty) {
        _currentEvent = validEvents[Random().nextInt(validEvents.length)];
        // Show event dialog
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showEventDialog(_currentEvent!);
        });
      }

      if (widget.character.isDead) {
        _navToDeath();
      }
    });
  }

  void _makeChoice(EventChoice choice) {
    Navigator.of(context, rootNavigator: true).pop(); // close dialog
    setState(() {
      choice.statChanges.forEach((stat, amount) {
        widget.character.adjustStat(stat, amount);
      });
      if (choice.illnessToAdd != null) {
        if (!widget.character.activeIllnesses.contains(choice.illnessToAdd!)) {
          widget.character.activeIllnesses.add(choice.illnessToAdd!);
        }
      }
      // push to log
      widget.character.lifeLog.insert(
        0,
        'Age ${widget.character.age}: ${_currentEvent!.title} — ${choice.outcome}',
      );
      _currentEvent = null;

      if (widget.character.isDead) {
        _navToDeath();
      }
    });
  }

  void _simLife() {
    setState(() {
      widget.character.age = 90;
      widget.character.money += 450230;
      widget.character.connections += 7;

      if (widget.character.lifeLog.isEmpty) {
        widget.character.lifeLog.addAll([
          'Age 80: Peacefully retired — Enjoying the golden years.',
          'Age 65: Promoted to Senior Director — Received a huge bonus!',
          'Age 28: Got Married — To your high-school sweetheart.',
          'Age 18: Graduated High School — With honors.',
        ]);
      }
    });
    _navToDeath();
  }

  void _navToDeath() {
    if (widget.character.causeOfDeath.isEmpty) {
      widget.character.causeOfDeath = HealthService.determineCauseOfDeath(widget.character);
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
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB39DDB).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Age ${widget.character.age}',
                        style: const TextStyle(
                          color: Color(0xFF5E35B1),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF424242),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  event.description,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF757575),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                ...event.choices.map((choice) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => _makeChoice(choice),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F7FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                        ),
                        child: Text(
                          choice.text,
                          style: const TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
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

    Widget tabBody;
    if (_selectedTab == 0) {
      tabBody = SocialScreen(
        character: c,
        onCharacterUpdated: () => setState(() {}),
      );
    } else if (_selectedTab == 1) {
      tabBody = JobScreen(
        character: c,
        onCharacterUpdated: () => setState(() {}),
      );
    } else if (_selectedTab == 3) {
      tabBody = SchoolScreen(
        character: c,
        onCharacterUpdated: () => setState(() {}),
      );
    } else {
      tabBody = Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildStatsCard(c),
                  const SizedBox(height: 16),
                  _buildFundsCard(c),
                  const SizedBox(height: 16),
                  _buildDoingNavButtons(c),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Icon(Icons.history, color: Color(0x99B39DDB), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Recent Journey',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF757575),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildLogList(c),
                ],
              ),
            ),
          ),
        ],
      );
    }

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

  String _housingBusinessLabel(Character c) {
    final housingEmoji = c.housingStatus == 'Homeowner'
        ? '🏡'
        : c.housingStatus == 'Renting'
            ? '🏠'
            : '🏘️';
    String label = '$housingEmoji ${c.housingStatus}';
    if (c.businessNames.isNotEmpty) {
      label += ' • ${c.businessNames.length} business${c.businessNames.length > 1 ? 'es' : ''}';
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
      'Toddler':     '👶',
      'Child':       '🧒',
      'Teenager':    '🧑',
      'Young Adult': '🧑‍🎓',
      'Adult':       '👨',
      'Middle Aged': '👨‍🦳',
      'Senior':      '👴',
    };
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(stageEmojis[stageName] ?? '🧑', style: const TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                'NEW LIFE STAGE',
                style: TextStyle(fontSize: 11, color: Colors.grey[500], letterSpacing: 2, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                stageName,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: _lifeStageColor(stageName)),
              ),
              const SizedBox(height: 8),
              Text(
                _getStageDescription(stageName),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _lifeStageColor(stageName),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                  ),
                  child: const Text("Let's Go", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
      case 'Child':       return 'School, chores, and discovering the world. 🌍';
      case 'Teenager':    return 'Exams, crushes, and questionable decisions. 😅';
      case 'Young Adult': return 'University, first jobs, and figuring life out. 🎓';
      case 'Adult':       return 'Career, relationships, and real responsibilities. 💼';
      case 'Middle Aged': return 'You\'ve seen things. Now you manage things. 🧠';
      case 'Senior':      return 'Legacy time. What will they say about you? 🕊️';
      default:            return 'A new chapter begins. 📖';
    }
  }

  void _showStatTooltip(String statKey, String label, IconData icon, int value, Color color) {
    final description = _statDescriptions[statKey] ?? '';
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 32,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Icon(icon, size: 48, color: color == Colors.white ? Colors.grey[400] : color),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF424242)),
            ),
            const SizedBox(height: 16),
            // Progress bar
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: value / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color == Colors.white ? const Color(0xFFB39DDB) : color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$value / 100',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 24, right: 24, bottom: 16),
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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _lifeStageColor(widget.character.lifeStage),
                    width: 3,
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    _avatarEmoji(widget.character.gender, widget.character.lifeStage),
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'GHANA LIFE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF424242),
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'LIVE INTENTIONALLY',
                    style: TextStyle(
                      fontSize: 9,
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
                onTap: _simLife,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9800).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFF9800).withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.fast_forward,
                        color: Color(0xFFFF9800),
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'SIM LIFE',
                        style: TextStyle(
                          color: Color(0xFFFF9800),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0x0DB39DDB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0x1AB39DDB)),
                  ),
                  child: const Center(
                    child: Text('📖', style: TextStyle(fontSize: 18)),
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFFB39DDB), Color(0xFFD1C4E9), Color(0xFF90CAF9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withOpacity(0.3),
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
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFB2DFDB),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Color(0xFFB2DFDB), blurRadius: 8),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        c.lifeStage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if (c.relationshipStatus != 'Single') ...[
                    const SizedBox(height: 4),
                    Text(
                      _relationshipLabel(c),
                      style: TextStyle(
                        color: Colors.white.withAlpha(204),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    _housingBusinessLabel(c),
                    style: TextStyle(
                      color: Colors.white.withAlpha(179),
                      fontSize: 12,
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
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  const Text(
                    'YEARS OLD',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: Colors.white70,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3.5,
            crossAxisSpacing: 24,
            mainAxisSpacing: 14,
            children: [
              _buildStatBar('Happiness', Icons.sentiment_satisfied, c.happiness, const Color(0xFFFFF9C4),
                statKey: 'happiness', onTap: () => _showStatTooltip('happiness', 'Happiness', Icons.sentiment_satisfied, c.happiness, const Color(0xFFFFF9C4))),
              _buildStatBar('Health', Icons.favorite, c.health, const Color(0xFFF8BBD0),
                statKey: 'health', onTap: () => _showStatTooltip('health', 'Health', Icons.favorite, c.health, const Color(0xFFF8BBD0))),
              _buildStatBar('Smarts', Icons.psychology, c.smarts, const Color(0xFFB2DFDB),
                statKey: 'smarts', onTap: () => _showStatTooltip('smarts', 'Smarts', Icons.psychology, c.smarts, const Color(0xFFB2DFDB))),
              _buildStatBar('Looks', Icons.face, c.looks, Colors.white,
                statKey: 'looks', onTap: () => _showStatTooltip('looks', 'Looks', Icons.face, c.looks, Colors.white)),
              _buildStatBar('Reputation', Icons.star, c.reputation, const Color(0xFF7C4DFF),
                statKey: 'reputation', onTap: () => _showStatTooltip('reputation', 'Reputation', Icons.star, c.reputation, const Color(0xFF7C4DFF))),
              _buildStatBar('Connect', Icons.hub, c.connections, const Color(0xFF009688),
                statKey: 'connections', onTap: () => _showStatTooltip('connections', 'Connections', Icons.hub, c.connections, const Color(0xFF009688))),
              _buildStatBar('Streets', Icons.directions_run, c.streetSense, const Color(0xFFFF9800),
                statKey: 'streetSense', onTap: () => _showStatTooltip('streetSense', 'Street Sense', Icons.directions_run, c.streetSense, const Color(0xFFFF9800))),
              _buildStatBar('Discipline', Icons.timer, c.discipline, const Color(0xFF3F51B5),
                statKey: 'discipline', onTap: () => _showStatTooltip('discipline', 'Discipline', Icons.timer, c.discipline, const Color(0xFF3F51B5))),
            ],
          ),
          if (c.careerPath != 'None') ...[
            const SizedBox(height: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Text('💼', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
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
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    if (c.educationLevel != 'None') ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          c.educationLevel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (incomeText.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    incomeText,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                if (c.sideGigs.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    '+ ${c.sideGigs.length} side gig${c.sideGigs.length > 1 ? 's' : ''}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 11,
                    ),
                  ),
                ],
                if (totalText.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    totalText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
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

  Widget _buildStatBar(String label, IconData icon, int value, Color color, {String statKey = '', VoidCallback? onTap}) {
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
                Icon(icon, size: 14, color: color),
                const SizedBox(width: 6),
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
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
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: (value / 100) * (MediaQuery.of(context).size.width / 2.8),
              height: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildFundsCard(Character c) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x0DB39DDB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withOpacity(0.1),
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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFB2DFDB).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Color(0xFF009688),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AVAILABLE FUNDS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF9E9E9E),
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    '\$${c.money}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF424242),
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFB2DFDB).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(6),
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
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0x0DB39DDB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
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
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: index == 0
                            ? const Color(0xFFB39DDB)
                            : const Color(0xFFF0F0F7),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: index == 0
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFFB39DDB,
                                  ).withOpacity(0.4),
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
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    if (index < c.lifeLog.length - 1)
                      Container(
                        width: 2,
                        height: 30,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB39DDB).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
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
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF9E9E9E),
                              letterSpacing: 1.5,
                            ),
                          ),
                          const Icon(
                            Icons.schedule,
                            size: 16,
                            color: Color(0xFFE0E0E0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        outcome,
                        style: const TextStyle(
                          fontSize: 14,
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

  Widget _buildDoingNavButtons(Character c) {
    return Row(
      children: [
        Expanded(
          child: _doingNavCard(
            emoji: '🏠',
            label: 'Housing',
            subtitle: c.housingStatus,
            color: const Color(0xFFEDE7F6),
            borderColor: const Color(0xFFB39DDB),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HousingScreen(
                  character: c,
                  onCharacterUpdated: () => setState(() {}),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _doingNavCard(
            emoji: '💼',
            label: 'My Businesses',
            subtitle: c.businessNames.isEmpty
                ? 'None yet'
                : '${c.businessNames.length} running',
            color: const Color(0xFFE0F2F1),
            borderColor: const Color(0xFFB2DFDB),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BusinessScreen(
                  character: c,
                  onCharacterUpdated: () => setState(() {}),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _doingNavCard({
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF424242),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFBDBDBD), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 32, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: const Border(top: BorderSide(color: Color(0x1AB39DDB))),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withOpacity(0.1),
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
              Expanded(child: _buildNavItem(Icons.group, 'Social', 0)),
              Expanded(child: _buildNavItem(Icons.work, 'Job', 1)),
              Expanded(
                child: GestureDetector(
                  onTap: _ageUp,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFB2DFDB), Color(0xFF90CAF9)],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFB2DFDB).withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'AGE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFB2DFDB),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: _buildNavItem(Icons.school, 'School', 3)),
              Expanded(child: _buildNavItem(Icons.explore, 'Doing', 4)),
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? const Color(0xFFB39DDB)
                  : const Color(0xFFBDBDBD),
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
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
