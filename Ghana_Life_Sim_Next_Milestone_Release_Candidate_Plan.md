---
title: "Ghana Life Sim"
subtitle: "Next Milestone — System Depth, Quality Assurance, Balance, and Release-Candidate Plan"
author: "Wesley Consults"
date: "26 July 2026"
status: "Implementation-ready"
platforms: "Android and iOS"
framework: "Flutter / Dart / Riverpod"
---

# Ghana Life Sim — Next Milestone Implementation Plan

## 1. Purpose

This document defines the next implementation milestone after the first major Ghana Life Sim rebuild.

The previous milestone reportedly completed:

- Riverpod architecture.
- A deterministic, transactional age-up engine.
- Timeline-first Life UI.
- People, Activities, Assets, and central Age navigation.
- Returning-player home.
- Simplified onboarding.
- Redesigned character creation.
- Birth regions and birth reveal.
- Versioned save migration, backup, and recovery.
- Stable event IDs, cooldowns, occurrence limits, catalogue validation, and consequence history.
- Expanded education, including TVET, apprenticeships, training colleges, technical university, and NSS.
- Family ageing, deaths, funerals, and child milestones.
- Original Ghana-themed design system and accessibility semantics.
- Removal of forced death at age 90.
- A clean analyzer run, 17 passing tests, and an Android debug APK.

The next milestone must **not rebuild those areas from scratch**. It must verify them, preserve them, and complete the remaining work required for a credible release candidate.

The central objective is:

> Finish the simulation depth and quality work needed to make Ghana Life Sim stable, balanced, accessible, testable, and ready for closed testing and TestFlight preparation.

This milestone ends with release-candidate builds and a complete readiness report. It does **not** include uploading, submitting, or publishing the app.

---

# 2. Non-Negotiable Rules

1. Inspect the current repository before changing code. Do not assume every item in the milestone report is fully implemented merely because it is listed.
2. Preserve existing unrelated worktree changes.
3. Do not reset, delete, overwrite, or rewrite working systems without evidence that a change is required.
4. Maintain deterministic simulation behaviour in tests.
5. Every persisted model change must have a versioned migration, default values, backup protection, and migration tests.
6. No transaction may be applied twice after a crash, process death, retry, or app restart.
7. Do not reintroduce an age-90 forced death.
8. Do not add a backend, account system, cloud sync, advertising, analytics SDK, or in-app purchase SDK during this milestone unless already present and explicitly required for compatibility.
9. Do not copy BitLife artwork, copy, icons, layout measurements, branding, or trade dress.
10. Keep Ghana Life Sim visually and culturally original.
11. Do not upload builds to Google Play Console, App Store Connect, TestFlight, or any production service.
12. Do not expose developer shortcuts, simulation controls, seeds, debug menus, test ads, or internal diagnostics in release builds.

---

# 3. Milestone Scope

This milestone contains seven connected workstreams:

1. Repository audit and baseline protection.
2. Typed business and illness models with safe migration.
3. Business, illness, finance, and consequence depth.
4. Wider automated testing and deterministic balance simulation.
5. Accessibility, device, performance, and recovery QA.
6. Android and iOS release-candidate preparation.
7. Final implementation and readiness report.

## 3.1 Explicitly postponed

Do not add these unless required to repair an existing flow:

- Deep crime and prison.
- Politics or chieftaincy.
- International migration or travel.
- Cars, land, investment portfolios, wills, or inheritance depth.
- Playable descendants.
- Detailed independent adult lives for all relatives.
- Cloud accounts or leaderboards.
- Large celebrity or social-media systems.
- Monetization integration.
- Major visual redesign of the newly completed timeline interface.

---

# 4. Workstream 1 — Audit and Protect the Current Build

## 4.1 Repository audit

Before implementation, inspect and document:

- Current branch and worktree state.
- Current application version and build number.
- Flutter and Dart versions.
- Android namespace and application ID.
- iOS bundle identifier.
- Current Riverpod provider/controller structure.
- Current age-up transaction boundaries.
- Current save schema version.
- Existing migration versions and fixtures.
- Existing event ID and occurrence-history implementation.
- Current typed and legacy models.
- Current business model.
- Current illness model.
- Current finance transaction representation.
- Current accessibility semantics.
- Existing unit, widget, and integration tests.
- Existing release-signing configuration without exposing secrets.

