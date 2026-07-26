import 'dart:convert';

enum TransactionCategory {
  employmentIncome,
  sideGigIncome,
  businessProfit,
  housing,
  education,
  children,
  family,
  healthcare,
  debtInterest,
  loan,
  event,
  other,
}

class FinancialTransaction {
  const FinancialTransaction({
    required this.id,
    required this.category,
    required this.amount,
    required this.age,
    required this.description,
    this.sourceId,
  });

  final String id;
  final TransactionCategory category;
  final int amount;
  final int age;
  final String description;
  final String? sourceId;

  String encode() => jsonEncode({
    'id': id,
    'category': category.name,
    'amount': amount,
    'age': age,
    'description': description,
    'sourceId': sourceId,
  });

  factory FinancialTransaction.decode(String value) {
    final json = jsonDecode(value) as Map<String, dynamic>;
    return FinancialTransaction(
      id: json['id'] as String? ?? '',
      category: TransactionCategory.values.firstWhere(
        (category) => category.name == json['category'],
        orElse: () => TransactionCategory.other,
      ),
      amount: json['amount'] as int? ?? 0,
      age: json['age'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      sourceId: json['sourceId'] as String?,
    );
  }
}
