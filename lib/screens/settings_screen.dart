import 'package:flutter/material.dart';

import '../app/theme/app_theme.dart';
import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final bool _sounds = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Haptic feedback'),
            subtitle: const Text('Feedback for ageing and major choices'),
            value: SettingsService.hapticsEnabled.value,
            onChanged: (value) async {
              await SettingsService.setHapticsEnabled(value);
              if (mounted) setState(() {});
            },
          ),
          SwitchListTile(
            title: const Text('Sound'),
            subtitle: const Text('Sound pack is not included in this beta'),
            value: _sounds,
            onChanged: null,
          ),
          SwitchListTile(
            title: const Text('Reduce motion'),
            value: SettingsService.reducedMotion.value,
            onChanged: (value) async {
              await SettingsService.setReducedMotion(value);
              if (mounted) setState(() {});
            },
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.lock_outline, color: AppColors.green),
            title: Text('Privacy'),
            subtitle: Text(
              'Offline play. No account, ads, analytics, or personal-data upload.',
            ),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Version'),
            subtitle: Text('1.0.0 (2)'),
          ),
        ],
      ),
    );
  }
}