## 4.2 Baseline validation

Run at minimum:

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

Also build and run the app on at least one available Android target before modifying code.

If iOS tooling is available, run:

```bash
flutter build ios --simulator
```

Record all results before making changes.

## 4.3 Baseline protection

Create or confirm:

- Golden migration fixtures for at least one pre-rebuild save.
- A fixture for the current save schema.
- A save containing a living character with education, family, money, debt, business, illness, and consequence history.
- A save containing a dead character with recorded legacy rewards.
- A corruption fixture that must recover from backup or fail safely.
- A deterministic seed fixture for a known age-up result.

### Exit criteria

- The existing build remains reproducible.
- Existing tests pass before feature work begins.
- Baseline save fixtures exist.
- The report identifies exactly which remaining requirements are already complete, partial, missing, or obsolete.

---

# 5. Workstream 2 — Typed Persistent Models and Safe Migration

## 5.1 Goal

Replace fragile or shallow business and illness persistence with typed, extensible models while preserving all valid existing saves.

Do not migrate data merely for aesthetic architecture reasons. Migrate only where it improves correctness, depth, maintainability, or testing.

## 5.2 Typed business model

Introduce a typed business state model. Adapt naming to the repository conventions, but it should support at least:

```dart
class BusinessState {
  final String id;
  final String definitionId;
  final String displayName;
  final BusinessType type;
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
}
```

The exact storage approach may use Hive adapters, serializable immutable models, or the repository's current persistence pattern. The model must have:

- Stable instance ID.
- Stable business-definition ID.
- Explicit status.
- Revenue and expense history.
- Growth level.
- Reputation.
- Risk.
- Staff-size band.
- Flags and event history.
- Backward-compatible defaults.

Do not continue storing business state only through parallel arrays.

## 5.3 Typed illness model

Introduce a typed active-condition model and a separate static illness definition.

Suggested static definition:

```dart
class IllnessDefinition {
  final String id;
  final String displayName;
  final IllnessSeverity severity;
  final bool chronic;
  final int minimumAge;
  final int maximumAge;
  final int yearlyHealthImpact;
  final int untreatedRisk;
  final List<TreatmentOption> treatments;
  final Set<String> tags;
}
```

Suggested active state:

```dart
class ActiveIllnessState {
  final String id;
  final String illnessDefinitionId;
  final int diagnosedAtAge;
  final int yearsActive;
  final TreatmentStatus treatmentStatus;
  final int severityModifier;
  final bool resolved;
  final List<IllnessHistoryEntry> history;
}
```

The model must support:

- Acute and chronic conditions.
- Diagnosis age.
- Duration.
- Treatment state.
- Treatment affordability.
- Recovery.
- Worsening.
- Death-risk contribution.
- Event tags and history.

Do not continue storing active illnesses only as display-name strings.

## 5.4 Migration requirements

Implement a new save-schema version only after inspecting the existing migration framework.

The migration must:

- Convert every legacy business into a typed business state.
- Convert every legacy illness string into a valid typed active condition.
- Preserve business names, types, health-equivalent information, income, and status as closely as possible.
- Preserve unknown legacy illness values through an `unknown_legacy_condition` fallback rather than silently deleting them.
- Be idempotent.
- Never rerun a completed migration.
- Create a verified backup before mutation.
- Restore the last valid backup when migration fails.
- Provide a safe, understandable reset path only when recovery is impossible.
- Never duplicate businesses, conditions, money, rewards, children, or timeline entries.

## 5.5 Migration tests

Required tests:

1. Empty legacy save migrates.
2. Save with one business migrates.
3. Save with several businesses migrates.
4. Save with one illness migrates.
5. Save with several illnesses migrates.
6. Unknown illness string migrates to a safe fallback.
7. Already migrated save remains unchanged.
8. Migration interruption recovers from backup.
9. Corrupted current save restores a valid backup.
10. Repeated load does not duplicate migrated entities.

