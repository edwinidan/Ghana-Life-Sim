import 'dart:math';

import '../../data/businesses.dart';
import '../../models/character.dart';
import '../models/business_state.dart';
import '../models/financial_transaction.dart';
import '../repositories/business_state_repository.dart';

class BusinessAnnualOutcome {
  const BusinessAnnualOutcome({
    required this.business,
    required this.revenue,
    required this.expenses,
    required this.profit,
  });

  final BusinessState business;
  final int revenue;
  final int expenses;
  final int profit;
}

class BusinessYearResult {
  const BusinessYearResult({
    required this.outcomes,
    required this.transactions,
  });

  final List<BusinessAnnualOutcome> outcomes;
  final List<FinancialTransaction> transactions;
}

class BusinessActionResult {
  const BusinessActionResult(this.success, this.message);

  final bool success;
  final String message;
}

class TypedBusinessService {
  const TypedBusinessService({
    this.repository = const BusinessStateRepository(),
  });

  final BusinessStateRepository repository;

  BusinessActionResult expand(Character character, String businessId) {
    const cost = 8000;
    if (character.cash < cost) {
      return const BusinessActionResult(false, 'You need GHS 8,000 to expand.');
    }
    return _update(
      character,
      businessId,
      (business) {
        if (business.growthLevel >= 5) return business;
        character.adjustCash(-cost);
        return business.copyWith(
          growthLevel: (business.growthLevel + 1).clamp(1, 5),
          risk: (business.risk + 5).clamp(0, 100),
        );
      },
      'The business expanded. Growth and operating risk increased.',
    );
  }

  BusinessActionResult hire(Character character, String businessId) =>
      _update(character, businessId, (business) {
        if (character.cash < 3000 || business.staffBand >= 4) return business;
        character.adjustCash(-3000);
        return business.copyWith(
          staffBand: (business.staffBand + 1).clamp(0, 4),
          reputation: (business.reputation + 3).clamp(0, 100),
        );
      }, 'The business increased its staff band.');

  BusinessActionResult reduceOperations(
    Character character,
    String businessId,
  ) => _update(
    character,
    businessId,
    (business) {
      return business.copyWith(
        staffBand: max(0, business.staffBand - 1),
        risk: (business.risk - 8).clamp(0, 100),
        growthLevel: max(1, business.growthLevel - 1),
      );
    },
    'Operations were reduced, lowering both growth and risk.',
  );

  BusinessActionResult borrow(Character character, String businessId) =>
      _update(
        character,
        businessId,
        (business) {
          const amount = 5000;
          character.adjustCash(amount);
          character.adjustDebt(amount);
          return business.copyWith(cashReserve: business.cashReserve + amount);
        },
        'The business borrowed GHS 5,000. Cash and debt both increased.',
      );

  BusinessActionResult sell(Character character, String businessId) => _update(
    character,
    businessId,
    (business) {
      final value = max(
        1000,
        business.cashReserve +
            business.growthLevel * 2500 +
            business.reputation * 40,
      );
      character.adjustCash(value);
      return business.copyWith(status: BusinessStatus.sold);
    },
    'The business was sold and removed from active operations.',
  );

