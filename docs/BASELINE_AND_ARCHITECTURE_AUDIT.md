# Baseline and Architecture Audit

Date: 26 July 2026

## Baseline

- Flutter 3.41.7 stable; Dart 3.11.5.
- App version: `1.0.0+2`.
- Android application ID and iOS bundle ID: `com.wesleyconsults.ghanalifesim`.
- Android minimum SDK 24, compile/target SDK 36.
- iOS deployment target 15.6 for the Runner target.
- Save storage: Hive, with active and last-valid backup boxes.
- Settings/meta progress: platform-local shared preferences.
- Save schema: version 3.

## Architecture

The presentation layer uses Riverpod state notifiers. Age-up is calculated on a detached character snapshot and saved only after a complete yearly transaction. Domain services mutate the supplied snapshot but do not persist Hive objects directly. Stable year IDs prevent a committed year from being applied twice.

Schema v3 adds typed, JSON-encoded business state, illness state, annual financial transactions, committed year IDs, timed consequences, and pending decision IDs. Migration from legacy parallel arrays is idempotent and preserves unknown illness values through an explicit fallback definition. A pre-migration snapshot is written before migration and restored on failure.

The central `AppFailure` abstraction classifies save, migration, age-up, content-validation, and unexpected failures. Player messages remain generic and exclude diagnostic details.

## Content integrity

Every production event is validated for a stable ID and valid authoring structure. Event selection enforces occurrence limits, cooldowns, required flags, flag age delays, and consequence expiry. Pending decisions persist by stable ID.

## Baseline protection

- Legacy v2 living-save fixture.
- Current v3 living-save fixture.
- Dead save with legacy reward state.
- Corrupted-save fixture.
- Migration idempotency and injected-failure recovery tests.
- Detached-snapshot and duplicate-commit tests.

