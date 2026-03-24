import '../models/character.dart';

class HousingService {
  /// Requirements: age >= 18, money >= 15, housingStatus == 'With Parents'
  static bool canMoveOut(Character character) {
    return character.age >= 18 &&
        character.money >= 15 &&
        character.housingStatus == 'With Parents';
  }

  /// Requirements: age >= 28, money >= 60, housingStatus == 'Renting'
  static bool canBuyHome(Character character) {
    return character.age >= 28 &&
        character.money >= 60 &&
        character.housingStatus == 'Renting';
  }

  /// Move out to renting. Deposit costs 5 money. Happiness +10.
  static void moveOut(Character character) {
    character.housingStatus = 'Renting';
    character.rentExpensePerYear = 4;
    character.money = (character.money - 5).clamp(0, 100);
    character.happiness = (character.happiness + 10).clamp(0, 100);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You moved out of your parents\' house. Freedom. Also rent. 🏠',
    );
    character.save();
  }

  /// Buy a home. Down payment costs 20 money. Happiness +20, reputation +10.
  static void buyHome(Character character) {
    character.housingStatus = 'Homeowner';
    character.rentExpensePerYear = 0;
    character.money = (character.money - 20).clamp(0, 100);
    character.happiness = (character.happiness + 20).clamp(0, 100);
    character.reputation = (character.reputation + 10).clamp(0, 100);
    character.lifeLog.insert(
      0,
      'Age ${character.age}: You bought your own home. Your mother has already claimed the guest room. 🏡',
    );
    character.save();
  }

  /// Called every age-up. Deducts rent expense if renting.
  static void progressHousing(Character character) {
    if (character.housingStatus == 'Renting' &&
        character.rentExpensePerYear > 0) {
      character.money =
          (character.money - character.rentExpensePerYear).clamp(0, 100);
    }
  }
}
