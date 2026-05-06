class EventChoice {
  final String text;
  final Map<String, int> statChanges;
  final String outcome;
  final String? careerToSet; // if set, triggers CareerService.enterCareer()
  final String? illnessToAdd; // if set, adds illness name to activeIllnesses
  final String? relationshipStatusToSet;
  final String? housingStatusToSet;
  final String? flagToAdd;
  final String? flagToRemove;
  final int cashChange;
  final int debtChange;

  const EventChoice({
    required this.text,
    required this.statChanges,
    required this.outcome,
    this.careerToSet,
    this.illnessToAdd,
    this.relationshipStatusToSet,
    this.housingStatusToSet,
    this.flagToAdd,
    this.flagToRemove,
    this.cashChange = 0,
    this.debtChange = 0,
  });
}

class LifeEvent {
  final String title;
  final String description;
  final List<EventChoice> choices;
  final int minAge;
  final int maxAge;
  final Map<String, int> statRequirements;
  final int baseWeight;
  final List<String> requiredFlags;
  final List<String> blockedFlags;
  final String? requiredCareer; // if set, only fires for this careerPath
  final String?
  requiredRelationshipStatus; // if set, only fires for this relationshipStatus
  final String?
  requiredHousingStatus; // if set, only fires for this housingStatus
  final bool?
  requiresBusiness; // if set, only fires when businessNames.isNotEmpty matches

  const LifeEvent({
    required this.title,
    required this.description,
    required this.choices,
    this.minAge = 0,
    this.maxAge = 90,
    this.statRequirements = const {},
    this.baseWeight = 10,
    this.requiredFlags = const [],
    this.blockedFlags = const [],
    this.requiredCareer,
    this.requiredRelationshipStatus,
    this.requiredHousingStatus,
    this.requiresBusiness,
  });
}
