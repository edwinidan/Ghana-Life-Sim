import '../domain/models/illness_state.dart';

class TreatmentOption {
  const TreatmentOption({
    required this.id,
    required this.name,
    required this.cost,
    required this.successChance,
    this.ongoingCost = 0,
  });

  final String id;
  final String name;
  final int cost;
  final double successChance;
  final int ongoingCost;
}

class IllnessDefinition {
  const IllnessDefinition({
    required this.id,
    required this.displayName,
    required this.severity,
    required this.chronic,
    required this.minimumAge,
    required this.maximumAge,
    required this.yearlyHealthImpact,
    required this.untreatedRisk,
    required this.treatments,
    this.tags = const {},
  });

  final String id;
  final String displayName;
  final IllnessSeverity severity;
  final bool chronic;
  final int minimumAge;
  final int maximumAge;
  final int yearlyHealthImpact;
  final int untreatedRisk;
  final List<TreatmentOption> treatments;
  final Set<String> tags;
}

const illnessDefinitions = [
  IllnessDefinition(
    id: 'malaria',
    displayName: 'Malaria',
    severity: IllnessSeverity.moderate,
    chronic: false,
    minimumAge: 0,
    maximumAge: 109,
    yearlyHealthImpact: 8,
    untreatedRisk: 18,
    treatments: [
      TreatmentOption(
        id: 'clinic_medication',
        name: 'Clinic visit and medication',
        cost: 450,
        successChance: 0.86,
      ),
    ],
    tags: {'infectious', 'acute'},
  ),
  IllnessDefinition(
    id: 'typhoid_fever',
    displayName: 'Typhoid Fever',
    severity: IllnessSeverity.severe,
    chronic: false,
    minimumAge: 5,
    maximumAge: 109,
    yearlyHealthImpact: 12,
    untreatedRisk: 28,
    treatments: [
      TreatmentOption(
        id: 'hospital_treatment',
        name: 'Hospital treatment',
        cost: 900,
        successChance: 0.82,
      ),
    ],
    tags: {'infectious', 'acute'},
  ),
  IllnessDefinition(
    id: 'hypertension',
    displayName: 'Hypertension',
    severity: IllnessSeverity.moderate,
    chronic: true,
    minimumAge: 25,
    maximumAge: 109,
    yearlyHealthImpact: 5,
    untreatedRisk: 22,
    treatments: [
      TreatmentOption(
        id: 'medication',
        name: 'Medication and monitoring',
        cost: 600,
        successChance: 0.78,
        ongoingCost: 420,
      ),
    ],
    tags: {'chronic', 'cardiovascular'},
  ),
  IllnessDefinition(
    id: 'depression',
    displayName: 'Depression',
    severity: IllnessSeverity.moderate,
    chronic: true,
    minimumAge: 13,
    maximumAge: 109,
    yearlyHealthImpact: 3,
    untreatedRisk: 12,
    treatments: [
      TreatmentOption(
        id: 'professional_support',
        name: 'Professional support',
        cost: 700,
        successChance: 0.72,
        ongoingCost: 300,
      ),
    ],
    tags: {'chronic', 'mental_health'},
  ),
  IllnessDefinition(
    id: 'stroke_risk',
    displayName: 'Stroke Risk',
    severity: IllnessSeverity.severe,
    chronic: true,
    minimumAge: 30,
    maximumAge: 109,
    yearlyHealthImpact: 8,
    untreatedRisk: 34,
    treatments: [
      TreatmentOption(
        id: 'specialist_care',
        name: 'Specialist care',
        cost: 1600,
        successChance: 0.7,
        ongoingCost: 650,
      ),
    ],
    tags: {'chronic', 'cardiovascular'},
  ),
  IllnessDefinition(
    id: 'unknown_legacy_condition',
    displayName: 'Unspecified Condition',
    severity: IllnessSeverity.moderate,
    chronic: false,
    minimumAge: 0,
    maximumAge: 109,
    yearlyHealthImpact: 4,
    untreatedRisk: 10,
    treatments: [
      TreatmentOption(
        id: 'medical_assessment',
        name: 'Medical assessment',
        cost: 500,
        successChance: 0.65,
      ),
    ],
    tags: {'legacy'},
  ),
];

IllnessDefinition illnessById(String id) => illnessDefinitions.firstWhere(
  (definition) => definition.id == id,
  orElse: () => illnessDefinitions.last,
);

String illnessIdForLegacyName(String name) {
  final normalized = name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
  for (final definition in illnessDefinitions) {
    final definitionName = definition.displayName.toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9]+'),
      '_',
    );
    if (normalized == definition.id || normalized == definitionName) {
      return definition.id;
    }
  }
  return 'unknown_legacy_condition';
}
