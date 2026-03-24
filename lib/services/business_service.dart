import 'dart:math';
import '../models/character.dart';
import '../data/businesses.dart';

class BusinessService {
  static final _random = Random();

  /// Returns business types the character can afford and qualifies for.
  /// Does NOT filter out types already owned — duplicates are allowed.
  static List<BusinessType> getAvailableBusinessTypes(Character character) {
    return allBusinessTypes.where((type) {
      if (type.startupCost > character.money) return false;
      if (type.minAge > character.age) return false;
      for (final entry in type.statRequirements.entries) {
        final statValue = _getStatValue(character, entry.key);
        if (statValue < entry.value) return false;
      }
      return true;
    }).toList();
  }

  /// Start a new business. Deducts startup cost, adds to all lists, logs.
  static void startBusiness(
      Character character, BusinessType type, String businessName) {
    character.money = (character.money - type.startupCost).clamp(0, 100);
    character.businessNames.add(businessName);
    character.businessTypes.add(type.name);
    character.businessHealthList.add(70);
    character.businessIncomeList.add(type.baseMonthlyIncome);
    _syncTotalIncome(character);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You opened $businessName (${type.emoji} ${type.name}). The whole neighbourhood is already talking. 🚀',
    );
    character.save();
  }

  /// Called every age-up for each business. Applies income and health drift.
  static void progressBusinesses(Character character) {
    if (character.businessNames.isEmpty) return;

    // Iterate in reverse so removal by index is safe
    for (int i = character.businessNames.length - 1; i >= 0; i--) {
      final health = character.businessHealthList[i];
      final baseIncome = character.businessIncomeList[i];

      // Income gain: (health/100) * baseIncome * 12 / 1000, capped at +20
      final incomeGain =
          ((health / 100) * baseIncome * 12 / 1000).floor().clamp(0, 20);
      character.adjustStat('money', incomeGain);

      // Health drift: -5 to +3
      final drift = _random.nextInt(9) - 5; // -5 to +3
      final newHealth = (health + drift).clamp(0, 100);
      character.businessHealthList[i] = newHealth;

      // Business failure
      if (newHealth <= 0) {
        final failedName = character.businessNames[i];
        final failedType = character.businessTypes[i];
        character.businessNames.removeAt(i);
        character.businessTypes.removeAt(i);
        character.businessHealthList.removeAt(i);
        character.businessIncomeList.removeAt(i);
        character.lifeLog.insert(
          0,
          'Age ${character.age}: Your $failedName ($failedType) has collapsed. The debts were too much. 😔',
        );
      }
    }

    _syncTotalIncome(character);
    character.save();
  }

  /// Invest in a business to boost its health.
  /// investmentLevel: 1 = small (cost 3, health +15), 2 = big (cost 8, health +30).
  static void investInBusiness(
      Character character, int businessIndex, int investmentLevel) {
    if (businessIndex < 0 ||
        businessIndex >= character.businessNames.length) {
      return;
    }

    final int cost = investmentLevel == 1 ? 3 : 8;
    final int healthBoost = investmentLevel == 1 ? 15 : 30;
    final String size = investmentLevel == 1 ? 'small' : 'big';

    character.money = (character.money - cost).clamp(0, 100);
    character.businessHealthList[businessIndex] =
        (character.businessHealthList[businessIndex] + healthBoost).clamp(
            0, 100);

    final name = character.businessNames[businessIndex];
    final typeEmoji = _emojiForType(character.businessTypes[businessIndex]);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You invested ($size) in your $name. New energy, new hustle. $typeEmoji',
    );
    character.save();
  }

  /// Close a business voluntarily. Partial refund of 5 money units.
  static void closeBusiness(Character character, int businessIndex) {
    if (businessIndex < 0 ||
        businessIndex >= character.businessNames.length) {
      return;
    }

    final name = character.businessNames[businessIndex];
    character.businessNames.removeAt(businessIndex);
    character.businessTypes.removeAt(businessIndex);
    character.businessHealthList.removeAt(businessIndex);
    character.businessIncomeList.removeAt(businessIndex);

    character.money = (character.money + 5).clamp(0, 100);
    _syncTotalIncome(character);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You closed $name. It was a good run. You walked away with something at least. 🏳️',
    );
    character.save();
  }

  static void _syncTotalIncome(Character character) {
    character.totalBusinessIncome = character.businessIncomeList.fold(
      0,
      (sum, income) => sum + income,
    );
  }

  static int _getStatValue(Character character, String stat) {
    switch (stat) {
      case 'streetSense':
        return character.streetSense;
      case 'looks':
        return character.looks;
      case 'discipline':
        return character.discipline;
      case 'smarts':
        return character.smarts;
      case 'connections':
        return character.connections;
      case 'reputation':
        return character.reputation;
      case 'money':
        return character.money;
      default:
        return 0;
    }
  }

  static String _emojiForType(String typeName) {
    switch (typeName) {
      case 'Chop Bar':
        return '🍲';
      case 'Barbershop / Salon':
        return '✂️';
      case 'Poultry Farm':
        return '🐔';
      case 'Clothing / Fashion':
        return '👗';
      case 'Provisions Shop':
        return '🛒';
      case 'Transport (Trotro/Taxi)':
        return '🚐';
      default:
        return '💼';
    }
  }
}
