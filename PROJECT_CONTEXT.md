# Ghana Life Sim — Project Context

## What this is

A Flutter mobile life simulation game inspired by BitLife, built around Ghanaian/West African culture. Player creates a character, lives year-by-year making choices during random events, builds career/relationships/wealth, dies, and restarts. All local, no backend.

## Tech

- **Flutter + Dart** (SDK `^3.11.3`, Material 3)
- **Hive** (`hive: ^2.2.3`) — local object persistence for character saves
- **SharedPreferences** — cross-life meta-progress (achievements, ribbons)
- **build_runner + hive_generator** — code generation for Hive adapters
- Platforms: Android (primary), iOS, macOS, Linux, Windows, Web
- Package: `com.wesleyconsults.ghanalifesim`, version `1.0.0+1`

## Architecture

```
lib/
  main.dart              → Entry point, theme, routing (onboarding → create → life → death)
  models/
    character.dart       → HiveObject, 58 fields (0–57), all persistent game state
    character.g.dart     → Generated adapter (checked in, don't edit)
    event.dart           → LifeEvent + EventChoice classes
  data/
    events.dart          → Master event registry (aggregates all event files)
    *_events.dart        → 13 event source files by life stage/theme (150+ events)
    careers.dart         → 7 career paths × 3 levels
    businesses.dart      → 6 business types
    education.dart       → 5 programs (Primary → University)
    relationship_data.dart → Ghanaian names, personalities, partner jobs
    side_gigs.dart       → 12 side gigs
  services/
    save_service.dart    → Hive init, save/load/delete
    activity_service.dart → 11 activities gated by action energy
    business_service.dart → Start, invest, close, health drift, failure
    career_service.dart  → Career data, promotions, entry
    event_choice_service.dart → Apply event outcomes to character
    health_service.dart  → Death causes, life scoring (0–100), legacy ribbons
    housing_service.dart → Move out, buy home, rent deduction
    job_service.dart     → Job/side gig listings, apply/quit
    life_goal_service.dart → 8 goals, assignment, progress check
    meta_progress_service.dart → Cross-life achievements via SharedPrefs
    relationship_service.dart → Full relationship state machine
    school_service.dart  → Enrollment, progression, fees, graduation
  screens/
    life_screen.dart     → Main hub (~2557 lines) — stats, activities, events, bottom nav
    death_screen.dart    → Life summary, score, ribbon, restart
    social_screen.dart   → Relationships, partner, children, family
    job_screen.dart      → Career + side gigs
    school_screen.dart   → Education enrollment
    business_screen.dart → Business management
    housing_screen.dart  → Housing progression
    onboarding_screen.dart → 4-page carousel
    character_creation_screen.dart → Name + gender
    achievements_screen.dart → Cross-life legacy view
    life_log_screen.dart → Full chronological life history
```

## How the game works

**Core loop:** View dashboard → use activities (with action energy) → navigate tabs → Age Up → get events → make choices → stats/state update → repeat until death.

**Age-up sequence** (in `_ageUp()`): increment age → age children/family → reset action energy → life stage modal → health decay (from 40) → progress school → check career promotion → pay income → apply debt interest (8%) → update flags → progress relationship → auto-divorce at score 0 → deduct rent → deduct child costs → progress businesses → check life goals → select events via weighted random pool → save → death check.

**Economy:** Real GHS. `cash` (spendable) vs `money` (0–100 stat). Income from career salary + side gigs + businesses. Expenses: school fees, rent, child costs, debt interest. One-time costs: wedding (5k), home (25k), business startup (10–25k), divorce (3.5k), birth (2.5k).

**Character model:** 58 Hive fields covering identity, 9 stats (0–100), career, education, relationships, children, family, housing, businesses, health, flags, action energy, life goals, meta. Always append new fields — never reorder or change existing field numbers.

**Events:** 150+ across 13 files. Filtered by age, stats, career, relationship, housing, business, flags. Early-age gating prevents adult events for toddlers. Fallback events guarantee every age-up has at least one event. Flag system enables consequence chains across lives.

## Current state

- **Build:** All commands pass — pub get, 10/10 tests, clean analyze, release APK/AAB/iOS
- **MVP 1 complete:** Full life loop, all core systems, 150+ events, achievements, ribbons, save/load
- **Not yet:** Android device testing, release signing, TestFlight upload, screenshots, store metadata
- **Known issues:** LifeScreen too large (2557 lines), no dedicated age-up service, theme inconsistency (dark seed with light screens), shallow family/children depth

## Dev commands

```bash
flutter pub get                          # Install deps
flutter test                             # Run tests (10)
flutter analyze                          # Lint check
flutter pub run build_runner build --delete-conflicting-outputs  # Regenerate Hive adapter
flutter run -d chrome                    # Quick web test
flutter run -d macos                     # Desktop test
flutter build apk --release              # Android APK
flutter build appbundle --release        # Android AAB
```

## Key files to read first

1. `lib/models/character.dart` — all state
2. `lib/models/event.dart` — event/choice model
3. `lib/screens/life_screen.dart` — main loop and `_ageUp()`
4. `lib/data/events.dart` — event registry
5. `lib/services/save_service.dart` — persistence

## Documentation

- `PROJECT_REPORT.md` — full 23-section reference (architecture, models, services, economy, testing)
- `GAME_FLOW_PREVIEW.md` — complete player journey walkthrough
- `CURRENT_STATE_AUDIT.md` — strengths, weaknesses, tech debt
