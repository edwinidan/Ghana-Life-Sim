import 'dart:convert';

enum TimelineEntryType {
  birth,
  story,
  decision,
  outcome,
  milestone,
  finance,
  health,
  death,
}

class TimelineDelta {
  const TimelineDelta({
    required this.label,
    required this.amount,
    this.isCurrency = false,
  });

  final String label;
  final int amount;
  final bool isCurrency;

  Map<String, Object> toJson() => {
    'label': label,
    'amount': amount,
    'isCurrency': isCurrency,
  };

  factory TimelineDelta.fromJson(Map<String, dynamic> json) => TimelineDelta(
    label: json['label'] as String? ?? '',
    amount: json['amount'] as int? ?? 0,
    isCurrency: json['isCurrency'] as bool? ?? false,
  );
}

class TimelineEntry {
  const TimelineEntry({
    required this.id,
    required this.age,
    required this.type,
    required this.title,
    required this.body,
    this.deltas = const [],
    this.sourceEventId,
    this.isImportant = false,
  });

  final String id;
  final int age;
  final TimelineEntryType type;
  final String title;
  final String body;
  final List<TimelineDelta> deltas;
  final String? sourceEventId;
  final bool isImportant;

  String encode() => jsonEncode({
    'id': id,
    'age': age,
    'type': type.name,
    'title': title,
    'body': body,
    'deltas': deltas.map((delta) => delta.toJson()).toList(),
    'sourceEventId': sourceEventId,
    'isImportant': isImportant,
  });

  factory TimelineEntry.decode(String value) {
    final json = jsonDecode(value) as Map<String, dynamic>;
    return TimelineEntry(
      id: json['id'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      type: TimelineEntryType.values.firstWhere(
        (type) => type.name == json['type'],
        orElse: () => TimelineEntryType.story,
      ),
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      deltas: (json['deltas'] as List<dynamic>? ?? const [])
          .map((delta) => TimelineDelta.fromJson(delta as Map<String, dynamic>))
          .toList(),
      sourceEventId: json['sourceEventId'] as String?,
      isImportant: json['isImportant'] as bool? ?? false,
    );
  }
}
