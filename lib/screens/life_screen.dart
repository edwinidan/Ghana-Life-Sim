import 'package:flutter/material.dart';
import 'dart:math';
import '../models/character.dart';
import '../models/event.dart';
import '../data/events.dart';
import 'death_screen.dart';

class LifeScreen extends StatefulWidget {
  final Character character;
  const LifeScreen({super.key, required this.character});

  @override
  State<LifeScreen> createState() => _LifeScreenState();
}

class _LifeScreenState extends State<LifeScreen> with TickerProviderStateMixin {
  LifeEvent? _currentEvent;
  String? _outcomeMessage;
  bool _showingOutcome = false;
  late AnimationController _pulseController;
  late AnimationController _cardController;
  late Animation<double> _cardAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _cardAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  void _ageUp() {
    setState(() {
      widget.character.age++;
      _outcomeMessage = null;
      _showingOutcome = false;

      if (widget.character.age > 50) {
        widget.character.adjustStat('health', -2);
      }

      final validEvents = allEvents.where((e) {
        return widget.character.age >= e.minAge &&
            widget.character.age <= e.maxAge;
      }).toList();

      if (validEvents.isNotEmpty) {
        _currentEvent = validEvents[Random().nextInt(validEvents.length)];
        _cardController.forward(from: 0);
      } else {
        _currentEvent = null;
      }

      if (widget.character.isDead) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => DeathScreen(character: widget.character),
            ),
          );
        });
      }
    });
  }

  void _makeChoice(EventChoice choice) {
    setState(() {
      choice.statChanges.forEach((stat, amount) {
        widget.character.adjustStat(stat, amount);
      });
      widget.character.lifeLog.add(
        'Age ${widget.character.age}: ${_currentEvent!.title} — ${choice.outcome}',
      );
      _outcomeMessage = choice.outcome;
      _showingOutcome = true;
      _currentEvent = null;

      if (widget.character.isDead) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => DeathScreen(character: widget.character),
            ),
          );
        });
      }
    });
  }

  Color _stageColor() {
    switch (widget.character.lifeStage) {
      case 'Toddler':
        return const Color(0xFFFF9800);
      case 'Child':
        return const Color(0xFF4CAF50);
      case 'Teenager':
        return const Color(0xFF2196F3);
      case 'Young Adult':
        return const Color(0xFF9C27B0);
      case 'Adult':
        return const Color(0xFFFFD700);
      case 'Middle Aged':
        return const Color(0xFFFF5722);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.character;
    final stageColor = _stageColor();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: SafeArea(
        child: Column(
          children: [
            // Top header bar
            _buildHeader(c, stageColor),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildAgeProgressBar(c, stageColor),
                    const SizedBox(height: 16),
                    _buildStatsGrid(c),
                    const SizedBox(height: 20),
                    if (_currentEvent != null)
                      ScaleTransition(
                        scale: _cardAnimation,
                        child: _buildEventCard(_currentEvent!),
                      ),
                    if (_showingOutcome && _outcomeMessage != null)
                      _buildOutcomeCard(_outcomeMessage!),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom action button
            _buildBottomButton(c),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Character c, Color stageColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF12122A),
        border: Border(
          bottom: BorderSide(color: stageColor.withOpacity(0.3), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Avatar circle
          AnimatedBuilder(
            animation: _pulseController,
            builder: (_, __) => Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: stageColor.withOpacity(0.15),
                border: Border.all(
                  color: stageColor.withOpacity(
                    0.4 + 0.3 * _pulseController.value,
                  ),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  c.gender == 'Male' ? '👦' : '👧',
                  style: TextStyle(fontSize: 22 + 2 * _pulseController.value),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name and stage
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: stageColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        c.lifeStage,
                        style: TextStyle(
                          color: stageColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      c.gender,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Health badge
          Column(
            children: [
              Text('❤️', style: const TextStyle(fontSize: 18)),
              Text(
                '${c.health}',
                style: TextStyle(
                  color: c.health > 50
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFE53935),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgeProgressBar(Character c, Color stageColor) {
    // Life progress 0 to 90
    final progress = c.age / 90;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12122A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Age ${c.age}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}% of life lived',
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(stageColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _stageLabel('Child', 0, stageColor, c.age),
              _stageLabel('Teen', 13, stageColor, c.age),
              _stageLabel('Adult', 18, stageColor, c.age),
              _stageLabel('Mid', 30, stageColor, c.age),
              _stageLabel('Senior', 60, stageColor, c.age),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stageLabel(
    String label,
    int fromAge,
    Color stageColor,
    int currentAge,
  ) {
    final active = currentAge >= fromAge;
    return Text(
      label,
      style: TextStyle(
        color: active ? stageColor : Colors.white24,
        fontSize: 10,
        fontWeight: active ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildStatsGrid(Character c) {
    final stats = [
      ('😊', 'Happiness', c.happiness),
      ('🧠', 'Smarts', c.smarts),
      ('✨', 'Looks', c.looks),
      ('💰', 'Money', c.money),
      ('⭐', 'Reputation', c.reputation),
      ('💪', 'Discipline', c.discipline),
      ('🌍', 'Street', c.streetSense),
      ('🤝', 'Connect', c.connections),
    ];

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.95,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: stats.map((s) => _statCard(s.$1, s.$2, s.$3)).toList(),
    );
  }

  Widget _statCard(String emoji, String label, int value) {
    final Color barColor = value > 65
        ? const Color(0xFF4CAF50)
        : value > 35
        ? const Color(0xFFFFD700)
        : const Color(0xFFE53935);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF12122A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: barColor.withOpacity(0.2), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(color: Colors.white38, fontSize: 9),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '$value',
            style: TextStyle(
              color: barColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(LifeEvent event) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1A1A3E), const Color(0xFF0D0D2B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFD700).withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700).withOpacity(0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Age ${widget.character.age}',
                    style: const TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Text(
              event.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),

          // Divider
          Divider(color: Colors.white10, height: 1),

          // Choices
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: event.choices.asMap().entries.map((entry) {
                final i = entry.key;
                final choice = entry.value;
                final colors = [
                  const Color(0xFF2196F3),
                  const Color(0xFF4CAF50),
                  const Color(0xFFFF9800),
                ];
                final color = colors[i % colors.length];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => _makeChoice(choice),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: color.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              choice.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: color.withOpacity(0.5),
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutcomeCard(String outcome) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4CAF50).withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📋', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              outcome,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(Character c) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: Color(0xFF12122A),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: _currentEvent == null
          ? SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _ageUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                  shadowColor: const Color(0xFFFFD700).withOpacity(0.4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _showingOutcome ? 'Continue Life' : 'Age Up',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
