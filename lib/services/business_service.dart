import 'dart:math';
import '../models/character.dart';
import '../data/businesses.dart';
import '../domain/models/business_state.dart';
import '../domain/repositories/business_state_repository.dart';

class BusinessService {
  static final _random = Random();
  static const int startupCostUnit = 1000;

  /// Returns business types the character can afford and qualifies for.
  /// Does NOT filter out types already owned — duplicates are allowed.
  static List<BusinessType> getAvailableBusinessTypes(Character character) {
    return allBusinessTypes.where((type) {
      if (startupCashCost(type) > character.cash) return false;
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
    Character character,
    BusinessType type,
    String businessName,
  ) {
    character.adjustCash(-startupCashCost(type));
    character.money = (character.money - 3).clamp(0, 100);
    character.businessNames.add(businessName);
    character.businessTypes.add(type.name);
    character.businessHealthList.add(70);
    character.businessIncomeList.add(type.baseMonthlyIncome);
    final typedBusinesses = const BusinessStateRepository().read(character);
    typedBusinesses.add(
      BusinessState(
        id:
            'business-${character.lifeSeed}-${character.age}-'
            '${typedBusinesses.length}',
        definitionId: type.id,
        displayName: businessName,
        startedAtAge: character.age,
        reputation: 55,
        risk: type.baseRisk,
        annualRevenue: type.baseAnnualRevenue,
        annualExpenses: type.baseAnnualExpenses,
      ),
    );
    const BusinessStateRepository().write(character, typedBusinesses);
    _syncTotalIncome(character);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You opened $businessName (${type.emoji} ${type.name}). The whole neighbourhood is already talking. 🚀',
    );
  }

  /// Called every age-up for each business. Applies income and health drift.
  static void progressBusinesses(
    Character character, {
    Random? random,
    bool persist = true,
  }) {
    if (character.businessNames.isEmpty) return;

    // Iterate in reverse so removal by index is safe
    for (int i = character.businessNames.length - 1; i >= 0; i--) {
      final health = character.businessHealthList[i];
      final baseIncome = character.businessIncomeList[i];

      // Income gain: (health/100) * baseIncome * 12 / 1000, capped at +20
      final incomeGain = ((health / 100) * baseIncome * 12 / 1000)
          .floor()
          .clamp(0, 20);
      final cashGain = ((health / 100) * baseIncome * 12).floor();
      character.adjustCash(cashGain);
      character.adjustStat('money', incomeGain);

      // Health drift: -5 to +3
      final drift = (random ?? _random).nextInt(9) - 5; // -5 to +3
      final newHealth = (health + drift).clamp(0, 100);
      character.businessHealthList[i] = newHealth;

      // Business failure
      if (newHealth <= 0) {
        final failedName = character.businessNames[i];
        final failedType = character.businessTypes[i];
        final cleanupDebt = (baseIncome * 2).clamp(1000, 15000);
        character.businessNames.removeAt(i);
        character.businessTypes.removeAt(i);
        character.businessHealthList.removeAt(i);
        character.businessIncomeList.removeAt(i);
        character.adjustDebt(cleanupDebt);
        character.adjustStat('reputation', -8);
        character.lifeLog.insert(
          0,
          'Age ${character.age}: Your $failedName ($failedType) has collapsed, leaving GHS $cleanupDebt in cleanup debt. 😔',
        );
      }
    }

    _syncTotalIncome(character);
  }

  /// Invest in a business to boost its health.
  /// investmentLevel: 1 = small (cost 3, health +15), 2 = big (cost 8, health +30).
  static void investInBusiness(
    Character character,
    int businessIndex,
    int investmentLevel,
  ) {
    if (businessIndex < 0 || businessIndex >= character.businessNames.length) {
      return;
    }

    final int cost = investmentLevel == 1 ? 3000 : 8000;
    final int healthBoost = investmentLevel == 1 ? 15 : 30;
    final String size = investmentLevel == 1 ? 'small' : 'big';

    character.adjustCash(-cost);
    character.businessHealthList[businessIndex] =
        (character.businessHealthList[businessIndex] + healthBoost).clamp(
          0,
          100,
        );

    final name = character.businessNames[businessIndex];
    final typedBusinesses = const BusinessStateRepository().read(character);
    final typedIndex = typedBusinesses.indexWhere(
      (business) =>
          business.displayName == name &&
          (business.status == BusinessStatus.active ||
              business.status == BusinessStatus.struggling),
    );
    if (typedIndex >= 0) {
      final business = typedBusinesses[typedIndex];
      typedBusinesses[typedIndex] = business.copyWith(
        growthLevel: investmentLevel == 1
            ? business.growthLevel
            : (business.growthLevel + 1).clamp(1, 5),
        reputation: (business.reputation + healthBoost ~/ 3).clamp(0, 100),
        risk: (business.risk - healthBoost ~/ 2).clamp(0, 100),
      );
      const BusinessStateRepository().write(character, typedBusinesses);
    }
    final typeEmoji = _emojiForType(character.businessTypes[businessIndex]);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You invested ($size) in your $name. New energy, new hustle. $typeEmoji',
    );
  }

  /// Close a business voluntarily. Partial refund of GHS 5,000.
  static void closeBusiness(Character character, int businessIndex) {
    if (businessIndex < 0 || businessIndex >= character.businessNames.length) {
      return;
    }

    final name = character.businessNames[businessIndex];
    final typedBusinesses = const BusinessStateRepository().read(character);
    final typedIndex = typedBusinesses.indexWhere(
      (business) =>
          business.displayName == name &&
          (business.status == BusinessStatus.active ||
              business.status == BusinessStatus.struggling),
    );
    if (typedIndex >= 0) {
      typedBusinesses[typedIndex] = typedBusinesses[typedIndex].copyWith(
        status: BusinessStatus.closed,
      );
      const BusinessStateRepository().write(character, typedBusinesses);
    }
    character.businessNames.removeAt(businessIndex);
    character.businessTypes.removeAt(businessIndex);
    character.businessHealthList.removeAt(businessIndex);
    character.businessIncomeList.removeAt(businessIndex);

    character.adjustCash(5000);
    _syncTotalIncome(character);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You closed $name. It was a good run. You walked away with something at least. 🏳️',
    );
  }

  static void _syncTotalIncome(Character character) {
    character.totalBusinessIncome = character.businessIncomeList.fold(
      0,
      (sum, income) => sum + income,
    );
  }

  static int startupCashCost(BusinessType type) =>
      type.startupCost * startupCostUnit;

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
