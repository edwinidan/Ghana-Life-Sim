import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'character_creation_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const List<_OnboardingCard> _cards = [
    _OnboardingCard(
      emoji: '🇬🇭',
      title: 'Welcome to Ghana Life Sim',
      body: 'You control one life from birth to death. Every choice matters. Some choices will surprise you.',
      isFirstPage: true,
    ),
    _OnboardingCard(
      emoji: '📊',
      title: 'Your Stats Are Everything',
      body: 'Health, Happiness, Money, Smarts and more — they open doors and close them. Watch them carefully.',
    ),
    _OnboardingCard(
      emoji: '🎓',
      title: 'Study Hard. Hustle Harder.',
      body: 'Go to school to unlock better careers. Visit the Job tab to apply for work and pick up side gigs.',
    ),
    _OnboardingCard(
      emoji: '💕',
      title: 'Life Is Not Just Work',
      body: 'Find a partner in the Social tab. Start businesses in the Doing tab. Build a life worth remembering.',
    ),
  ];

  Future<void> _complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CharacterCreationScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _cards.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button row
            Align(
              alignment: Alignment.topRight,
              child: isLastPage
                  ? const SizedBox(height: 48)
                  : TextButton(
                      onPressed: _complete,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _cards.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(card.emoji, style: const TextStyle(fontSize: 72)),
                        // Ghana flag accent — only on first page
                        if (card.isFirstPage) ...[
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _flagDot(const Color(0xFFCE1126)),
                              const SizedBox(width: 6),
                              _flagDot(const Color(0xFFFCD116)),
                              const SizedBox(width: 6),
                              _flagDot(const Color(0xFF006B3F)),
                            ],
                          ),
                        ],
                        const SizedBox(height: 32),
                        Text(
                          card.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF424242),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          card.body,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF757575),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dot indicators
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_cards.length, (i) {
                  final active = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: active ? 20 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: active ? const Color(0xFFB39DDB) : const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),

            // Next / Start button
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLastPage
                      ? _complete
                      : () => _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB39DDB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    isLastPage ? 'Start My Life 🇬🇭' : 'Next',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _flagDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _OnboardingCard {
  final String emoji;
  final String title;
  final String body;
  final bool isFirstPage;

  const _OnboardingCard({
    required this.emoji,
    required this.title,
    required this.body,
    this.isFirstPage = false,
  });
}
