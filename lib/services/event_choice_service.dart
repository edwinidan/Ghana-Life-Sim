import '../models/character.dart';
import '../models/event.dart';
import 'career_service.dart';
import '../data/illnesses.dart';
import '../domain/services/illness_progression_service.dart';

class EventChoiceService {
  static void applyChoice(Character character, EventChoice choice) {
    choice.statChanges.forEach(character.adjustStat);

    if (choice.illnessToAdd != null &&
        !character.activeIllnesses.contains(choice.illnessToAdd)) {
      character.activeIllnesses.add(choice.illnessToAdd!);
      const IllnessProgressionService().diagnose(
        character,
        illnessIdForLegacyName(choice.illnessToAdd!),
      );
    }
    if (choice.careerToSet != null) {
      CareerService.enterCareer(character, choice.careerToSet!);
    }
    if (choice.relationshipStatusToSet != null) {
      character.relationshipStatus = choice.relationshipStatusToSet!;
    }
    if (choice.housingStatusToSet != null) {
      character.housingStatus = choice.housingStatusToSet!;
    }
    if (choice.flagToAdd != null) {
      if (choice.flagDurationYears != null) {
        character.addTimedFlag(choice.flagToAdd!, choice.flagDurationYears!);
      } else {
        character.addFlag(choice.flagToAdd!);
      }
    }
    if (choice.flagToRemove != null) {
      character.removeFlag(choice.flagToRemove!);
    }
    if (choice.cashChange != 0) {
      character.adjustCash(choice.cashChange);
    }
    if (choice.debtChange != 0) {
      character.adjustDebt(choice.debtChange);
    }
    if (choice.familyBondChange != 0) {
      character.ensureFamilySeeded();
      character.adjustFamilyBonds(choice.familyBondChange);
    }
  }
}
