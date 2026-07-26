import '../../models/event.dart';

class EventCatalogIssue {
  const EventCatalogIssue(this.eventId, this.message);

  final String eventId;
  final String message;

  @override
  String toString() => '$eventId: $message';
}

class EventCatalogValidator {
  const EventCatalogValidator();

  List<EventCatalogIssue> validate(List<LifeEvent> events) {
    final issues = <EventCatalogIssue>[];
    final ids = <String>{};

    for (final event in events) {
      final id = event.stableId;
      if (!ids.add(id)) {
        issues.add(EventCatalogIssue(id, 'Duplicate stable event ID.'));
      }
      if (event.minAge < 0 || event.maxAge < event.minAge) {
        issues.add(EventCatalogIssue(id, 'Invalid age range.'));
      }
      if (event.baseWeight <= 0) {
        issues.add(EventCatalogIssue(id, 'Base weight must be positive.'));
      }
      if (event.choices.length < 2 || event.choices.length > 4) {
        issues.add(
          EventCatalogIssue(id, 'Events require between 2 and 4 choices.'),
        );
      }
      if (event.title.trim().isEmpty || event.description.trim().isEmpty) {
        issues.add(
          EventCatalogIssue(id, 'Title and description are required.'),
        );
      }
      for (final choice in event.choices) {
        if (choice.text.trim().isEmpty || choice.outcome.trim().isEmpty) {
          issues.add(EventCatalogIssue(id, 'Choice copy cannot be empty.'));
        }
      }
    }
    return issues;
  }
}
