import 'package:flutter/material.dart';

import '../app/theme/app_theme.dart';
import '../models/character.dart';
import '../services/save_service.dart';
import 'achievements_screen.dart';
import 'character_creation_screen.dart';
import 'life_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final status = character.isEnrolled
        ? character.enrolledIn
        : character.careerPath == 'None'
        ? character.lifeStage
        : character.careerPath;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('🇬🇭', style: TextStyle(fontSize: 24)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'GHANA LIFE SIM',
                      style: TextStyle(
                        color: AppColors.cocoa,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Settings',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    ),
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'Continue ${character.name}’s Life',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 10),
              Text(
                'Age ${character.age} · $status',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.green),
              ),
              const SizedBox(height: 18),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SummaryRow(
                        icon: Icons.account_balance_wallet_outlined,
                        label: _ghs(character.cash),
                      ),
                      const Divider(height: 24),
                      _SummaryRow(
                        icon: Icons.history,
                        label: character.lifeLog.isEmpty
                            ? character.originSummary
                            : character.lifeLog.first.replaceFirst(
                                RegExp(r'^Age \d+:\s*'),
                                '',
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LifeScreen(character: character),
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Continue Life'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AchievementsScreen(),
                        ),
                      ),
                      icon: const Icon(Icons.emoji_events_outlined),
                      label: const Text('Legacy'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmNewLife(context),
                      icon: const Icon(Icons.autorenew),
                      label: const Text('New Life'),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                'Your choices become your story.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmNewLife(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Start a new life?'),
        content: Text(
          '${character.name}’s active life will be replaced. '
          'Cross-life achievements will remain.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep this life'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Start new life'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await SaveService.deleteSave();
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const CharacterCreationScreen()),
    );
  }

  static String _ghs(int value) {
    final formatted = value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    return 'GHS $formatted';
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.gold),
        const SizedBox(width: 12),
        Expanded(child: Text(label)),
      ],
    );
  }
}