### Exit criteria

- Businesses and active illnesses are typed.
- Existing valid save fixtures migrate without data loss.
- Failed migration cannot destroy the only valid save.
- Migration tests pass deterministically.

---

# 6. Workstream 3 — Business Simulation Depth

## 6.1 Goal

Make businesses understandable and meaningful without turning the game into a complex accounting simulator.

The player should be able to answer:

- Is my business profitable?
- Why did it gain or lose money?
- What is putting it at risk?
- What can I do to improve it?
- How has it changed over time?

## 6.2 Annual business outcome

Replace health-only payout logic with an annual outcome model containing:

- Revenue.
- Operating expenses.
- Staff cost band.
- Rent or operating-location cost where relevant.
- Debt repayment or financing cost where relevant.
- Event modifiers.
- Reputation modifier.
- Risk modifier.
- Net profit or loss.
- Growth or decline result.

Store the annual result in business history and the Year in Review.

The formula must be deterministic when supplied with a deterministic random seed.

## 6.3 Business definitions

Every business definition should include:

- Stable definition ID.
- Name.
- Category.
- Startup cost.
- Minimum age.
- Required or recommended stats.
- Base revenue range.
- Base expense range.
- Risk profile.
- Growth thresholds.
- Relevant event tags.

Retain existing Ghanaian business types where appropriate, including examples such as:

- Chop bar.
- Barbershop or salon.
- Poultry farm.
- Clothing or fashion business.
- Provisions shop.
- Transport business.

## 6.4 Business actions

Support at least:

- Start business.
- Invest.
- Borrow where the economy model permits it.
- Expand.
- Hire or increase staff band.
- Reduce operations.
- Close or sell.

Actions must show:

- Cost.
- Requirements.
- Likely effect.
- Confirmation for destructive actions.
- Result feedback.

## 6.5 Business events

Add or verify event support for:

- Inspections.
- Competition.
- Theft.
- Supply shortages.
- Utility disruptions.
- Customer trends.
- Family assistance or interference.
- Employee problems.
- Expansion opportunities.

Use stable event IDs, cooldowns, occurrence limits, and consequence flags.

## 6.6 Balance protections

- Passive businesses must not guarantee wealth.
- Failed businesses must not always cause unrecoverable debt.
- High-risk businesses may produce higher variance.
- Startup costs and profits must be configurable.
- Business profitability must be included in simulation reports.

### Exit criteria

- Annual business outcomes show revenue, expenses, and profit/loss.
- Business actions affect typed state.
- At least one business can grow, struggle, recover, and fail.
- Business logic has deterministic unit and integration tests.

---

# 7. Workstream 4 — Illness, Treatment, Ageing, and Death Depth

## 7.1 Goal

Move health beyond basic age decay while keeping the system readable and respectful.

## 7.2 Health progression

Health changes should account for:

- Baseline age effects.
- Existing active conditions.
- Treatment status.
- Lifestyle and relevant activities.
- Healthcare affordability.
- Recovery probability.
- Chronic-condition progression.
- Rare accidents or severe events.

## 7.3 Treatment flow

For each eligible condition, support one or more treatment options such as:

- Clinic or hospital visit.
- Medication.
- Procedure or specialist care where appropriate.
- Rest or monitoring where clinically appropriate within the fictional simulation.

This is a game system, not medical advice. Avoid presenting fictional outcomes as real health guidance.

Every treatment option should define:

- Cost.
- Eligibility.
- Success or improvement probability.
- Possible failure.
- Ongoing cost for chronic conditions.

## 7.4 Illness outcomes

Conditions may:

- Resolve.
- Improve.
- Remain stable.
- Worsen.
- Become chronic.
- Contribute to death.

The timeline must clearly show diagnosis, treatment, change, and resolution.

## 7.5 Death integration

Death should result from simulation state rather than an arbitrary age cutoff.

Ensure:

- Age increases risk but does not force death at age 90.
- Active illnesses can influence cause of death.
- Accidents and rare events remain possible.
- The cause of death is stable and explainable.
- Death transactions and legacy rewards are idempotent.

