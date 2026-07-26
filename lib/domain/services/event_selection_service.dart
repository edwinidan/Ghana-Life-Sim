import 'dart:math';

import '../../app/config/simulation_config.dart';
import '../../models/character.dart';
import '../../models/event.dart';

class EventSelectionService {
  const EventSelectionService();

  List<LifeEvent> select({
    required Character character,
    required List<LifeEvent> events,
    required Random random,
  }) {
    final occurrenceCounts = <String, int>{};
    final latestAges = <String, int>{};
    for (final history in character.eventHistory) {
      final separator = history.indexOf(':');
      if (separator <= 0) continue;
      final age = int.tryParse(history.substring(0, separator)) ?? -999;
      final id = history.substring(separator + 1);
      occurrenceCounts.update(id, (count) => count + 1, ifAbsent: () => 1);
      latestAges.update(id, (latest) => max(latest, age), ifAbsent: () => age);
    }
    final eligible = events
        .where(
          (event) =>
              _isEligible(character, event, occurrenceCounts, latestAges),
        )
        .toList();
    if (eligible.isEmpty) return [];

    final desired = character.age < 13
        ? 1
        : 1 + (random.nextDouble() < 0.35 ? 1 : 0);
    final count = min(
      desired,
      min(SimulationConfig.maxMajorDecisionsPerYear, eligible.length),
    );
    final selected = <LifeEvent>[];
    final pool = [...eligible];

    while (selected.length < count && pool.isNotEmpty) {
      final total = pool.fold<int>(
        0,
        (sum, event) => sum + _weight(character, event),
      );
      var roll = random.nextInt(total);
      LifeEvent? winner;
      for (final event in pool) {
        roll -= _weight(character, event);
        if (roll < 0) {
          winner = event;
          break;
        }
      }
      winner ??= pool.last;
      selected.add(winner);
      pool.remove(winner);
    }

    return selected;
  }

  bool _isEligible(
    Character character,
    LifeEvent event,
    Map<String, int> occurrenceCounts,
    Map<String, int> latestAges,
  ) {
    if (character.age < event.minAge || character.age > event.maxAge) {
      return false;
    }
    if (event.requiredCareer != null &&
        event.requiredCareer != character.careerPath) {
      return false;
    }
    if (event.requiredRelationshipStatus != null &&
        event.requiredRelationshipStatus != character.relationshipStatus) {
      return false;
    }
    if (event.requiredHousingStatus != null &&
        event.requiredHousingStatus != character.housingStatus) {
      return false;
    }
    if (event.requiresBusiness != null &&
        event.requiresBusiness != character.businessNames.isNotEmpty) {
      return false;
    }
    if (!event.requiredFlags.every(character.hasFlag) ||
        !event.blockedFlags.every((flag) => !character.hasFlag(flag))) {
      return false;
    }
    for (final delay in event.minimumYearsAfterFlags.entries) {
      final setAge = character.flagSetAge(delay.key);
      if (setAge == null || character.age - setAge < delay.value) {
        return false;
      }
    }
    if (!event.statRequirements.entries.every(
      (requirement) => _stat(character, requirement.key) >= requirement.value,
    )) {
      return false;
    }

    final occurrences = occurrenceCounts[event.stableId] ?? 0;
    if (occurrences >= event.maxOccurrences) return false;

    final latestAge = latestAges[event.stableId] ?? -999;
    return character.age - latestAge > event.cooldownYears;
  }

  int _weight(Character character, LifeEvent event) {
    var weight = event.baseWeight.clamp(1, 1000) + event.priority * 10;
    if (character.health < 35 && event.category == 'health') weight += 20;
    if (character.cash < 1000 && event.category == 'money') weight += 15;
    return weight.clamp(1, 2000);
  }

  int _stat(Character character, String name) => switch (name) {
    'health' => character.health,
    'happiness' => character.happiness,
    'smarts' => character.smarts,
    'looks' => character.looks,
    'money' => character.money,
    'reputation' => character.reputation,
    'discipline' => character.discipline,
    'streetSense' => character.streetSense,
    'connections' => character.connections,
    'relationshipScore' => character.relationshipScore,
    _ => 0,
  };
}
