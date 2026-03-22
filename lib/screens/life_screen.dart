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

class _LifeScreenState extends State<LifeScreen> {
  LifeEvent? _currentEvent;
  final ScrollController _logScrollController = ScrollController();

  void _ageUp() {
    setState(() {
      widget.character.age++;

      if (widget.character.age > 50) {
        widget.character.adjustStat('health', -2);
      }

      final validEvents = allEvents.where((e) {
        return widget.character.age >= e.minAge &&
            widget.character.age <= e.maxAge;
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      body: Stack(
        children: [
          // Main Body
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      _buildStatsCard(c),
                      const SizedBox(height: 16),
                      _buildFundsCard(c),
                      const SizedBox(height: 16),
                      // Recent Journey Title
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
                      Expanded(
                        child: _buildLogList(c),
                      ),
                      const SizedBox(height: 100), // Space for bottom nav
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Custom Bottom Navigation
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomNav(),
          ),

          // Central FAB (Moved here so taps aren't clipped by the bottom nav bounds)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: GestureDetector(
                onTap: _ageUp,
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB2DFDB).withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFB2DFDB), Color(0xFF90CAF9)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add, color: Colors.white, size: 32),
                          Text(
                            'AGE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              height: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB39DDB), Color(0xFFF8BBD0)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      widget.character.gender == 'Male' ? '👦' : '👧',
                      style: const TextStyle(fontSize: 24),
                    ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9800).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFF9800).withOpacity(0.2)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.fast_forward, color: Color(0xFFFF9800), size: 16),
                      SizedBox(width: 4),
                      Text('SIM LIFE', style: TextStyle(color: Color(0xFFFF9800), fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0x0DB39DDB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0x1AB39DDB)),
                ),
                child: const Icon(Icons.settings, color: Color(0xFFB39DDB), size: 20),
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
              _buildStatBar('Happiness', Icons.sentiment_satisfied, c.happiness, const Color(0xFFFFF9C4)),
              _buildStatBar('Health', Icons.favorite, c.health, const Color(0xFFF8BBD0)),
              _buildStatBar('Smarts', Icons.psychology, c.smarts, const Color(0xFFB2DFDB)),
              _buildStatBar('Looks', Icons.face, c.looks, Colors.white),
              _buildStatBar('Reputation', Icons.star, c.reputation, const Color(0xFF7C4DFF)),
              _buildStatBar('Connect', Icons.hub, c.connections, const Color(0xFF009688)),
              _buildStatBar('Streets', Icons.directions_run, c.streetSense, const Color(0xFFFF9800)),
              _buildStatBar('Discipline', Icons.timer, c.discipline, const Color(0xFF3F51B5)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, IconData icon, int value, Color color) {
    return Column(
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
      controller: _logScrollController,
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
                        color: index == 0 ? const Color(0xFFB39DDB) : const Color(0xFFF0F0F7),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: index == 0
                            ? [BoxShadow(color: const Color(0xFFB39DDB).withOpacity(0.4), blurRadius: 8)]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          ageStr,
                          style: TextStyle(
                            color: index == 0 ? Colors.white : const Color(0xFF9E9E9E),
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
                          const Icon(Icons.schedule, size: 16, color: Color(0xFFE0E0E0)),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.group, 'Social'),
              _buildNavItem(Icons.work, 'Job'),
              const SizedBox(width: 60), // Space for center FAB
              _buildNavItem(Icons.school, 'School'),
              _buildDoingItem(),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFFBDBDBD), size: 28),
        const SizedBox(height: 6),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: Color(0xFFBDBDBD),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildDoingItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFB39DDB), Color(0xFFD1C4E9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.explore, color: Colors.white, size: 20),
          SizedBox(height: 2),
          Text(
            'DOING',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
