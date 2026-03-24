import 'package:flutter/material.dart';
import '../models/character.dart';
import 'character_creation_screen.dart';
import '../services/save_service.dart';
import '../services/health_service.dart';

class DeathScreen extends StatelessWidget {
  final Character character;
  const DeathScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final int lifeScore = HealthService.calculateLifeScore(character);
    final String rating = HealthService.getLifeRating(lifeScore);
    final String subtitle = HealthService.getRatingSubtitle(rating);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14.4),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildDeathCard(),
                      const SizedBox(height: 14.4),
                      _buildLifeRatingCard(lifeScore, rating, subtitle, context),
                      const SizedBox(height: 14.4),
                      _buildStatsGrid(context),
                      const SizedBox(height: 14.4),
                      _buildLifeLog(),
                      const SizedBox(height: 126),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
      padding: const EdgeInsets.only(top: 54, bottom: 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0x33B39DDB))),
        boxShadow: [
          BoxShadow(color: Color(0x0DB39DDB), blurRadius: 20, offset: Offset(0, 4))
        ],
      ),
      child: Center(
        child: Column(
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
            SizedBox(height: 1.8),
            Text(
              'LIVE INTENTIONALLY',
              style: TextStyle(
                fontSize: 9,
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

  Widget _buildDeathCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21.6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.4),
        gradient: const LinearGradient(
          colors: [Color(0xFF8E9EAB), Color(0xFFB39DDB), Color(0xFF90CAF9)],
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
        children: [
          Container(
            width: 72,
            height: 72,
            margin: const EdgeInsets.only(bottom: 14.4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16.2),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: const Center(
              child: Text('💀', style: TextStyle(fontSize: 36)),
            ),
          ),
          Text(
            character.name,
            style: const TextStyle(
              fontSize: 28.8,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 7.2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.8, vertical: 3.6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16.2),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Text(
              'Final Stage: ${character.lifeStage}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.8,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 21.6),
          Text(
            '${character.age}',
            style: const TextStyle(
              fontSize: 50.4,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 3.6),
          const Text(
            'YEARS OF LIFE',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: Colors.white70,
              letterSpacing: 3,
            ),
          ),
          if (character.causeOfDeath.isNotEmpty) ...[
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14.4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Text(
                character.causeOfDeath,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.7,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLifeRatingCard(int score, String rating, String subtitle, BuildContext context) {
    final Color ratingColor;
    switch (rating) {
      case 'Legendary':
        ratingColor = const Color(0xFFFFD54F);
        break;
      case 'Solid Run':
        ratingColor = const Color(0xFF4DB6AC);
        break;
      case 'Average Life':
        ratingColor = const Color(0xFF9E9E9E);
        break;
      default: // Wasted Potential
        ratingColor = const Color(0xFFFF7043);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21.6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.2),
        border: Border.all(color: const Color(0x0DB39DDB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'LIFE RATING',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: Color(0xFF9E9E9E),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          // Score circle
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ratingColor.withValues(alpha: 0.12),
              border: Border.all(color: ratingColor, width: 2.7),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 32.4,
                      fontWeight: FontWeight.w900,
                      color: ratingColor,
                      height: 1.0,
                    ),
                  ),
                  Text(
                    '/ 100',
                    style: TextStyle(
                      fontSize: 9.9,
                      fontWeight: FontWeight.w700,
                      color: ratingColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14.4),
          Text(
            rating.toUpperCase(),
            style: TextStyle(
              fontSize: 19.8,
              fontWeight: FontWeight.w900,
              color: ratingColor,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 7.2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11.7,
              fontStyle: FontStyle.italic,
              color: Color(0xFF757575),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    final stats = [
      ('❤️', 'Health', character.health),
      ('😊', 'Happy', character.happiness),
      ('🧠', 'Smarts', character.smarts),
      ('✨', 'Looks', character.looks),
      ('💰', 'Money', character.money),
      ('⭐', 'Rep', character.reputation),
      ('💪', 'Discipline', character.discipline),
      ('🏃', 'Streets', character.streetSense),
      ('🤝', 'Connect', character.connections),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.2),
        border: Border.all(color: const Color(0x0DB39DDB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FINAL STATS',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: Color(0xFF9E9E9E),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 14.4),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
            children: stats.map((s) => _buildStatCell(s.$1, s.$2, s.$3)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCell(String emoji, String label, int value) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16.2)),
        const SizedBox(width: 5.4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 7.2,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF9E9E9E),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 14.4,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF424242),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLifeLog() {
    if (character.lifeLog.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.2),
        border: Border.all(color: const Color(0x0DB39DDB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB39DDB).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LIFE LOG',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: Color(0xFF9E9E9E),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10.8),
          ...character.lifeLog.take(20).map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(color: Color(0xFFB39DDB), fontSize: 10.8)),
                  Expanded(
                    child: Text(
                      entry,
                      style: const TextStyle(
                        fontSize: 10.8,
                        color: Color(0xFF616161),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 21.6, bottom: 36, left: 28.8, right: 28.8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.0),
            Colors.white.withValues(alpha: 0.95),
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
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
                padding: const EdgeInsets.symmetric(vertical: 16.2),
                backgroundColor: const Color(0xFF34D399),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restart_alt, size: 21.6),
                  SizedBox(width: 10.8),
                  Text(
                    'LIVE AGAIN',
                    style: TextStyle(
                      fontSize: 14.4,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
