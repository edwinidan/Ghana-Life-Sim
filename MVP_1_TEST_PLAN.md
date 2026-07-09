# Ghana Life Sim MVP 1 Test Plan

Created: 2026-07-09

## Automated Test Commands

Run before every MVP release candidate:

```sh
flutter pub get
flutter test
flutter analyze
```

## Automated Coverage Added

Current automated tests cover:

- Character creation creates a valid character.
- Basic age-up state changes do not crash.
- Event choices apply stat, cash, debt, flag, relationship, and housing changes.
- Character cash, debt, flags, children, family, action energy, and ribbons work.
- Activities consume action energy on success and preserve energy on failure.
- Life goal completion and rotation work.
- Achievement/meta-progress recording does not crash.
- Death state, life score, ribbon, and restart/new-life basics work.
- Save/load/delete cycle works through Hive.

## Manual Smoke Test

Run these on Android and iOS before store testing:

1. Fresh install opens onboarding or character creation.
2. Create a new character.
3. Confirm dashboard shows age, stats, cash, debt, goal, activity energy, and life log.
4. Age up five times and choose event outcomes.
5. Use at least three activities.
6. Enter school path and confirm progression.
7. Enter job/career path and confirm income.
8. Try side gigs.
9. Start a relationship, then test breakup/marriage/divorce path if available.
10. Have or track children if event path allows.
11. Rent or buy housing if affordable.
12. Start a business if affordable.
13. Force or naturally reach death.
14. Confirm death screen shows score, rating, ribbon, legacy text, and unlocks.
15. Restart and confirm a new life begins cleanly.
16. Kill and reopen the app to confirm save/load.

## Path Tests

- New life from age 0 to death
- Teen school path
- University/career path
- Debt-heavy path
- Relationship/marriage path
- Business path
- Low-health/death path
- Restart after death

## Device Matrix

Minimum before public testing:

- Android emulator, recent API
- Android physical device
- iPhone simulator
- iPhone physical device if available

## Pass Criteria

- No crashes during the first 15 minutes of play.
- No broken navigation.
- No obvious UI overflow on common phone sizes.
- Save/load works after app restart.
- Death/restart works.
- `flutter analyze` returns no issues.
- `flutter test` passes.

## Known Gaps

- No full integration test simulates an entire random life yet.
- No golden/screenshot tests for UI overflow.
- No automated Android/iOS release build check in CI.
- No automated persistence migration test for older saves.