## 7.6 Family health integration

Do not build a full medical simulation for relatives. Use a lightweight model sufficient for:

- Family illness events.
- Family death.
- Funeral contributions.
- Grief effects.
- Follow-up family conflict or support events.

### Exit criteria

- At least acute, chronic, treated, untreated, recovered, and fatal paths are testable.
- Illness state persists safely.
- Treatment and annual progression are deterministic in tests.
- Death and legacy rewards cannot be applied twice.

---

# 8. Workstream 5 — Year in Review and Financial Clarity

## 8.1 Goal

After every completed age-up, the player should understand what happened to their life and money during that year.

## 8.2 Annual transaction ledger

Introduce or verify a structured yearly transaction ledger containing:

- Employment income.
- Side-gig income.
- Business revenue and profit/loss.
- Housing costs.
- School fees.
- Child support and family support.
- Healthcare and treatment.
- Debt interest.
- Loan proceeds and repayments.
- Event costs and rewards.
- Other categorized transactions.

Every transaction should have:

- Stable ID.
- Category.
- Signed amount.
- Age/year.
- Source entity or event ID where applicable.
- Player-facing description.

## 8.3 Year in Review UI

At the end of age-up, provide an expandable summary showing:

- Major events.
- Stat changes.
- Relationship changes.
- Education or career changes.
- Family milestones.
- Business outcomes.
- Income.
- Expenses.
- Debt movement.
- Net cash change.

The summary must not become a blocking multi-page interruption every year. Use a concise default state with expandable details.

## 8.4 Currency formatting

Use consistent Ghana cedi formatting:

- `GHS 1,000`
- `GHS 12,500`
- `-GHS 450`

Use compact forms only where space is limited, and show the full value in details.

## 8.5 Transaction safety

The annual ledger must be part of the transactional age-up result.

If age-up fails or the app closes:

- Either the complete year commits once, or no part of the year commits.
- The ledger, balance, stats, timeline, family, business, and event history must remain synchronized.

### Exit criteria

- Every annual cash change can be explained.
- Net change equals the sum of ledger transactions.
- Retry/restart cannot duplicate an annual transaction.
- Year in Review has widget and integration tests.

---

# 9. Workstream 6 — Finish Simulation Cohesion

Audit the following requirements and implement only those still incomplete.

## 9.1 Event chains

Verify that the consequence framework supports:

- A choice setting one or more consequence flags.
- Follow-up events after a minimum delay.
- Expiring consequences.
- Blocked consequences.
- Maximum occurrence counts.
- Chain history visible in diagnostics and tests.

Add at least five complete multi-step chains across different life areas, such as:

- Education decision and later career consequence.
- Family support decision and later family response.
- Risky hustle and later legal/reputation consequence.
- Relationship betrayal and later exposure/reconciliation.
- Business decision and later growth/failure consequence.

## 9.2 Life-stage feature introduction

Verify that features unlock when relevant:

- Early childhood focuses on family and development.
- School systems appear at school age.
- Work, housing, romance, and business appear only when relevant.
- Locked actions clearly explain requirements.

## 9.3 Activities and time allowance

Verify that the activity system:

- Is understandable.
- Does not encourage repetitive tapping without meaningful trade-offs.
- Uses a clear annual or stage-appropriate allowance.
- Shows cost and expected direction of effect.
- Prevents duplicate transaction application.

## 9.4 Stat clarity

Verify that the main interface presents a small number of primary stats and places secondary traits in details.

Ensure the 0–100 `money` concept is renamed or clearly presented as **Financial Stability** so it is not confused with spendable `cash`.

### Exit criteria

- Choices create visible immediate and delayed consequences.
- Features appear at relevant life stages.
- Activities are meaningful rather than spam-driven.
- Cash and Financial Stability are clearly distinct.

---

# 10. Workstream 7 — Automated Test Expansion

## 10.1 Testing principle

Do not chase a cosmetic coverage percentage. Protect every critical simulation rule, transaction boundary, migration, and user journey.

