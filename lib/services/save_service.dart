import 'package:hive_flutter/hive_flutter.dart';
import '../models/character.dart';
import 'life_goal_service.dart';

class SaveService {
  static const String _boxName = 'ghana_life_box';
  static const String _saveKey = 'current_character';

  static Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
    await Hive.openBox<Character>(_boxName);
  }

  static Future<void> initForTests(String path) async {
    Hive.init(path);
    _registerAdapters();
    await Hive.openBox<Character>(_boxName);
  }

  static void _registerAdapters() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CharacterAdapter());
    }
  }

  static Future<void> saveGame(Character character) async {
    final box = Hive.box<Character>(_boxName);
    await box.put(_saveKey, character);
  }

  static Future<Character?> loadGame() async {
    final box = Hive.box<Character>(_boxName);
    final character = box.get(_saveKey);
    character?.ensureFamilySeeded();
    if (character != null && character.actionEnergy < 0) {
      character.actionEnergy = 0;
    }
    if (character != null && !character.isDead) {
      LifeGoalService.ensureActiveGoal(character);
    }
    await character?.save();
    return character;
  }

  static bool hasSavedGame() {
    final box = Hive.box<Character>(_boxName);
    return box.containsKey(_saveKey);
  }

  static Future<void> deleteSave() async {
    final box = Hive.box<Character>(_boxName);
    await box.delete(_saveKey);
  }
}
