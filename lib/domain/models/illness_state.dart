import 'dart:convert';

enum IllnessSeverity { mild, moderate, severe, critical }

enum TreatmentStatus { untreated, monitoring, medication, treated }

class IllnessHistoryEntry {
  const IllnessHistoryEntry({
    required this.age,
    required this.action,
    required this.summary,
  });

  final int age;
  final String action;
  final String summary;

  Map<String, Object> toJson() => {
    'age': age,
    'action': action,
    'summary': summary,
  };

  factory IllnessHistoryEntry.fromJson(Map<String, dynamic> json) =>
      IllnessHistoryEntry(
        age: json['age'] as int? ?? 0,
        action: json['action'] as String? ?? '',
        summary: json['summary'] as String? ?? '',
      );
}

class ActiveIllnessState {
  const ActiveIllnessState({
    required this.id,
    required this.illnessDefinitionId,
    required this.diagnosedAtAge,
    this.yearsActive = 0,
    this.treatmentStatus = TreatmentStatus.untreated,
    this.severityModifier = 0,
    this.resolved = false,
    this.history = const [],
  });

  final String id;
  final String illnessDefinitionId;
  final int diagnosedAtAge;
  final int yearsActive;
  final TreatmentStatus treatmentStatus;
  final int severityModifier;
  final bool resolved;
  final List<IllnessHistoryEntry> history;

  ActiveIllnessState copyWith({
    int? yearsActive,
    TreatmentStatus? treatmentStatus,
    int? severityModifier,
    bool? resolved,
    List<IllnessHistoryEntry>? history,
  }) => ActiveIllnessState(
    id: id,
    illnessDefinitionId: illnessDefinitionId,
    diagnosedAtAge: diagnosedAtAge,
    yearsActive: yearsActive ?? this.yearsActive,
    treatmentStatus: treatmentStatus ?? this.treatmentStatus,
    severityModifier: severityModifier ?? this.severityModifier,
    resolved: resolved ?? this.resolved,
    history: history ?? this.history,
  );

  String encode() => jsonEncode({
    'id': id,
    'illnessDefinitionId': illnessDefinitionId,
    'diagnosedAtAge': diagnosedAtAge,
    'yearsActive': yearsActive,
    'treatmentStatus': treatmentStatus.name,
    'severityModifier': severityModifier,
    'resolved': resolved,
    'history': history.map((entry) => entry.toJson()).toList(),
  });

  factory ActiveIllnessState.decode(String value) {
    final json = jsonDecode(value) as Map<String, dynamic>;
    return ActiveIllnessState(
      id: json['id'] as String? ?? '',
      illnessDefinitionId:
          json['illnessDefinitionId'] as String? ?? 'unknown_legacy_condition',
      diagnosedAtAge: json['diagnosedAtAge'] as int? ?? 0,
      yearsActive: json['yearsActive'] as int? ?? 0,
      treatmentStatus: TreatmentStatus.values.firstWhere(
        (status) => status.name == json['treatmentStatus'],
        orElse: () => TreatmentStatus.untreated,
      ),
      severityModifier: json['severityModifier'] as int? ?? 0,
      resolved: json['resolved'] as bool? ?? false,
      history: (json['history'] as List<dynamic>? ?? const [])
          .map(
            (entry) =>
                IllnessHistoryEntry.fromJson(entry as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