## 10.2 Required unit tests

Add or verify tests for:

- Stat clamping.
- Cash and debt calculations.
- Annual transaction ledger equality.
- Debt interest and repayment.
- School eligibility, fees, examinations, progression, graduation, and NSS.
- Job eligibility, applications, salary, promotion, dismissal, and retirement where supported.
- Relationship state transitions.
- Family ageing and death.
- Child milestones.
- Business revenue, expenses, profit/loss, growth, decline, and failure.
- Illness diagnosis, treatment, recovery, chronic progression, worsening, and fatal contribution.
- Life goals.
- Death cause and life score.
- Event requirements and blockers.
- Event weights, cooldowns, chains, and duplicate prevention.
- Deterministic random seeds.
- Save migrations.
- Backup recovery.
- Reward idempotency.
- Age-up transaction rollback.

## 10.3 Required widget tests

Add or verify:

- Character creation validation.
- Birth reveal.
- Returning-player home.
- Timeline rendering.
- Year in Review collapsed and expanded states.
- Choice actions and result feedback.
- People, Activities, and Assets navigation.
- Business details and actions.
- Illness and treatment UI.
- Empty states.
- Locked-state explanations.
- Destructive-action confirmations.
- Death screen.
- Large-text layouts.
- Privacy and support links when added.

## 10.4 Required integration tests

Implement end-to-end flows for:

1. New install → character creation → birth reveal → first age-up → save → relaunch → continue.
2. Childhood → school enrolment → examination → next education path.
3. Tertiary or TVET path → completion → NSS or work.
4. Job application → employment → annual income → promotion.
5. Dating → engagement → marriage → child.
6. Debt → interest → repayment or recovery.
7. Business start → annual outcome → investment → growth or failure → closure.
8. Illness → treatment → recovery.
9. Illness → worsening → death.
10. Death → legacy reward → new life → no duplicated reward.
11. Legacy save → migration → continued gameplay.
12. App process termination during age-up → restart → no duplication or corruption.

## 10.5 Test reliability

- All simulation tests must accept an explicit seed.
- Do not use real time where a fake clock can be injected.
- Do not depend on test execution order.
- Avoid arbitrary delays.
- Flaky tests count as failures and must be fixed or removed with documented replacement coverage.

### Exit criteria

- Critical systems have direct tests.
- Required integration journeys pass.
- Test suite is deterministic across repeated runs.
- No known flaky test remains.

---

# 11. Workstream 8 — Headless Balance Simulation

## 11.1 Goal

Run enough deterministic simulated lives to identify broken progression and economy problems before real-user beta testing.

## 11.2 Simulation harness

Create a headless simulation runner that can:

- Generate a character from a seed.
- Select actions using configurable strategies.
- Age the character until death or a safety cap.
- Record outcomes without rendering widgets.
- Export summarized JSON and Markdown or CSV reports.

## 11.3 Required strategies

Include at least:

- Random valid-choice strategy.
- Education-focused strategy.
- Career-focused strategy.
- Business-focused strategy.
- Family-focused strategy.
- High-risk or hustle-focused strategy.
- Low-action/passive strategy.

## 11.4 Minimum run

Run at least **10,000 deterministic lives** across mixed strategies and seeds, provided the harness can do so within reasonable local execution time.

If 10,000 is impractical, optimize the harness rather than lowering the target without explanation.

## 11.5 Required reports

Report:

- Average and median age at death.
- Death-age distribution.
- Causes of death.
- Education outcomes.
- Career reachability.
- NSS reachability and completion.
- Employment and unemployment rates by life stage.
- Cash and debt distribution at major ages.
- Business start, profitability, growth, and failure rates.
- Marriage and child outcomes.
- Event frequency.
- Event repetition.
- Chain completion and starvation.
- Stat distributions.
- Region and gender outcome differences.
- Percentage of lives stuck without valid progression.
- Guaranteed-wealth or unavoidable-debt patterns.

## 11.6 Balance acceptance targets

Do not hard-code arbitrary equality into the simulation. Instead verify that:

