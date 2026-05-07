import 'package:flutter/material.dart';

import '../services/life_goal_service.dart';
import '../services/meta_progress_service.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF424242),
        title: const Text(
          'Legacy Progress',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0x1AB39DDB)),
        ),
      ),
      body: FutureBuilder<MetaProgressSnapshot>(
        future: MetaProgressService.loadSnapshot(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final progress = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 36),
            children: [
              _summaryCard(progress),
              const SizedBox(height: 14.4),
              _ribbonsCard(progress),
              const SizedBox(height: 14.4),
              _achievementsCard(progress),
              const SizedBox(height: 14.4),
              _goalsCard(progress),
            ],
          );
        },
      ),
    );
  }

  Widget _summaryCard(MetaProgressSnapshot progress) {
    return _card(
      child: Row(
        children: [
          _metric(
            'Lives',
            '${progress.livesCompleted}',
            const Color(0xFF7E57C2),
          ),
          _metric(
            'Ribbons',
            '${progress.unlockedRibbons.length}',
            const Color(0xFFFFB300),
          ),
          _metric(
            'Badges',
            '${progress.unlockedAchievements.length}',
            const Color(0xFF009688),
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 25.2,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3.6),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF9E9E9E),
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ribbonsCard(MetaProgressSnapshot progress) {
    final ribbons = progress.unlockedRibbons.toList()..sort();
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Unlocked Ribbons'),
          const SizedBox(height: 12.6),
          if (ribbons.isEmpty)
            _emptyText('Finish a life to unlock your first ribbon.')
          else
            Wrap(
              spacing: 7.2,
              runSpacing: 7.2,
              children: ribbons.map(_ribbonChip).toList(),
            ),
        ],
      ),
    );
  }

  Widget _achievementsCard(MetaProgressSnapshot progress) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Achievements'),
          const SizedBox(height: 12.6),
          ...MetaProgressService.achievements.map((achievement) {
            final unlocked = progress.unlockedAchievements.contains(
              achievement.id,
            );
            return _achievementRow(
              title: achievement.title,
              description: achievement.description,
              unlocked: unlocked,
            );
          }),
        ],
      ),
    );
  }

  Widget _goalsCard(MetaProgressSnapshot progress) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Completed Life Goals'),
          const SizedBox(height: 12.6),
          ...LifeGoalService.goals.map((goal) {
            final completed = progress.completedLifeGoals.contains(goal.id);
            return _achievementRow(
              title: goal.title,
              description: goal.description,
              unlocked: completed,
            );
          }),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
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
      child: child,
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w900,
        color: Color(0xFF9E9E9E),
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _emptyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 12.6,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _ribbonChip(String ribbon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.8, vertical: 6.3),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFFFD54F)),
      ),
      child: Text(
        ribbon,
        style: const TextStyle(
          color: Color(0xFF8D6E00),
          fontSize: 11.7,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _achievementRow({
    required String title,
    required String description,
    required bool unlocked,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.8),
      child: Row(
        children: [
          Container(
            width: 34.2,
            height: 34.2,
            decoration: BoxDecoration(
              color: unlocked
                  ? const Color(0xFFE0F2F1)
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10.8),
            ),
            child: Icon(
              unlocked ? Icons.emoji_events : Icons.lock_outline,
              color: unlocked
                  ? const Color(0xFF009688)
                  : const Color(0xFFBDBDBD),
              size: 18,
            ),
          ),
          const SizedBox(width: 10.8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: unlocked
                        ? const Color(0xFF424242)
                        : const Color(0xFF9E9E9E),
                    fontSize: 12.6,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2.7),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 10.8,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
