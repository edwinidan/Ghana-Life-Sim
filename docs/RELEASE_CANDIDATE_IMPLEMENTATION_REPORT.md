# Release Candidate Implementation Report

Date: 26 July 2026

## Summary

The next-milestone implementation is complete at the local release-candidate level. The game now has schema-v3 typed business and illness state, deterministic annual business and health progression, auditable yearly finances, debt recovery, consequence chains, persisted decisions, transactional age-up protection, migration recovery, expanded tests, a 10,000-life simulator, accessibility preferences, and local Android/iOS RC builds.

No build was uploaded or submitted.

## Gameplay and persistence delivered

- Typed business records with revenue, expenses, profit/loss, growth, staffing, reputation, risk, history, and active/struggling/failed/sold/closed states.
- Expand, hire, reduce operations, borrow, sell, invest, start, and close flows.
- Risk-driven disruption permits profit, stagnation, loss, recovery, and failure.
- Typed acute/chronic illness state, diagnosis, monitoring, treatment, ongoing costs, recovery, worsening, and fatal integration.
- Structured yearly ledger for employment, side gigs, business, education, housing, children, family, healthcare, events, and reconciliation.
- Full Year in Review ledger UI.
- Explicit debt-repayment activity without overpayment.
- Five consequence areas: family support, education sacrifice, risky hustle, betrayal, and family business investment.
- Stable pending-decision IDs and timed consequence expiry/delay.
- Male/Female character choice retained as requested.

## Architecture and migration

- Riverpod remains the presentation state boundary.
- Domain services no longer call Hive persistence.
- Age-up works on a detached snapshot and saves only after a complete commit.
- Duplicate year commits are rejected by stable year ID.
- Save schema is version 3.
- Legacy business arrays and illness strings migrate once to typed records.
- Unknown legacy conditions are preserved safely.
- Active save and last-valid backup are maintained.
- Failed migration restores the pre-migration snapshot.

## Automated validation

- Static analysis: clean.
- Unit/widget suite: 34 tests after final additions.
- Platform-neutral journey suite: 12 journeys.
- Production event-catalog validation: passed.
- Qualified-graduate reachability test covers every major career, including Healthcare.
- Small-phone 200% text and iPad-sized 160% text tests: passed.
- iPhone 17e and iPad mini simulator integration: 12/12 on each.

## Balance simulation

The repeatable harness is `tool/balance_simulation.dart`. The final report is in `build/reports/release_candidate/`.

- Lives: 10,000 across seven strategies.
- Simulated years: 721,581.
- Runtime: 174.576 seconds.
- Average/median death age: 72.16 / 86.
- Ever employed: 54.9%.
- NSS completion: 21.4%.
- Business started: 14.2%; profitable life 13.8%; failure life 0.9%.
- Business loss/stagnation/recovery years all occurred.
- Debt recovery in at least one year: 48.4%; debt at death: 19.5%.
- Stuck lives: 0%.
- Repeated events: 0.
- Male/Female average death-age difference: 0.25 years.
- Largest regional average death-age spread: under 1.7 years.

Healthcare appears only once in mixed autonomous outcomes, despite passing the direct qualified-character reachability test. This is a balance/content-discovery concern for beta observation, not a broken gate.

## Local release artifacts

- Android debug APK: `build/app/outputs/flutter-apk/app-debug.apk`
- Android release APK: `build/app/outputs/flutter-apk/app-release.apk`
- Android release AAB: `build/app/outputs/bundle/release/app-release.aab`
- iOS simulator app: `build/ios/iphonesimulator/Runner.app`
- iOS unsigned release app: `build/ios/iphoneos/Runner.app`
- Balance JSON/Markdown: `build/reports/release_candidate/`

Android release verification confirms package `com.wesleyconsults.ghanalifesim`, version `1.0.0 (2)`, minimum SDK 24, target SDK 36, valid APK v2 signature, and arm64-v8a support. iOS compiles in release mode without code signing at version `1.0.0 (2)`.

Artifact SHA-256:

- Debug APK: `49bff5394867b128829bf7b4fde8d90ad0414dc7dc29be9733609a8dd1b1b292`
- Release APK: `d754e80a62d5c46a60cdca7e3f61da14d5ed8578f15be08f533679b2aee4c7d3`
- Release AAB: `965ed7a14eee1ac53b834f9f7014c90c00e03f193f296a11c22433221ad90daf`

The clean release graph and native outputs contain no `integration_test` or `flutter_driver` runtime plugin.

## Honest readiness assessment

Status: local release candidate built; not store-ready for submission.

Remaining release blockers:

- No Android device/emulator was available for runtime QA.
- Physical iPhone connection did not complete; VoiceOver/device QA remains.
- TalkBack/VoiceOver and low-memory/manual performance passes remain.
- Public privacy-policy and support URLs/email are missing.
- Android Play App Signing/closed-test console work is outside this local task.
- iOS distribution certificate/profile, signed archive, and TestFlight testing remain.
- Final screenshots, metadata, ratings, review notes, and store declarations remain owner/console work.