- At least five distinct life paths are viable.
- No major career path is effectively unreachable.
- No normal strategy guarantees wealth.
- Debt is recoverable in a meaningful portion of lives.
- Business can produce success, stagnation, recovery, and failure.
- Event repetition is within defined limits.
- No region or gender difference appears accidentally due to broken gating or missing content.
- A full life can complete without invalid state.

Every intentional outcome difference must be documented.

### Exit criteria

- The simulation harness is committed and repeatable.
- At least one full report is generated.
- Critical outliers are fixed or documented.
- Final tuning values are config-driven.

---

# 12. Workstream 9 — Accessibility and Device QA

## 12.1 Automated accessibility checks

Where practical, add tests for:

- Semantic labels on icon-only controls.
- Semantic headings for age entries.
- Button roles and enabled/disabled states.
- Text scaling.
- Minimum tappable areas.
- Colour-independent positive and negative feedback.

## 12.2 Manual accessibility audit

Test:

- Android TalkBack.
- iOS VoiceOver when an iOS device or simulator is available.
- Text scale at 100%, 130%, 160%, and 200%.
- Logical focus order.
- Dialog focus capture and return.
- Timeline navigation by age heading.
- Reduced-motion behaviour.
- Screen orientation policy.
- Contrast and non-colour status indicators.

## 12.3 Device matrix

Test at minimum on available equivalents of:

- Small Android phone.
- Low-memory or lower-performance Android device/emulator.
- Mid-range Android phone.
- Recent Samsung phone.
- Current Pixel/API emulator.
- 64-bit-only Android environment.
- Small iPhone simulator.
- Standard modern iPhone simulator/device.
- Large iPhone simulator/device.
- iPad only if iPad distribution remains enabled.

## 12.4 Layout requirements

Verify:

- No horizontal clipping.
- No inaccessible controls behind safe areas.
- No overflow at large text.
- Timeline remains readable in long lives.
- Bottom navigation remains usable with gesture and button navigation.
- Keyboard does not obscure text fields.
- Modal sheets remain scrollable on small screens.

## 12.5 Accessibility issue severity

Treat these as release blockers:

- Core action cannot be reached with a screen reader.
- Age button has no meaningful semantic label.
- Choice text is clipped at supported text sizes.
- Positive/negative outcome is communicated only through colour.
- Dialog traps or loses focus.
- Touch targets are too small for critical actions.

### Exit criteria

- Accessibility audit document completed.
- All release-blocking accessibility defects fixed.
- Supported device matrix has no known clipping or navigation blocker.

---

# 13. Workstream 10 — Performance, Stability, and Recovery

## 13.1 Performance profile

Measure:

- Cold start.
- Warm start.
- Time to interactive.
- Age-up duration.
- Timeline scrolling with a long life.
- Memory use after repeated age-ups.
- Save/load duration.
- Business and event catalogue loading.

## 13.2 Performance requirements

- Use lazy timeline rendering.
- Avoid rebuilding the full Life screen for isolated changes.
- Avoid parsing or constructing expensive content in widget build methods.
- Keep normal age-up responsive.
- Ensure simulations run outside presentation code.
- Remove accidental debug logging from release mode.

## 13.3 Recovery scenarios

Test:

- App closed before age-up begins.
- App killed during age-up calculation.
- App killed after transaction preparation but before save commit.
- App killed immediately after save commit.
- Corrupted active save with valid backup.
- Corrupted active save and corrupted backup.
- Full storage or write failure where it can be simulated.

Expected behaviour:

- Restore the last valid state.
- Never duplicate money, children, businesses, events, or legacy rewards.
- Show a friendly recovery message when user action is needed.
- Keep diagnostic details out of normal player-facing text.

## 13.4 Error handling

Create or verify one central error abstraction for:

- Save errors.
- Migration errors.
- Age-up transaction errors.
- Content-validation errors.
- Unexpected domain exceptions.

### Exit criteria

- No known memory leak in long-life testing.
- No duplicate transaction after recovery tests.
- Performance results are recorded.
- Critical stability defects are fixed.

---

# 14. Workstream 11 — Release-Candidate Preparation

