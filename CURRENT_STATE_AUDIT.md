# Ghana Life Sim — Current State Audit

Audit date: 2026-07-09
Commands run: `flutter pub get`, `flutter test`, `flutter analyze`, `flutter build apk --release`, `flutter build appbundle --release`, `flutter build ios --release`

## 1. Build & Test Status

| Command | Result |
|---|---|
| `flutter pub get` | Passes |
| `flutter test` | 10/10 tests pass |
| `flutter analyze` | Passes with no issues |
| `flutter build apk --release` | Passes |
| `flutter build appbundle --release` | Passes |
| `flutter build ios --release` | Passes |

The project compiles cleanly, all automated tests pass, and analyzer output is clean.

## 1.1 Release Identity Status

| Platform | Current ID | Status |
|---|---|---|
| Android namespace | `com.wesleyconsults.ghanalifesim` | Updated from example/default ID |
| Android applicationId | `com.wesleyconsults.ghanalifesim` | Updated from example/default ID |
| iOS bundle ID | `com.wesleyconsults.ghanalifesim` | Updated from example/default ID |
| App display name | `Ghana Life Sim` | Set on Android and iOS |
| Version/build | `1.0.0+1` | Ready for first testing build; confirm before upload |

Release APK and App Bundle builds pass. iOS release device build passes and the app launched on a detected wireless iPhone. Android physical-device testing is still not complete because no Android phone/emulator was connected.

## 2. What The Project Is

A functional text-based life simulation game with:
- Full life loop (birth → age-up → events → death → restart)
- 9 core stats (0-100)
- Real GHS cash economy with income, expenses, and debt
- 5-level education system (Primary → JHS → SHS → Vocational/University)
- 7 career paths with 3 promotion levels each
- 12 side gigs
- Full relationship state machine (Single → Dating → Engaged → Married → Divorced/Widowed)
- Cheating system with catch mechanics
- Children tracking (name, age, gender, bond)
- Family tracking (mother, father, sibling with ages and bonds)
- 3-state housing progression
- 6 business types with health, income, investment, and failure
- Health decline, illnesses, doctor visits
- Event library: 13 source files with 150+ events
- Weighted event selection with flag-based consequence chains
- Action energy system with 11 between-age-up activities
- 8 life goals
- 10 cross-life achievements with ribbons
- Local save/load via Hive
- Cross-life meta-progress via SharedPreferences

## 3. Strengths

### Architecture
- Clean separation: models → data → services → screens
- Service classes are stateless, pure logic — easy to test
- Event system is well-designed with filtering, weighting, and flag gates
- Hive schema uses safe append-only field numbering
- Character model is comprehensive (58 fields covering all systems)

### Content Quality
- Events have strong Ghanaian cultural voice (jollof competitions, dumsor, trotro arguments, mobile money scams, church prophecies, family meetings)
- Humor lands well — funny but consequence-driven
- Event choice outcomes are narratively satisfying
- Legacy ribbon system adds replay incentive

### Systems That Work Well
- Weighted event selection makes lives feel different
- Cash/debt economy creates real tradeoffs
- Relationship state machine is complete and handles edge cases
- Business health drift + failure is simple but effective
- Life stage transition modals give visual feedback on progression
- Death screen is polished with scoring, ribbons, and unlock tracking

### Code Practices
- Character methods are well-named and self-documenting
- Event model supports rich outcome types (career, illness, housing, relationship, flags, cash, debt)
- Flag system enables consequence chains across ages

## 4. Weaknesses

### LifeScreen is Too Large
`lib/screens/life_screen.dart` is ~2210 lines. It handles:
- Age-up orchestration (all system progression)
- Event selection and dialog display
- All UI (header, stats, funds, activities, life goal, doing nav, bottom nav, log list)
- Stat tooltips, life stage modals, avatar logic

This should be split into smaller widgets and the age-up logic extracted into a dedicated service.

### No Age-Up Orchestration Service
The `_ageUp()` method is a ~160-line monolithic function that calls 10+ systems directly. There's no single `GameLoopService` or `AgeUpService` that orchestrates yearly progression. This makes it hard to:
- Test age-up logic in isolation
- Add new systems without touching LifeScreen
- Change the order of yearly operations

### Theme Inconsistency
`main.dart` sets `Brightness.dark` in the seed ColorScheme, but every screen uses explicit light backgrounds (`#FCFAFF`, white). The global theme is misleading.

### Activity System is Hardcoded
The 11 activities are defined as constants inside `ActivityService`. There's no data-driven activity system. Adding a new activity requires modifying the service class directly.

### Family System is Basic
- Family members never die (they only age)
- No family events based on family member state
- Parents should eventually age and pass away
- Siblings don't have their own lives

### Children Don't Grow Up
Children are tracked with age, but they never:
- Go to school
- Leave home
- Have their own events
- Become independent

### Limited Test Coverage
The automated test suite now covers the MVP spine in a single file, including character creation, event consequences, activities/action energy, death/restart, save/load/delete, life goals, and achievements. Deeper service coverage is still needed for:
- SchoolService (enrollment, progression, graduation)
- JobService (job application probability, side gig logic)
- CareerService (promotion checks)
- RelationshipService (state machine transitions)
- HousingService (eligibility checks)
- BusinessService (health drift, failure, income calculation)
- Event filtering and weighting logic
- Age-up ordering and interactions

### No Integration Tests
No tests verify that a complete life (0→death) produces reasonable outcomes. No tests verify that multiple systems interact correctly during age-up.

## 5. Technical Debt

### Deprecated API Usage
Resolved on 2026-07-09. Screen color alpha calls now use `withValues(alpha:)`.

