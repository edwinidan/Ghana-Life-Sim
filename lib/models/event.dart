class EventChoice {
  final String? id;
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
  final int familyBondChange;
  final int? flagDurationYears;

  const EventChoice({
    this.id,
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
    this.familyBondChange = 0,
    this.flagDurationYears,
  });
}

class LifeEvent {
  final String? id;
  final int version;
  final String category;
  final int cooldownYears;
  final int maxOccurrences;
  final String? chainId;
  final int priority;
  final List<String> tags;
  final List<String> ratingTags;
  final Map<String, int> minimumYearsAfterFlags;
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
    this.id,
    this.version = 1,
    this.category = 'life',
    this.cooldownYears = 3,
    this.maxOccurrences = 1,
    this.chainId,
    this.priority = 0,
    this.tags = const [],
    this.ratingTags = const [],
    this.minimumYearsAfterFlags = const {},
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

  String get stableId {
    if (id != null && id!.isNotEmpty) return id!;
    final slug = title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '.')
        .replaceAll(RegExp(r'^\.+|\.+$'), '');
    return '$category.$slug.v$version';
  }
}