This workstream prepares local release artifacts and documentation. Do not upload them.

## 14.1 Common release audit

Verify:

- Correct app name.
- Correct package and bundle IDs.
- Correct version and build numbers.
- Production application icon.
- No debug controls.
- No placeholder copy.
- No internal test routes.
- No development seeds exposed.
- No test advertisement IDs.
- No unnecessary permissions.
- No secret keys committed.
- Privacy policy and support URLs are configurable and valid when supplied.
- All third-party packages are inventoried.
- Open-source licences are reviewable where required.

## 14.2 Android release candidate

Prepare and verify:

- Release signing configuration without printing credentials.
- Android App Bundle.
- Release APK for local device QA if useful.
- 64-bit native support.
- Current required target API at the eventual submission date.
- Package name `com.wesleyconsults.ghanalifesim` unless repository reality differs and is documented.
- Version code and version name.
- Offline first launch.
- Process-death restoration.
- Production icon and splash.

Build commands may include:

```bash
flutter build appbundle --release
flutter build apk --release
```

Do not upload either artifact.

## 14.3 iOS release candidate

Prepare and verify where the local environment permits:

- Bundle ID.
- Marketing version and build number.
- Deployment target.
- App icon set.
- Privacy usage strings only for permissions actually used.
- Release-mode compile.
- Archive readiness.
- iPhone layout.
- iPad support decision.

Commands may include:

```bash
flutter build ios --release
```

Create an archive only when signing is available and safe. Do not upload it.

## 14.4 Privacy and store-declaration draft

Based on the actual final packages and SDKs, prepare a factual draft containing:

- Data collected.
- Data not collected.
- Data linked to users.
- Tracking status.
- Permissions used.
- Third-party SDKs.
- Account requirement.
- Advertising status.
- Purchases status.

Do not state “no data collected” until package and native-project audits confirm it.

## 14.5 Store asset checklist

Prepare a checklist, not necessarily final artwork, for:

- App icon.
- Google Play feature graphic.
- Android phone screenshots.
- Tablet screenshots only if tablet support remains enabled.
- iPhone screenshots.
- iPad screenshots only if iPad support remains enabled.
- Short description.
- Full description.
- Apple subtitle and keywords.
- Privacy policy URL.
- Support URL and email.
- Age/content rating answers.
- App review notes.

### Exit criteria

- Android release AAB builds locally.
- iOS release build or archive readiness is documented honestly.
- Release configuration contains no known debug artefacts.
- Privacy/store declaration draft matches actual code and SDKs.
- No upload or submission has occurred.

---

# 15. Recommended Implementation Order

Complete work in this order:

## Checkpoint A — Audit and protect

1. Inspect repository.
2. Run baseline validation.
3. Classify outstanding requirements.
4. Add or verify migration fixtures.

Do not proceed if the current build cannot be reproduced.

## Checkpoint B — Typed state and migration

1. Add business definitions and typed business state.
2. Add illness definitions and typed active illness state.
3. Add migration.
4. Add backup/recovery tests.
5. Confirm existing saves continue.

## Checkpoint C — Domain depth

1. Implement annual business outcomes.
2. Implement treatment and illness progression.
3. Integrate both into transactional age-up.
4. Add Year in Review and annual finance ledger.
5. Complete missing consequence chains and life-stage gating.

## Checkpoint D — Test and simulate

1. Expand unit tests.
2. Add widget tests.
3. Add integration journeys.
4. Build headless simulation harness.
5. Run and analyze at least 10,000 lives.
6. Tune config values.

## Checkpoint E — QA and hardening

1. Accessibility audit.
2. Device matrix.
3. Performance profiling.
4. Recovery testing.
5. Fix release blockers.

## Checkpoint F — Release candidate

1. Final analyzer and tests.
2. Android release builds.
3. iOS release validation.
4. Privacy/SDK audit.
5. Store-readiness checklist and final report.

---

# 16. Required Validation Commands