### Unnecessary Non-Null Assertions
Resolved on 2026-07-09. The no-op assertions in `character_creation_screen.dart` were removed.

### Duplicated Formatting Logic
Number formatting (`toString().replaceAllMapped(...)`) is copy-pasted across multiple screens instead of being a shared utility.

### Duplicated Stat Getters
`_getStat()` switch statements appear in `CareerService`, `JobService`, and `LifeScreen`. Should be a shared method on `Character` or a utility.

### Duplicated _emojiForType
Both `BusinessService` and `BusinessScreen` have identical `_emojiForType()` methods.

### Generated File Risk
`character.g.dart` is 225 lines of generated code. If `build_runner` fails or the toolchain changes, this is hard to reproduce manually. The file is checked in, which is correct practice for Hive.

### Mixed Persistence
Two persistence mechanisms:
- Hive for character state
- SharedPreferences for onboarding + meta-progress

This is fine but worth documenting: if SharedPreferences data is cleared (app uninstall), meta-progress is lost but Hive saves may survive on some platforms.

### Education Field Confusion
Character has both `education` (field 14) and `educationLevel` (field 19). The former appears to be legacy/unused in most code paths. This is confusing.

### job Field Confusion
Character has both `job` (field 13) and `careerPath` (field 16). The `job` field appears unused — career state is tracked through `careerPath` and `careerLevel`.

## 6. Areas That May Break During Rebuild

### Hive Schema Changes
Any change to field numbers or types will corrupt existing saves. Always append new fields. If you need to remove a field, leave the number unused and add a comment.

### Event Import Chain
The event system relies on `lib/data/events.dart` aggregating all event files. If a new event file is created but not imported, events silently won't fire.

### LifeScreen Age-Up Order
The order of operations in `_ageUp()` matters. For example:
- Income must be paid before expenses
- Debt interest should apply before expense shortfalls create new debt
- School progression should happen before event selection (graduation may unlock career events)
- Flag updates should happen after system changes but before event selection

Changing the order can break game balance in subtle ways.

### Character.save() Calls
Services call `character.save()` directly. If this pattern changes (e.g., moving to a save queue), many service methods need updating.

### Random Number Generation
Multiple services maintain their own `Random()` instances. This makes testing non-deterministic. A seedable RNG passed through services would make tests reproducible.

## 7. Documentation Discrepancies

### PROJECT_REPORT.md (now fixed)
Was missing documentation for:
- Activity system (activities, action energy)
- Life goal system
- Meta-progress/achievements system
- Family tracking system
- Legacy ribbons
- Hive fields 49–57

### GHANA_LIFE_SIM_SCOPE.md (outdated)
- Claims Career system is "Not started" — it's fully implemented
- Claims Relationship system is "Not started" — fully implemented
- Claims Business system is "Not started" — fully implemented
- Claims Housing system is "Not started" — fully implemented
- Claims "Initial event library (~12 events)" — actual count is 150+
- Lists achievements as "v2" — they're implemented now
- References old file structure (`widgets/` folder doesn't exist)

**Recommendation: Archive or heavily rewrite this file.**

### PLAYABILITY_ROADMAP.md (largely completed)
This roadmap document has been mostly implemented:
- Event stat requirements ✓
- Weighted event selection ✓
- Multi-event years ✓
- Character flags ✓
- Real cash field ✓
- Income payouts ✓
- Debt system ✓
- Separated breakup/divorce ✓
- Child records ✓
- Player actions between age-ups ✓

Remaining from this roadmap:
- More partner-driven events
- Family pressure events
- Economy rebalancing

## 8. File Size Concerns

| File | Lines | Concern |
|---|---|---|
| `life_screen.dart` | 2210 | Too large, mixes UI + game logic |
| `events.dart` | 1161 | Large but acceptable (event registry) |
| `death_screen.dart` | 829 | Moderately large but single-purpose |
| `social_screen.dart` | 855 | Acceptable |
| `character.dart` | 383 | Acceptable |
| `character.g.dart` | 226 | Generated, acceptable |

## 9. Dependency Health

| Dependency | Version | Status |
|---|---|---|
| hive | 2.2.3 | Stable, well-maintained |
| hive_flutter | 1.1.0 | Stable |
| shared_preferences | 2.2.2 | Stable |
| build_runner | 2.4.6 | Older version, 37 packages have updates available |
| hive_generator | 2.0.1 | Stable |
| flutter_launcher_icons | 0.13.1 | Older version |

No critical dependency issues. Consider updating `build_runner` and related packages eventually, but not urgent.

## 10. Summary Assessment

### Ready for MVP Polish
The project has a strong foundation for MVP 1. All core systems exist and work. The event library is substantial. The cultural voice is authentic. The next work should focus on store-readiness, manual device testing, UI overflow checks, screenshots, and release metadata rather than a full rebuild.

### What Must Be Fixed Before Store Submission
1. Configure proper Android upload/release signing instead of debug signing
2. Complete Android physical-device or emulator testing
3. Complete a manual full-life playthrough
4. Verify screenshots and store metadata
5. Publish privacy policy and support URLs
6. Complete iOS archive/signing/TestFlight upload in Xcode
7. Fix any UI overflow found during device testing

### What's Missing for "BitLife-like" Quality
1. More things to do between age-ups (currently 11 activities, BitLife has 50+)
2. Deeper family — family members should have life events, die, need help
3. Children growing up and becoming independent
4. More career depth — firings, job changes, workplace drama
5. Social depth — friends, enemies, rivals
6. More Ghana-specific systems (remittances, chieftaincy, "abroad" mechanic)
7. Crime/risk depth
8. Asset ownership beyond housing (cars, land, investments)
9. Better UI transitions and polish
10. Monetization integration
