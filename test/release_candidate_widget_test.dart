import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghana_life_sim/app/theme/app_theme.dart';
import 'package:ghana_life_sim/data/migrations/save_migrator.dart';
import 'package:ghana_life_sim/domain/models/financial_transaction.dart';
import 'package:ghana_life_sim/domain/models/illness_state.dart';
import 'package:ghana_life_sim/domain/models/timeline_entry.dart';
import 'package:ghana_life_sim/domain/repositories/timeline_repository.dart';
import 'package:ghana_life_sim/models/character.dart';
import 'package:ghana_life_sim/screens/character_creation_screen.dart';
import 'package:ghana_life_sim/screens/health_screen.dart';
import 'package:ghana_life_sim/screens/home_screen.dart';
import 'package:ghana_life_sim/screens/life_screen.dart';

void main() {
  Widget app(Widget child, {double textScale = 1}) => ProviderScope(
    child: MaterialApp(
      theme: AppTheme.light,
      home: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
        child: child,
      ),
    ),
  );

  testWidgets('character creation explains missing name', (tester) async {
    await tester.pumpWidget(app(const CharacterCreationScreen()));

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Begin Your Life'));
    await tester.pump();

    expect(find.text('Enter your name first.'), findsOneWidget);
  });

  testWidgets('returning-player home exposes continue and safe new life', (
    tester,
  ) async {
    final character = Character(name: 'Akua', gender: 'Female')..age = 24;
    await tester.pumpWidget(app(HomeScreen(character: character)));

    expect(find.text('Continue Akua’s Life'), findsOneWidget);
    expect(find.text('Continue Life'), findsOneWidget);
    expect(find.text('New Life'), findsOneWidget);
  });

  testWidgets('timeline and primary destinations render at large text', (
    tester,
  ) async {
    final character = Character(name: 'Kojo', gender: 'Male')..age = 19;
    SaveMigrator(const TimelineRepository()).migrate(character);
    await tester.pumpWidget(
      app(LifeScreen(character: character), textScale: 1.6),
    );

    expect(find.text('Your life'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Age up one year')), findsOneWidget);

    await tester.tap(find.text('People'));
    await tester.pumpAndSettle();
    expect(find.text('The relationships shaping your story.'), findsOneWidget);

    await tester.tap(find.text('Activities'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Time This Year:'), findsOneWidget);

    await tester.tap(find.text('Assets'));
    await tester.pumpAndSettle();
    expect(find.text('WORK & INCOME'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('small phone remains usable at 200 percent text', (tester) async {
    tester.view.physicalSize = const Size(640, 1136);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final character = Character(name: 'Small', gender: 'Female')..age = 30;
    SaveMigrator(const TimelineRepository()).migrate(character);

    await tester.pumpWidget(
      app(LifeScreen(character: character), textScale: 2),
    );
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel(RegExp('Age up one year')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('iPad-sized layout renders without overflow', (tester) async {
    tester.view.physicalSize = const Size(2048, 2732);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final character = Character(name: 'Tablet', gender: 'Male')..age = 40;
    SaveMigrator(const TimelineRepository()).migrate(character);

    await tester.pumpWidget(
      app(LifeScreen(character: character), textScale: 1.6),
    );
    await tester.tap(find.text('Assets'));
    await tester.pumpAndSettle();

    expect(find.text('WORK & INCOME'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Year in Review opens itemized ledger', (tester) async {
    final character = Character(name: 'Esi', gender: 'Female')
      ..age = 22
      ..timelineRecords = [
        const TimelineEntry(
          id: 'finance',
          age: 22,
          type: TimelineEntryType.finance,
          title: 'Year in Review',
          body: 'Income GHS 1000 · Expenses GHS 200',
        ).encode(),
      ]
      ..annualLedgerRecords = [
        const FinancialTransaction(
          id: 'income',
          category: TransactionCategory.employmentIncome,
          amount: 1000,
          age: 22,
          description: 'Employment income',
        ).encode(),
        const FinancialTransaction(
          id: 'rent',
          category: TransactionCategory.housing,
          amount: -200,
          age: 22,
          description: 'Housing costs',
        ).encode(),
      ];
    await tester.pumpWidget(app(LifeScreen(character: character)));

    await tester.tap(find.text('View full yearly ledger'));
    await tester.pumpAndSettle();

    expect(find.text('Age 22 · Year in Review'), findsOneWidget);
    expect(find.text('Employment income'), findsOneWidget);
    expect(find.text('Net cash change'), findsOneWidget);
  });

  testWidgets('health screen distinguishes active typed condition', (
    tester,
  ) async {
    final character = Character(name: 'Yaw', gender: 'Male')
      ..age = 48
      ..illnessStateRecords = [
        const ActiveIllnessState(
          id: 'condition',
          illnessDefinitionId: 'hypertension',
          diagnosedAtAge: 46,
        ).encode(),
      ];
    await tester.pumpWidget(
      app(HealthScreen(character: character, onCharacterUpdated: () {})),
    );

    expect(find.text('Hypertension'), findsOneWidget);
    expect(find.text('Chronic'), findsOneWidget);
    expect(find.textContaining('Medication and monitoring'), findsOneWidget);
  });
}