Run the appropriate available commands at the end:

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter test integration_test
flutter build apk --debug
flutter build apk --release
flutter build appbundle --release
flutter build ios --simulator
flutter build ios --release
```

Only run iOS commands supported by the local environment and signing setup. Report skipped commands and reasons accurately.

Also run:

- The migration fixture suite.
- The age-up transaction recovery suite.
- The headless balance simulation.
- Content catalogue validation.
- Repeated deterministic test runs to identify flakiness.

---

# 17. Release-Blocking Defects

Do not call the milestone complete while any of the following remain:

- Startup crash.
- Save corruption or unrecoverable migration of valid saves.
- Duplicate income, expenses, children, businesses, events, or rewards.
- Non-deterministic critical tests.
- A broken age-up transaction.
- Invalid event catalogue.
- No valid choice during normal progression.
- Business profit applied differently from the Year in Review ledger.
- Illness resolves, worsens, or kills without timeline explanation.
- Main actions inaccessible through TalkBack or VoiceOver.
- Critical clipping at supported text sizes.
- Debug controls in release mode.
- Release build failure.
- Incorrect package or bundle ID.
- Privacy disclosure draft inconsistent with integrated SDKs.

---

# 18. Definition of Done

This milestone is complete only when:

## Architecture and persistence

- Typed business and illness state is active.
- Versioned migration works on all fixtures.
- Backup and recovery prevents avoidable data loss.
- Transaction commits are idempotent.

## Gameplay

- Businesses have explainable annual profit/loss.
- Illnesses support treatment, recovery, chronic progression, and fatal outcomes.
- Year in Review explains the year's major state and financial changes.
- At least five consequence chains are fully functional.
- At least five distinct life paths remain viable.

## Quality

- Analyzer is clean.
- Critical unit, widget, migration, recovery, and integration tests pass.
- The deterministic simulation report has been generated and reviewed.
- No known release-blocking accessibility, layout, crash, or save issue remains.

## Release preparation

- Android release APK and AAB build locally.
- iOS release status is validated and documented.
- Privacy and SDK inventory is complete.
- Store-preparation checklist is complete.
- No build has been uploaded or submitted.

---

# 19. Required Final Report

At completion, produce a Markdown report containing:

## 19.1 Summary

- What was completed.
- What was already present and therefore preserved.
- What changed from the original plan and why.

## 19.2 Architecture

- New models.
- Migration version.
- Repository/controller/use-case changes.
- Transaction and recovery approach.

## 19.3 Gameplay

- Business changes.
- Illness and treatment changes.
- Year in Review.
- Event-chain additions.
- Balance changes.

## 19.4 Validation

- `flutter analyze` result.
- Total test count and result by type.
- Integration-test result.
- Migration-fixture result.
- Balance-simulation run count and key findings.
- Android debug/release/AAB build result.
- iOS build result or exact blocker.
- Accessibility/device matrix result.
- Performance findings.

## 19.5 Artifacts

List exact local paths for generated artifacts, including:

- Debug APK.
- Release APK.
- Release AAB.
- iOS build/archive where generated.
- Simulation report.
- Accessibility report.
- Store-readiness checklist.

## 19.6 Remaining work

Separate remaining items into:

- Required before closed testing.
- Required before production submission.
- Recommended after Version 1.0.

## 19.7 Honesty rule

Do not state that the game is store-ready merely because builds compile. Store readiness requires the acceptance criteria in this document to pass.

---

# 20. Final Instruction to the Implementation Agent

Implement this milestone directly in the existing Ghana Life Sim repository.

Begin with a repository audit and baseline validation. Preserve the completed Riverpod architecture, transactional age-up engine, timeline-first interface, event-history framework, education expansion, family lifecycle work, design system, and save protection unless a verified defect requires a targeted change.

Prioritize correctness and release safety over feature count. Complete typed business and illness state, deepen those simulations, add an auditable Year in Review, expand deterministic testing, run large-scale balance simulations, perform accessibility and device QA, and prepare local Android and iOS release candidates.

Do not upload or submit any build. Do not introduce unrelated post-launch systems. Finish by returning the required implementation report with exact validation results, local artifact paths, unresolved risks, and an honest readiness assessment.
