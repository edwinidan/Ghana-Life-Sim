class EventChoice {
  final String text;
  final Map<String, int> statChanges;
  final String outcome;

  const EventChoice({
    required this.text,
    required this.statChanges,
    required this.outcome,
  });
}

class LifeEvent {
  final String title;
  final String description;
  final List<EventChoice> choices;
  final int minAge;
  final int maxAge;
  final Map<String, int> statRequirements; // e.g. smarts > 50

  const LifeEvent({
    required this.title,
    required this.description,
    required this.choices,
    this.minAge = 0,
    this.maxAge = 90,
    this.statRequirements = const {},
  });
}
