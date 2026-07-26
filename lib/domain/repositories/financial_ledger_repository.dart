import '../../models/character.dart';
import '../models/financial_transaction.dart';

class FinancialLedgerRepository {
  const FinancialLedgerRepository();

  List<FinancialTransaction> read(Character character, {int? age}) {
    final transactions = <FinancialTransaction>[];
    for (final record in character.annualLedgerRecords) {
      try {
        final transaction = FinancialTransaction.decode(record);
        if (age == null || transaction.age == age) {
          transactions.add(transaction);
        }
      } catch (_) {
        // A malformed row must not hide the remainder of the ledger.
      }
    }
    return transactions;
  }

  void appendAll(
    Character character,
    Iterable<FinancialTransaction> transactions,
  ) {
    final knownIds = read(character).map((item) => item.id).toSet();
    for (final transaction in transactions) {
      if (knownIds.add(transaction.id)) {
        character.annualLedgerRecords.add(transaction.encode());
      }
    }
  }
}
