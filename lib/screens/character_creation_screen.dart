import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/character.dart';
import 'life_screen.dart';

class CharacterCreationScreen extends StatefulWidget {
  const CharacterCreationScreen({super.key});

  @override
  State<CharacterCreationScreen> createState() => _CharacterCreationScreenState();
}

class _CharacterCreationScreenState extends State<CharacterCreationScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  String _selectedGender = 'Male';
  late AnimationController _animController;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _startGame() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Enter your name first', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }
    final character = Character(name: name, gender: _selectedGender);
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => LifeScreen(character: character),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FE),
      body: Stack(
        children: [
          // Animated Background Elements
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            left: -100,
            child: _buildBlurredCircle(const Color(0x330058BC)),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.20,
            right: -100,
            child: _buildBlurredCircle(const Color(0x338A2BB9)),
          ),

          SafeArea(
            child: FadeTransition(
              opacity: _fadeIn,
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Colors.blue.shade700!, Colors.blue.shade500!],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds),
                          child: const Text(
                            'GHANA LIFE',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE3E2E7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.help_outline, color: Color(0xFF414755)),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Title Block
                          const Text(
                            'Begin Your Story',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              height: 1.1,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1A1B1F),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Create your unique identity',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF414755),
                            ),
                          ),
                          const SizedBox(height: 40),

                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "What's your name?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF1A1B1F),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Name Input
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0x33C1C6D7)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: TextField(
                              controller: _nameController,
                              cursorColor: const Color(0xFF1A1B1F),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1A1B1F),
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Enter name...',
                                hintStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w400),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(20),
                                suffixIcon: Icon(Icons.edit, color: Color(0xFF0070EB)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Choose your essence",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF1A1B1F),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Gender Selection Grid
                          Row(
                            children: [
                              Expanded(
                                child: _buildGenderCard(
                                  'Male',
                                  Icons.person,
                                  Colors.blue.shade50!,
                                  Colors.blue.shade500!,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildGenderCard(
                                  'Female',
                                  Icons.person_3,
                                  Colors.purple.shade50!,
                                  Colors.purple.shade500!,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Attributes Preview
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F3F8),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF6D9FF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.psychology, color: Color(0xFF7201A2)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'INITIAL STATS',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                          color: Color(0xFF414755),
                                        ),
                                      ),
                                      Text(
                                        'Randomizing Traits...',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1A1B1F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.refresh, color: Color(0xFF0058BC)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: InkWell(
                onTap: _startGame,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade500!, Colors.teal.shade700!],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Begin Your Life',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.rocket_launch, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurredCircle(Color color) {
    return Container(
      width: 256,
      height: 256,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 80,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildGenderCard(String gender, IconData icon, Color bgColor, Color iconColor) {
    bool isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = gender),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF0058BC) : const Color(0x1AC1C6D7),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, size: 36, color: iconColor),
            ),
            const SizedBox(height: 16),
            Text(
              gender,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1B1F)),
            ),
            if (isSelected) ...[
              const SizedBox(height: 12),
              const Icon(Icons.check_circle, color: Color(0xFF0058BC), size: 24),
            ] else ...[
              const SizedBox(height: 36), // 12 + 24 to match height
            ]
          ],
        ),
      ),
    );
  }
}
