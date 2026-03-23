class EventChoice {
  final String text;
  final Map<String, int> statChanges;
  final String outcome;
  final String? careerToSet; // if set, triggers CareerService.enterCareer()

  const EventChoice({
    required this.text,
    required this.statChanges,
    required this.outcome,
    this.careerToSet,
  });
}

class LifeEvent {
  final String title;
  final String description;
  final List<EventChoice> choices;
  final int minAge;
  final int maxAge;
  final Map<String, int> statRequirements;
  final String? requiredCareer; // if set, only fires for this careerPath

  const LifeEvent({
    required this.title,
    required this.description,
    required this.choices,
    this.minAge = 0,
    this.maxAge = 90,
    this.statRequirements = const {},
    this.requiredCareer,
  });
}
