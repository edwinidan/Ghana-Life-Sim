import 'dart:convert';

enum BusinessStatus { active, struggling, closed, sold, failed }

class BusinessHistoryEntry {
  const BusinessHistoryEntry({
    required this.age,
    required this.revenue,
    required this.expenses,
    required this.profit,
    required this.summary,
  });

  final int age;
  final int revenue;
  final int expenses;
  final int profit;
  final String summary;

  Map<String, Object> toJson() => {
    'age': age,
    'revenue': revenue,
    'expenses': expenses,
    'profit': profit,
    'summary': summary,
  };

  factory BusinessHistoryEntry.fromJson(Map<String, dynamic> json) =>
      BusinessHistoryEntry(
        age: json['age'] as int? ?? 0,
        revenue: json['revenue'] as int? ?? 0,
        expenses: json['expenses'] as int? ?? 0,
        profit: json['profit'] as int? ?? 0,
        summary: json['summary'] as String? ?? '',
      );
}

class BusinessState {
  const BusinessState({
    required this.id,
    required this.definitionId,
    required this.displayName,
    required this.startedAtAge,
    this.growthLevel = 1,
    this.reputation = 50,
    this.risk = 30,
    this.staffBand = 0,
    this.cashReserve = 0,
    this.annualRevenue = 0,
    this.annualExpenses = 0,
    this.lastAnnualProfit = 0,
    this.status = BusinessStatus.active,
    this.flags = const [],
    this.history = const [],
  });

  final String id;
  final String definitionId;
  final String displayName;
  final int startedAtAge;
  final int growthLevel;
  final int reputation;
  final int risk;
  final int staffBand;
  final int cashReserve;
  final int annualRevenue;
  final int annualExpenses;
  final int lastAnnualProfit;
  final BusinessStatus status;
  final List<String> flags;
  final List<BusinessHistoryEntry> history;

  BusinessState copyWith({
    int? growthLevel,
    int? reputation,
    int? risk,
    int? staffBand,
    int? cashReserve,
    int? annualRevenue,
    int? annualExpenses,
    int? lastAnnualProfit,
    BusinessStatus? status,
    List<String>? flags,
    List<BusinessHistoryEntry>? history,
  }) => BusinessState(
    id: id,
    definitionId: definitionId,
    displayName: displayName,
    startedAtAge: startedAtAge,
    growthLevel: growthLevel ?? this.growthLevel,
    reputation: reputation ?? this.reputation,
    risk: risk ?? this.risk,
    staffBand: staffBand ?? this.staffBand,
    cashReserve: cashReserve ?? this.cashReserve,
    annualRevenue: annualRevenue ?? this.annualRevenue,
    annualExpenses: annualExpenses ?? this.annualExpenses,
    lastAnnualProfit: lastAnnualProfit ?? this.lastAnnualProfit,
    status: status ?? this.status,
    flags: flags ?? this.flags,
    history: history ?? this.history,
  );

  String encode() => jsonEncode({
    'id': id,
    'definitionId': definitionId,
    'displayName': displayName,
    'startedAtAge': startedAtAge,
    'growthLevel': growthLevel,
    'reputation': reputation,
    'risk': risk,
    'staffBand': staffBand,
    'cashReserve': cashReserve,
    'annualRevenue': annualRevenue,
    'annualExpenses': annualExpenses,
    'lastAnnualProfit': lastAnnualProfit,
    'status': status.name,
    'flags': flags,
    'history': history.map((entry) => entry.toJson()).toList(),
  });

  factory BusinessState.decode(String value) {
    final json = jsonDecode(value) as Map<String, dynamic>;
    return BusinessState(
      id: json['id'] as String? ?? '',
      definitionId: json['definitionId'] as String? ?? 'unknown',
      displayName: json['displayName'] as String? ?? 'Business',
      startedAtAge: json['startedAtAge'] as int? ?? 18,
      growthLevel: json['growthLevel'] as int? ?? 1,
      reputation: json['reputation'] as int? ?? 50,
      risk: json['risk'] as int? ?? 30,
      staffBand: json['staffBand'] as int? ?? 0,
      cashReserve: json['cashReserve'] as int? ?? 0,
      annualRevenue: json['annualRevenue'] as int? ?? 0,
      annualExpenses: json['annualExpenses'] as int? ?? 0,
      lastAnnualProfit: json['lastAnnualProfit'] as int? ?? 0,
      status: BusinessStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => BusinessStatus.active,
      ),
      flags: (json['flags'] as List<dynamic>? ?? const []).cast<String>(),
      history: (json['history'] as List<dynamic>? ?? const [])
          .map(
            (entry) =>
                BusinessHistoryEntry.fromJson(entry as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
