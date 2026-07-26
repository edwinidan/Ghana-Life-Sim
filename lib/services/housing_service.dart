import '../models/character.dart';

class HousingService {
  static const int moveOutDeposit = 1000;
  static const int homeDownPayment = 25000;
  static const int rentPerYear = 2400;

  /// Requirements: age >= 18, money >= 15, housingStatus == 'With Parents'
  static bool canMoveOut(Character character) {
    return character.age >= 18 &&
        character.cash >= moveOutDeposit &&
        character.housingStatus == 'With Parents';
  }

  /// Requirements: age >= 28, money >= 60, housingStatus == 'Renting'
  static bool canBuyHome(Character character) {
    return character.age >= 28 &&
        character.cash >= homeDownPayment &&
        character.housingStatus == 'Renting';
  }

  /// Move out to renting. Deposit costs 5 money. Happiness +10.
  static void moveOut(Character character) {
    character.housingStatus = 'Renting';
    character.rentExpensePerYear = rentPerYear;
    character.adjustCash(-moveOutDeposit);
    character.money = (character.money - 2).clamp(0, 100);
    character.happiness = (character.happiness + 10).clamp(0, 100);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You moved out of your parents\' house. Freedom. Also rent. 🏠',
    );
  }

  /// Buy a home. Down payment costs 20 money. Happiness +20, reputation +10.
  static void buyHome(Character character) {
    character.housingStatus = 'Homeowner';
    character.rentExpensePerYear = 0;
    character.adjustCash(-homeDownPayment);
    character.money = (character.money + 5).clamp(0, 100);
    character.happiness = (character.happiness + 20).clamp(0, 100);
    character.reputation = (character.reputation + 10).clamp(0, 100);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You bought your own home. Your mother has already claimed the guest room. 🏡',
    );
  }

  /// Called every age-up. Deducts rent expense if renting.
  static void progressHousing(Character character) {
    if (character.housingStatus == 'Renting' &&
        character.rentExpensePerYear > 0) {
      if (character.cash >= character.rentExpensePerYear) {
        character.adjustCash(-character.rentExpensePerYear);
      } else {
        final shortfall = character.rentExpensePerYear - character.cash;
        character.cash = 0;
        character.adjustDebt(shortfall);
        character.adjustStat('happiness', -4);
        character.adjustStat('money', -3);
        character.lifeLog.insert(
          0,
          'Age ${character.age}: Rent was short, so GHS $shortfall went into debt. The landlord did not smile. 🏠',
        );
      }
    }
  }
}
