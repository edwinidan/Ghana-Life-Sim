import 'package:flutter/material.dart';
import 'dart:math';
import '../models/character.dart';
import 'character_creation_screen.dart';
import '../services/save_service.dart';

class DeathScreen extends StatelessWidget {
  final Character character;
  const DeathScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      body: Stack(
        children: [
          // Main scrollable content
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildLegacyCard(),
                      const SizedBox(height: 16),
                      _buildWealthGrid(),
                      const SizedBox(height: 16),
                      _buildLifeAchievements(context),
                      const SizedBox(height: 140), // Space for bottom actions
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom sticky actions
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomActions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0x33B39DDB))),
        boxShadow: [
          BoxShadow(
            color: Color(0x0DB39DDB),
            blurRadius: 20,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Center(
        child: Column(
          children: const [
            Text(
              'GHANA LIFE',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF424242),
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'LIVE INTENTIONALLY',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Color(0xFFB39DDB),
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegacyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF8E9EAB), Color(0xFFB39DDB), Color(0xFF90CAF9)],
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
        children: [
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Center(
              // Grayscale emoji effect
              child: Opacity(
                opacity: 0.8,
                child: Text(
                  character.gender == 'Male' ? '💀' : '💀',
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
          ),
          Text(
            character.name,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Text(
              'Final Stage: ${character.lifeStage}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Text(
                '${character.age}',
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'YEARS OF IMPACT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Colors.white70,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const Text(
              '"Passed away peacefully in their sleep."',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontStyle: FontStyle.italic,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWealthGrid() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0x0DB39DDB)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFB39DDB).withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'TOTAL WEALTH',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF9E9E9E),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${character.money}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0x0DB39DDB)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFB39DDB).withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'NETWORK',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF9E9E9E),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.hub, color: Color(0xFF009688), size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '${character.connections}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF424242),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLifeAchievements(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x0DB39DDB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LIFE ACHIEVEMENTS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: Color(0xFF9E9E9E),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3.2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 16,
            children: [
              _buildStatBar('Happiness', Icons.sentiment_satisfied, character.happiness, const Color(0xFFFFF9C4), context),
              _buildStatBar('Health', Icons.favorite, character.health, const Color(0xFFF8BBD0), context),
              _buildStatBar('Smarts', Icons.psychology, character.smarts, const Color(0xFFB2DFDB), context),
              _buildStatBar('Looks', Icons.face, character.looks, const Color(0xFFE0E0E0), context),
              _buildStatBar('Reputation', Icons.star, character.reputation, const Color(0xFF7C4DFF), context),
              _buildStatBar('Connect', Icons.hub, character.connections, const Color(0xFF009688), context),
              _buildStatBar('Streets', Icons.directions_run, character.streetSense, const Color(0xFFFF9800), context),
              _buildStatBar('Discipline', Icons.timer, character.discipline, const Color(0xFF3F51B5), context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, IconData icon, int value, Color color, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: color == const Color(0xFFE0E0E0) ? Colors.grey : color),
                const SizedBox(width: 4),
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            Text(
              '$value%',
              style: const TextStyle(
                color: Color(0xFF757575),
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
              )
            ],
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: (value / 100) * (MediaQuery.of(context).size.width / 2.8), // approximate width mapping
              height: 8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 40, left: 32, right: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(0.95),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.4, 1.0],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              await SaveService.deleteSave();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const CharacterCreationScreen()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF34D399), Color(0xFF14B8A6)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF34D399).withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Container(
                constraints: const BoxConstraints(minHeight: 60, minWidth: double.infinity),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.restart_alt, color: Colors.white, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'START NEW LIFE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.leaderboard, size: 16, color: Color(0xFF9E9E9E)),
              SizedBox(width: 8),
              Text(
                'VIEW GLOBAL LEADERBOARD',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF9E9E9E),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
