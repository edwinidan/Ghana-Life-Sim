import 'package:flutter/material.dart';
import 'screens/character_creation_screen.dart';

void main() {
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
      home: const CharacterCreationScreen(),
    );
  }
}
