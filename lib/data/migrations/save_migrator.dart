import '../../app/config/simulation_config.dart';
import '../../domain/models/timeline_entry.dart';
import '../../domain/models/business_state.dart';
import '../../domain/models/illness_state.dart';
import '../../domain/repositories/timeline_repository.dart';
import '../../models/character.dart';
import '../illnesses.dart';

class SaveMigrator {
  const SaveMigrator(this._timelineRepository);

  final TimelineRepository _timelineRepository;

  bool migrate(Character character) {
    var changed = false;

    if (character.schemaVersion < 4) {
      if (character.educationSpecialization.isEmpty) {
        final inferred = switch (character.careerPath) {
          'Healthcare' => 'Health Sciences',
          'Education' => 'Education',
          'Tech' => 'Engineering & Technology',
          'Commerce' => 'Business & Administration',
          'Sports & Media' || 'Entertainment' => 'Arts, Media & Sport',
          _ when character.educationLevel == 'Vocational' => 'Technical Trade',
          _
              when character.educationLevel == 'University' ||
                  character.educationLevel == 'Tertiary Diploma' =>
            'General Studies',
          _ => '',
        };
        character.educationSpecialization = inferred;
        if ((character.educationLevel == 'University' ||
                character.educationLevel == 'Tertiary Diploma' ||
                character.enrolledIn == 'University' ||
                character.enrolledIn == 'Nursing / Teacher Training College') &&
            character.careerPath == 'None') {
          character.addFlag('legacy_broad_degree');
        }
        changed = true;
      }
      if (character.careerPath != 'None') {
        character.employmentStatus = 'Employed';
        character.jobPerformance = 55;
        changed = true;
      }
    }

    if (character.lifeSeed == 0) {
      character.lifeSeed =
          character.name.codeUnits.fold<int>(
            character.birthYear,
            (a, b) => a + b,
          ) &
          0x7fffffff;
      changed = true;
    }
    if (character.birthYear == 0) {
      character.birthYear = DateTime.now().year - character.age;
      changed = true;
    }
    if (character.originSummary.isEmpty) {
      character.ensureFamilySeeded();
      final parents = character.familyNames.take(2).join(' and ');
      character.originSummary =
          'You were born in ${character.birthRegion}'
          '${parents.isEmpty ? '' : ' to $parents'}. '
          'Your family was ${character.householdClass.toLowerCase()}.';
      changed = true;
    }
    if (character.timelineRecords.isEmpty) {
      _timelineRepository.add(
        character,
        TimelineEntry(
          id: 'birth-${character.lifeSeed}',
          age: 0,
          type: TimelineEntryType.birth,
          title: 'A new Ghanaian life began',
          body: character.originSummary,
          isImportant: true,
        ),
      );
      for (var index = character.lifeLog.length - 1; index >= 0; index--) {
        final log = character.lifeLog[index];
        final ageMatch = RegExp(r'^Age (\d+):\s*(.*)$').firstMatch(log);
        final age = int.tryParse(ageMatch?.group(1) ?? '') ?? 0;
        final body = ageMatch?.group(2) ?? log;
        _timelineRepository.add(
          character,
          TimelineEntry(
            id: 'legacy-$age-$index-${body.hashCode}',
            age: age,
            type: TimelineEntryType.story,
            title: 'Life event',
            body: body,
          ),
        );
      }
      changed = true;
    }
    if (character.businessStateRecords.isEmpty &&
        character.businessNames.isNotEmpty) {
      for (var index = 0; index < character.businessNames.length; index++) {
        final type = index < character.businessTypes.length
            ? character.businessTypes[index]
            : 'Unknown';
        final health = index < character.businessHealthList.length
            ? character.businessHealthList[index]
            : 50;
        final monthlyIncome = index < character.businessIncomeList.length
            ? character.businessIncomeList[index]
            : 0;
        final definitionId = type
            .toLowerCase()
            .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
            .replaceAll(RegExp(r'^_+|_+$'), '');
        character.businessStateRecords.add(
          BusinessState(
            id: 'business-${character.lifeSeed}-$index',
            definitionId: definitionId.isEmpty ? 'unknown' : definitionId,
            displayName: character.businessNames[index],
            startedAtAge: character.age,
            reputation: health.clamp(0, 100),
            risk: (100 - health).clamp(0, 100),
            annualRevenue: monthlyIncome * 12,
          ).encode(),
        );
      }
      changed = true;
    }
    if (character.illnessStateRecords.isEmpty &&
        character.activeIllnesses.isNotEmpty) {
      for (var index = 0; index < character.activeIllnesses.length; index++) {
        final legacyName = character.activeIllnesses[index];
        character.illnessStateRecords.add(
          ActiveIllnessState(
            id: 'illness-${character.lifeSeed}-$index',
            illnessDefinitionId: illnessIdForLegacyName(legacyName),
            diagnosedAtAge: character.age,
            history: [
              IllnessHistoryEntry(
                age: character.age,
                action: 'legacy_migration',
                summary: 'Migrated from legacy condition: $legacyName',
              ),
            ],
          ).encode(),
        );
      }
      changed = true;
    }
    if (character.schemaVersion < SimulationConfig.currentSaveSchemaVersion) {
      character.schemaVersion = SimulationConfig.currentSaveSchemaVersion;
      changed = true;
    }
    return changed;
  }
}