  BusinessYearResult progress(Character character, Random random) {
    final businesses = repository.read(character);
    final updated = <BusinessState>[];
    final outcomes = <BusinessAnnualOutcome>[];
    final transactions = <FinancialTransaction>[];

    for (final business in businesses) {
      if (business.status != BusinessStatus.active &&
          business.status != BusinessStatus.struggling) {
        updated.add(business);
        continue;
      }
      final definition = _definition(business.definitionId);
      final baseRevenue =
          definition?.baseAnnualRevenue ?? max(1200, business.annualRevenue);
      final baseExpenses =
          definition?.baseAnnualExpenses ?? (baseRevenue * 0.65).round();
      final disruption = random.nextInt(100) < business.risk ~/ 5;
      final variance = disruption
          ? 40 + random.nextInt(21)
          : 70 + random.nextInt(56);
      final reputationModifier = 75 + business.reputation ~/ 2;
      final growthModifier = 100 + (business.growthLevel - 1) * 15;
      final revenue =
          baseRevenue *
          variance *
          reputationModifier *
          growthModifier ~/
          1000000;
      final expenses =
          (baseExpenses * (90 + random.nextInt(31)) / 100).round() +
          business.staffBand * 2400;
      final profit = revenue - expenses;
      final cashBefore = character.cash;

      if (profit >= 0) {
        character.adjustCash(profit);
      } else {
        final paid = min(character.cash, -profit);
        character.adjustCash(-paid);
        character.adjustDebt((-profit - paid).clamp(0, 15000));
      }

      final nextRisk = (business.risk + (profit < 0 ? 14 : -3)).clamp(0, 100);
      final failed =
          nextRisk >= 50 && profit < 0 && random.nextInt(100) < nextRisk - 20;
      final nextStatus = failed
          ? BusinessStatus.failed
          : profit < 0
          ? BusinessStatus.struggling
          : BusinessStatus.active;
      final nextGrowth = profit > baseRevenue * 0.25
          ? (business.growthLevel + 1).clamp(1, 5)
          : business.growthLevel;
      final summary = failed
          ? '${business.displayName} could not survive another loss.'
          : profit >= 0
          ? '${business.displayName} finished the year with a profit.'
          : '${business.displayName} made a loss but remains open.';
      final next = business.copyWith(
        growthLevel: nextGrowth,
        reputation: (business.reputation + (profit >= 0 ? 3 : -4)).clamp(
          0,
          100,
        ),
        risk: nextRisk,
        cashReserve: max(0, business.cashReserve + profit ~/ 4),
        annualRevenue: revenue,
        annualExpenses: expenses,
        lastAnnualProfit: profit,
        status: nextStatus,
        history: [
          ...business.history,
          BusinessHistoryEntry(
            age: character.age,
            revenue: revenue,
            expenses: expenses,
            profit: profit,
            summary: summary,
          ),
        ],
      );
      updated.add(next);
      outcomes.add(
        BusinessAnnualOutcome(
          business: next,
          revenue: revenue,
          expenses: expenses,
          profit: profit,
        ),
      );
      transactions.add(
        FinancialTransaction(
          id: 'business-${character.lifeSeed}-${character.age}-${business.id}',
          category: TransactionCategory.businessProfit,
          amount: character.cash - cashBefore,
          age: character.age,
          description: '${business.displayName} annual profit/loss',
          sourceId: business.id,
        ),
      );
      character.lifeLog.insert(
        0,
        'Age ${character.age}: $summary Revenue was GHS $revenue, '
        'expenses were GHS $expenses, and profit/loss was GHS $profit.',
      );
    }

    repository.write(character, updated);
    _syncLegacy(character, updated);
    return BusinessYearResult(outcomes: outcomes, transactions: transactions);
  }

  BusinessType? _definition(String id) {
    for (final definition in allBusinessTypes) {
      if (definition.id == id) return definition;
    }
    return null;
  }

  BusinessActionResult _update(
    Character character,
    String businessId,
    BusinessState Function(BusinessState business) change,
    String message,
  ) {
    final businesses = repository.read(character);
    final index = businesses.indexWhere(
      (business) => business.id == businessId,
    );
    if (index < 0) {
      return const BusinessActionResult(false, 'Business not found.');
    }
    final before = businesses[index];
    final after = change(before);
    if (identical(before, after)) {
      return const BusinessActionResult(
        false,
        'The requirements for that action are not met.',
      );
    }
    businesses[index] = after;
    repository.write(character, businesses);
    _syncLegacy(character, businesses);
    character.lifeLog.insert(0, 'Age ${character.age}: $message');
    return BusinessActionResult(true, message);
  }

  void _syncLegacy(Character character, List<BusinessState> businesses) {
    final active = businesses
        .where(
          (business) =>
              business.status == BusinessStatus.active ||
              business.status == BusinessStatus.struggling,
        )
        .toList();
    character.businessNames = active
        .map((business) => business.displayName)
        .toList();
    character.businessTypes = active
        .map(
          (business) =>
              _definition(business.definitionId)?.name ?? business.definitionId,
        )
        .toList();
    character.businessHealthList = active
        .map((business) => (100 - business.risk).clamp(0, 100))
        .toList();
    character.businessIncomeList = active
        .map((business) => max(0, business.lastAnnualProfit ~/ 12))
        .toList();
    character.totalBusinessIncome = character.businessIncomeList.fold(
      0,
      (sum, income) => sum + income,
    );
  }
}
