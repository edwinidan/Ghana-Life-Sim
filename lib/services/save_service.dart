import 'package:hive_flutter/hive_flutter.dart';
import '../models/character.dart';
import 'life_goal_service.dart';
import '../data/migrations/save_migrator.dart';
import '../domain/repositories/timeline_repository.dart';

class SaveService {
  static const String _boxName = 'ghana_life_box';
  static const String _backupBoxName = 'ghana_life_backup_box';
  static const String _saveKey = 'current_character';
  static const String _backupKey = 'last_valid_character';

  static Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
    await Hive.openBox<Character>(_boxName);
    await Hive.openBox<Character>(_backupBoxName);
  }

  static Future<void> initForTests(String path) async {
    Hive.init(path);
    _registerAdapters();
    await Hive.openBox<Character>(_boxName);
    await Hive.openBox<Character>(_backupBoxName);
  }

  static void _registerAdapters() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CharacterAdapter());
    }
  }

  static Future<void> saveGame(
    Character character, {
    SaveMigrator? migrator,
  }) async {
    final box = Hive.box<Character>(_boxName);
    final backupBox = Hive.box<Character>(_backupBoxName);
    final preMigration = character.detachedCopy();
    await backupBox.put(_backupKey, preMigration);
    try {
      (migrator ?? SaveMigrator(const TimelineRepository())).migrate(character);
      await box.put(_saveKey, character);
      await backupBox.put(_backupKey, character.detachedCopy());
    } catch (_) {
      await box.put(_saveKey, preMigration.detachedCopy());
      rethrow;
    }
  }

  static Future<Character?> loadGame() async {
    final box = Hive.box<Character>(_boxName);
    Character? character;
    try {
      character = box.get(_saveKey);
    } catch (_) {
      character = null;
    }
    if (character == null) {
      final backup = Hive.box<Character>(_backupBoxName).get(_backupKey);
      if (backup != null) {
        character = backup.detachedCopy();
        await box.put(_saveKey, character);
      }
    }
    character?.ensureFamilySeeded();
    if (character != null && character.actionEnergy < 0) {
      character.actionEnergy = 0;
    }
    if (character != null && !character.isDead) {
      LifeGoalService.ensureActiveGoal(character);
    }
    if (character != null) {
      final preMigration = character.detachedCopy();
      await Hive.box<Character>(_backupBoxName).put(_backupKey, preMigration);
      try {
        final changed = SaveMigrator(
          const TimelineRepository(),
        ).migrate(character);
        if (changed) await box.put(_saveKey, character);
        await Hive.box<Character>(
          _backupBoxName,
        ).put(_backupKey, character.detachedCopy());
      } catch (_) {
        character = preMigration;
        await box.put(_saveKey, character);
      }
    }
    return character;
  }

  static bool hasSavedGame() {
    final box = Hive.box<Character>(_boxName);
    return box.containsKey(_saveKey) ||
        Hive.box<Character>(_backupBoxName).containsKey(_backupKey);
  }

  static Future<void> deleteSave() async {
    final box = Hive.box<Character>(_boxName);
    await box.delete(_saveKey);
    await Hive.box<Character>(_backupBoxName).delete(_backupKey);
  }
}
