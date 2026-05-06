import 'package:hive_flutter/hive_flutter.dart';
import '../models/character.dart';

class SaveService {
  static const String _boxName = 'ghana_life_box';
  static const String _saveKey = 'current_character';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CharacterAdapter());
    await Hive.openBox<Character>(_boxName);
  }

  static Future<void> saveGame(Character character) async {
    final box = Hive.box<Character>(_boxName);
    await box.put(_saveKey, character);
  }

  static Future<Character?> loadGame() async {
    final box = Hive.box<Character>(_boxName);
    return box.get(_saveKey);
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
