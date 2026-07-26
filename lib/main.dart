import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/theme/app_theme.dart';
import 'screens/character_creation_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'services/save_service.dart';
import 'services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SettingsService.init();
  await SaveService.init();
  runApp(const ProviderScope(child: GhanaLifeSimApp()));
}

class GhanaLifeSimApp extends StatelessWidget {
  const GhanaLifeSimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghana Life Sim',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      themeMode: ThemeMode.light,
      home: const AppEntry(),
    );
  }
}

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  Widget? _destination;

  @override
  void initState() {
    super.initState();
    _determineRoute();
  }

  Future<void> _determineRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
    if (!onboardingSeen) {
      if (mounted) setState(() => _destination = const OnboardingScreen());
      return;
    }

    if (SaveService.hasSavedGame()) {
      final character = await SaveService.loadGame();
      if (character != null && !character.isDead) {
        if (mounted) {
          setState(() => _destination = HomeScreen(character: character));
        }
        return;
      }
    }
    if (mounted) {
      setState(() {
        _destination = const CharacterCreationScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_destination == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFFAF9FE),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return _destination!;
  }
}
