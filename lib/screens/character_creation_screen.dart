import 'dart:math';

import 'package:flutter/material.dart';

import '../app/theme/app_theme.dart';
import '../models/character.dart';
import '../services/save_service.dart';
import 'life_screen.dart';

class CharacterCreationScreen extends StatefulWidget {
  const CharacterCreationScreen({super.key});

  @override
  State<CharacterCreationScreen> createState() =>
      _CharacterCreationScreenState();
}

class _CharacterCreationScreenState extends State<CharacterCreationScreen> {
  static const _regions = [
    'Random',
    'Greater Accra',
    'Ashanti',
    'Central',
    'Eastern',
    'Western',
    'Volta',
    'Northern',
    'Upper East',
    'Upper West',
    'Bono',
  ];
  static const _maleNames = [
    'Kwame Mensah',
    'Kofi Asare',
    'Yaw Boateng',
    'Kojo Owusu',
    'Nana Addo',
  ];
  static const _femaleNames = [
    'Ama Mensah',
    'Akosua Asare',
    'Abena Boateng',
    'Efua Owusu',
    'Adwoa Addo',
  ];

  final _nameController = TextEditingController();
  final _random = Random();
  String _gender = 'Male';
  String _region = 'Random';
  bool _creating = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GHANA LIFE',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.8),
        ),
        actions: [
          IconButton(
            tooltip: 'Randomise character',
            onPressed: _randomise,
            icon: const Icon(Icons.casino_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 32),
          children: [
            Text(
              'Begin your story',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose the basics. Your personality, opportunities and goals '
              'will emerge as you live.',
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              maxLength: 40,
              decoration: const InputDecoration(
                labelText: 'Full name',
                hintText: 'e.g. Ama Mensah',
                prefixIcon: Icon(Icons.person_outline),
              ),
              onSubmitted: (_) => _startLife(),
            ),
            const SizedBox(height: 18),
            Text('Gender', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'Male',
                  label: Text('Male'),
                  icon: Icon(Icons.male),
                ),
                ButtonSegment(
                  value: 'Female',
                  label: Text('Female'),
                  icon: Icon(Icons.female),
                ),
              ],
              selected: {_gender},
              onSelectionChanged: (value) =>
                  setState(() => _gender = value.first),
              showSelectedIcon: false,
              style: const ButtonStyle(
                visualDensity: VisualDensity(vertical: 2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Birth region',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _region,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              items: _regions
                  .map(
                    (region) =>
                        DropdownMenuItem(value: region, child: Text(region)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _region = value ?? 'Random'),
            ),
            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🇬🇭', style: TextStyle(fontSize: 30)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Family background, starting stats and hidden '
                        'personality tendencies will be generated for this life.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _creating ? null : _startLife,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _creating
                  ? const SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Begin Your Life'),
            ),
          ],
        ),
      ),
    );
  }

  void _randomise() {
    final names = _gender == 'Male' ? _maleNames : _femaleNames;
    setState(() {
      _nameController.text = names[_random.nextInt(names.length)];
      _region = _regions[1 + _random.nextInt(_regions.length - 1)];
    });
  }

  Future<void> _startLife() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter your name first.')));
      return;
    }

    setState(() => _creating = true);
    final region = _region == 'Random'
        ? _regions[1 + _random.nextInt(_regions.length - 1)]
        : _region;
    final character = Character(name: name, gender: _gender)
      ..birthRegion = region
      ..householdClass = _householdClass()
      ..originSummary = '';
    await SaveService.saveGame(character);
    final loaded = await SaveService.loadGame() ?? character;
    if (!mounted) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Text('👶', style: TextStyle(fontSize: 44)),
        title: const Text('A new life begins'),
        content: Text(loaded.originSummary),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Start living'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LifeScreen(character: loaded)),
    );
  }

  String _householdClass() {
    const classes = ['Struggling', 'Getting By', 'Comfortable'];
    return classes[_random.nextInt(classes.length)];
  }
}
