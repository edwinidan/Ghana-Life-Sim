import '../../models/character.dart';
import '../models/timeline_entry.dart';

class TimelineRepository {
  const TimelineRepository();

  List<TimelineEntry> read(Character character) {
    final entries = <TimelineEntry>[];
    for (final record in character.timelineRecords) {
      try {
        entries.add(TimelineEntry.decode(record));
      } catch (_) {
        // A malformed timeline record must not make the whole save unusable.
      }
    }
    entries.sort((a, b) {
      final ageOrder = b.age.compareTo(a.age);
      return ageOrder != 0 ? ageOrder : b.id.compareTo(a.id);
    });
    return entries;
  }

  void add(Character character, TimelineEntry entry) {
    if (character.timelineRecords.any((record) {
      try {
        return TimelineEntry.decode(record).id == entry.id;
      } catch (_) {
        return false;
      }
    })) {
      return;
    }
    character.timelineRecords.add(entry.encode());
  }
}
