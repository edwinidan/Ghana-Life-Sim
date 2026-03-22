import 'childhood_events.dart';
import 'teen_events.dart';
import 'young_adult_events.dart';
import 'adult_events.dart';
import 'ghana_events.dart';
import 'rare_events.dart';
import 'senior_events.dart';
import '../models/event.dart';

final List<LifeEvent> allEvents = [
  ...childhoodEvents,
  ...teenEvents,
  ...youngAdultEvents,
  ...adultEvents,
  ...seniorEvents,
  ...ghanaEvents,
  ...rareEvents,
];
