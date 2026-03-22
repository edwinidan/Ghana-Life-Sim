import 'package:flutter/material.dart';
import 'screens/character_creation_screen.dart';
import 'screens/life_screen.dart';
import 'services/save_service.dart';
import 'models/character.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SaveService.init();
  runApp(const GhanaLifeSimApp());
}

class GhanaLifeSimApp extends StatelessWidget {
  const GhanaLifeSimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghana Life Sim',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD700),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Georgia',
      ),
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
    if (SaveService.hasSavedGame()) {
      final character = await SaveService.loadGame();
      if (character != null && !character.isDead) {
        if (mounted) {
          setState(() {
            _destination = LifeScreen(character: character);
          });
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
