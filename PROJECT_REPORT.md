# Ghana Life Sim - Project Report

Last updated: 2026-07-09

## 1. Executive Summary

Ghana Life Sim is a Flutter-based mobile life simulation game inspired by BitLife, designed around Ghanaian and West African culture. The player creates a character, ages through life year by year, makes choices during random and contextual events, builds education/career/relationship progress, manages money, and eventually reaches death with a final life summary.

The current direction is MVP 1 store-readiness: a complete, polished, playable vertical slice for Google Play Store closed testing, TestFlight, and eventual production release. The long-term BitLife-depth vision remains, but deep new systems are postponed until the core loop is reliable and enjoyable for real users.

The project is a single Flutter app with local persistence, no backend, no account system, and no cloud sync. All game logic is implemented client-side in Dart.

The game's quality comes from four connected layers:

- Character state in `lib/models/character.dart`
- Event definitions in `lib/data/*.dart`
- Simulation rules in `lib/services/*.dart`
- Player-facing UI and age-up orchestration in `lib/screens/life_screen.dart`

## 2. Product Vision

Ghana Life Sim is intended to feel funny, chaotic, culturally familiar, and replayable. It should not be a generic life simulator with Ghanaian names pasted on top. The best features reflect Ghanaian school life, family pressure, hustle culture, church/community expectations, relationship drama, money pressure, and social reputation.

### Target Audience

- Ghanaian and West African players
- Young adults and university-age players
- Mobile-first players who understand BitLife-style text simulation
- Players who enjoy funny but consequence-driven choices

### Tone

- Comedic, culturally specific, and dramatic
- Funny choices should still have meaningful consequences
- Local flavor matters: family expectations, school pressure, rent, debt, hustle, church, social media, marriage, funerals, and reputation

## 3. Current Tech Stack

### Framework

- Flutter
- Dart SDK constraint: `^3.11.3`
- Material 3 enabled
- Custom Georgia font family

### Main Dependencies

- `hive: ^2.2.3` — local object persistence
- `hive_flutter: ^1.1.0` — Flutter integration for Hive
- `shared_preferences: ^2.2.2` — onboarding state and meta-progress persistence
- `cupertino_icons: ^1.0.8` — icon support

### Dev Dependencies

- `flutter_test` — test framework
- `hive_generator: ^2.0.1` — generates Hive adapters
- `build_runner: ^2.4.6` — code generation runner
- `flutter_launcher_icons: ^0.13.1` — launcher icon generation
- `flutter_lints: ^6.0.0` — lint rules

### Supported Platforms

- Android (primary target)
- iOS
- macOS
- Linux
- Windows
- Web (Chrome for quick testing)

## 4. App Identity

- Flutter package name: `ghana_life_sim`
- User-facing title: `Ghana Life Sim`
- Android namespace: `com.wesleyconsults.ghanalifesim`
- Android application ID: `com.wesleyconsults.ghanalifesim`
- iOS bundle ID: `com.wesleyconsults.ghanalifesim`
- Version: `1.0.0+1`
- Launcher icon: `ghanalife.png` with black adaptive background

## 5. Repository Structure

### Key Files

| File | Purpose |
|---|---|
| `pubspec.yaml` | Dependencies, version, launcher icon config |
| `analysis_options.yaml` | Lint configuration |
| `lib/main.dart` | App entry point, theme, routing logic |
| `lib/models/character.dart` | Character model with all persistent state |
| `lib/models/character.g.dart` | Generated Hive adapter (do not edit manually) |
| `lib/models/event.dart` | LifeEvent and EventChoice model classes |

### Source Folders

| Folder | Purpose |
|---|---|
| `lib/models` | Core data models: Character, LifeEvent |
| `lib/data` | Static game data: events, careers, education, businesses, side gigs, names |
| `lib/services` | Game logic services: career, school, housing, health, business, relationships, etc. |
| `lib/screens` | Flutter UI screens |
| `test` | Automated tests (single file: `widget_test.dart`) |

## 6. App Startup Flow

Entry point: `lib/main.dart`

1. `main()` calls `WidgetsFlutterBinding.ensureInitialized()`.
2. `SaveService.init()` initializes Hive and opens the save box.
3. `GhanaLifeSimApp` builds the root `MaterialApp` with a dark seed color scheme (`#FFD700`), Material 3, Georgia font.
4. `AppEntry._determineRoute()` checks the routing:
   - If onboarding not seen → `OnboardingScreen`
   - If saved game exists with alive character → `LifeScreen`
   - Otherwise → `CharacterCreationScreen`

## 7. Core Gameplay Loop

The main gameplay loop happens in `LifeScreen` (`lib/screens/life_screen.dart`).

The player:
1. Creates a character (name + gender).
2. Ages up one year at a time via the AGE button.
3. Receives one or more life events (weighted random selection).
4. Chooses from 2-3 event options in a dialog.
5. Stats, cash, debt, relationships, school, health, career, flags, and life log update.
6. Between age-ups, the player can spend action energy on activities (Study, Exercise, Church, etc.).
7. Continues until health reaches 0 or age reaches 90.
8. Lands on `DeathScreen` for summary and restart.

## 7.1 MVP 1 Release Scope

MVP 1 includes character creation, onboarding, the main life dashboard, age-up loop, events, cash/debt economy, education, career, side gigs, relationships, marriage/breakup/divorce states, children/family tracking, housing, business, activities/action energy, life goals, achievements/meta-progress, death screen, legacy ribbons, save/load, and restart.

Post-MVP systems include deep crime, full friends/enemies, independent lives for children/parents/siblings, cars/land/investments, abroad/travel, chieftaincy/politics, monetization, cloud saves, accounts, and leaderboards.

### What `_ageUp()` does (in order)

1. Increments age
2. Ages children and family members
3. Resets action energy
4. Shows life stage transition modal if stage changed
5. Applies aging health decay (starts at age 40, escalates at 50, 65, 80)
6. Random serious health events at older ages
7. Progresses school if enrolled
8. Checks for career promotion
9. Pays yearly career + side gig income into cash
10. Applies debt interest (8% annually)
11. Updates consequence flags (in_debt, low_cash, has_children)
12. Progresses relationship (score drift + cheating detection)
13. Auto-divorces if relationship score reaches 0
14. Deducts rent if renting
15. Deducts child expenses per child
16. Progresses businesses (income, health drift, failure)
17. Re-checks consequence flags
18. Checks life goal progress
19. Selects and presents events via filtered weighted random pool
20. Saves game state
21. Navigates to death screen if dead

## 8. Character Model

Primary file: `lib/models/character.dart`
Generated adapter: `lib/models/character.g.dart`

The `Character` class is a `HiveObject` with `@HiveType(typeId: 0)`. It contains all persistent player state across 58 Hive fields (fields 0–57).

### Core Identity (fields 0–3)

- `name` (String, field 0)
- `gender` (String, field 1)
- `age` (int, field 2)
- `isAlive` (bool, field 3)

### Core Stats 0-100 (fields 4–12)

- `health` (field 4)
- `happiness` (field 5)
- `smarts` (field 6)
- `looks` (field 7)
- `money` — financial stability/status stat (field 8)
- `reputation` (field 9)
- `discipline` (field 10)
- `streetSense` (field 11)
- `connections` (field 12)

Important: `money` is a 0-100 stat representing financial stability. `cash` (field 42) is actual spendable GHS. These are separate concepts.

### Economy Fields (fields 18, 24, 42–43)

- `cash` (field 42, default 1000) — actual spendable GHS balance
- `debt` (field 43, default 0) — outstanding debt in GHS
- `monthlyIncome` (field 18) — main career monthly income in GHS
- `sideGigIncome` (field 24) — total side gig monthly income in GHS
- `totalBusinessIncome` (field 39) — sum of all business incomes

### Career Fields (fields 16–18)

- `careerPath` (field 16) — career name string, or 'None'
- `careerLevel` (field 17) — 0=none, 1=entry, 2=mid, 3=senior

### Education Fields (fields 14, 19–22)

- `education` (field 14) — legacy field (use `educationLevel` instead)
- `educationLevel` (field 19) — 'None', 'Primary', 'JHS', 'SHS', 'Vocational', 'University'
- `isEnrolled` (field 20)
- `enrolledIn` (field 21)
- `yearsLeftInSchool` (field 22)

### Relationship Fields (fields 25–32)

- `relationshipStatus` (field 25) — 'Single', 'Dating', 'Engaged', 'Married', 'Divorced', 'Widowed'
- `partnerName` (field 26)
- `partnerJob` (field 27)
- `partnerPersonality` (field 28) — e.g. 'Ambitious', 'Clingy', 'Funny', 'Jealous', 'Calm', 'Spiritual'
- `relationshipScore` (field 29) — 0–100
- `isCheating` (field 31)
- `sidePartnerName` (field 32)

### Children Fields (fields 30, 45–48)

- `numberOfChildren` (field 30) — count, kept in sync with child lists
- `childNames` (field 45)
- `childGenders` (field 46)
- `childAges` (field 47)
- `childBondScores` (field 48)

### Family Fields (fields 49–53)

- `familyNames` (field 49)
- `familyRelations` (field 50) — 'Mother', 'Father', 'Sibling'
- `familyAges` (field 51)
- `familyBondScores` (field 52)
- `familyAlive` (field 53)

Family is auto-seeded on creation: mother, father, and optionally a sibling with Ghanaian names and random ages/bonds.

### Housing Fields (fields 33–34)

- `housingStatus` (field 33) — 'With Parents', 'Renting', 'Homeowner'
- `rentExpensePerYear` (field 34)

### Business Fields (fields 35–39)

- `businessNames` (field 35)
- `businessTypes` (field 36)
- `businessHealthList` (field 37) — 0-100 per business
- `businessIncomeList` (field 38) — monthly income per business
- `totalBusinessIncome` (field 39) — cached sum

### Health & Death Fields (fields 40–41)

- `causeOfDeath` (field 40)
- `activeIllnesses` (field 41) — list of illness name strings

### Consequence & Story Flags (field 44)

- `flags` (field 44) — `List<String>` for long-term consequence markers

Examples: `in_debt`, `low_cash`, `has_children`, `family_disappointed`, `distant_parent`, `church_favorite`, `family_helper`, `risky_hustle_trouble`, `known_cheater`, `party_animal`

### Action Energy (field 54)

- `actionEnergy` (field 54, default 3) — resets to 3 each age-up (2 for toddlers). Consumed by activities.

### Life Goals (fields 55–56)

- `activeLifeGoalId` (field 55)
- `completedLifeGoalIds` (field 56)

### Meta (field 57)

- `deathRewardsRecorded` (field 57, default false) — prevents double-counting rewards

### Key Methods on Character

- `adjustStat(stat, amount)` — clamp a stat 0-100
- `adjustCash(amount)` — clamp cash 0-1B
- `adjustDebt(amount)` — clamp debt 0-1B
- `addFlag(flag)` / `removeFlag(flag)` / `hasFlag(flag)`
- `addChild(name, gender, bondScore)` — adds child to parallel arrays
- `ageChildren()` — increments all child ages
- `ensureFamilySeeded()` — seeds mother, father, optionally sibling
- `addFamilyMember(name, relation, age, bondScore, alive)`
- `ageFamily()` — increments family ages
- `averageFamilyBond` — computed getter across family + children + partner
- `resetActionEnergy()` — 2 for toddlers, 3 otherwise
- `consumeActionEnergy()` — decrements, returns false if 0
- `completeLifeGoal(goalId)` — adds to completed list
- `isDead` — `health <= 0 || age >= 90`
- `lifeStage` — returns 'Toddler', 'Child', 'Teenager', 'Young Adult', 'Adult', 'Middle Aged', or 'Senior'

## 9. Hive Schema Safety

Current latest Hive field: **57**

When adding new fields:
1. Append to the end of `Character` class
2. Use the next sequential `@HiveField` number
3. Add a `defaultValue` for backward compatibility
4. Initialize in the constructor
5. Run `flutter pub run build_runner build --delete-conflicting-outputs`
6. Run `flutter test`

Never reorder, remove, or change existing field numbers — this corrupts existing saves.

## 10. Event System

### Model

`lib/models/event.dart` — `LifeEvent` and `EventChoice` classes.

### LifeEvent Fields

- `title`, `description`
- `choices` — list of `EventChoice`
- `minAge`, `maxAge` — age range
- `statRequirements` — `Map<String, int>`
- `baseWeight` — integer weight for selection
- `requiredFlags`, `blockedFlags` — flag-based gating
- `requiredCareer`, `requiredRelationshipStatus`, `requiredHousingStatus`
- `requiresBusiness` — boolean gate

### EventChoice Fields

- `text` — button label
- `statChanges` — `Map<String, int>` stat adjustments
- `outcome` — narrative result text
- `careerToSet` — triggers career entry
- `illnessToAdd`
- `relationshipStatusToSet`, `housingStatusToSet`
- `flagToAdd`, `flagToRemove`
- `cashChange`, `debtChange`

### Event Registry

`lib/data/events.dart` — aggregates all event lists into `allEvents`.

### Event Source Files (13 files)

| File | Content |
|---|---|
| `adult_events.dart` | Adult life events |
| `career_events.dart` | `careerEntryEvents` + `careerSpecificEvents` |
| `childhood_events.dart` | Child-age events |
| `consequence_events.dart` | Flag-gated follow-up events |
| `doing_events.dart` | Activity/business/housing events |
| `ghana_events.dart` | Ghana-specific cultural events |
| `health_events.dart` | Health and illness events |
| `rare_events.dart` | Low-probability surprise events |
| `relationship_events.dart` | Dating/marriage/family events |
| `senior_events.dart` | Senior-age events |
| `teen_events.dart` | Teenager events |
| `young_adult_events.dart` | Young adult events |
| `events.dart` | Master registry + ~30 inline flagship events (jollof competition, dumsor, armed robbers, goat ate documents, pyramid scheme, etc.) |

### Event Selection Logic (in `LifeScreen`)

1. Filter all events through `_isEventValid()` — checks age, career, relationship, housing, business, stats, and flags
2. Determine event count for the year: 1-3 depending on age and RNG
3. Build weighted pool with `_eventWeight()`:
   - Base weight from event definition
   - Boost for health/money/career/relationship/business relevance
   - Penalty for recent duplicates
4. Select events by weighted random draw without replacement

### Adding a New Event

1. Add to the appropriate `lib/data/*.dart` file
2. If a new file, import it in `lib/data/events.dart`
3. Set age bounds, stat requirements, flags, and weight
4. Use `cashChange`/`debtChange` for financial impact
5. Use `flagToAdd`/`flagToRemove` for consequence chains

## 11. Economy System

Two parallel money concepts:
- **`cash`**: actual GHS balance (field 42), used for all transactions
- **`money`**: 0-100 financial stability stat (field 8), affected by income and debt

### Income Sources (per age-up)

- Career salary: `monthlyIncome * 12` added to cash
- Side gigs: `sideGigIncome * 12` added to cash
- Businesses: payout based on `(health/100) * baseIncome * 12` per business

### Expenses (per age-up)

- School fees (if enrolled)
- Rent (if renting, GHS 2400/year)
- Child expenses (GHS 1200/child/year)
- Debt interest (8% annually)

### One-time Costs

- Moving out deposit: GHS 1,000
- Home down payment: GHS 25,000
- Wedding: GHS 5,000
- Divorce: GHS 3,500
- Childbirth: GHS 2,500
- Business startup: varies by type (GHS 10,000–25,000)
- Business investment: GHS 3,000 (small) or 8,000 (big)

### Debt

Sources: school fee shortfalls, rent shortfalls, wedding/divorce/birth shortfalls, child expense shortfalls, failed business cleanup, event choices, gambling losses.

Effects: 8% annual interest, -2 happiness/year, -1 money/year, `in_debt` flag.

## 12. Services Overview

### SaveService (`lib/services/save_service.dart`)

- Initialises Hive, registers CharacterAdapter, opens `ghana_life_box`
- Save/load/delete single character via `current_character` key
- On load: seeds family if missing, clamps negative action energy, ensures active life goal

### SchoolService (`lib/services/school_service.dart`)

- Lists available programs based on age, prerequisites, smarts, cash, and already-completed levels
- Enrolls character, progresses yearly, deducts fees, graduates
- Handles fee shortfalls via debt
- Uses `feeUnit = 500` to convert cost units to GHS

### JobService (`lib/services/job_service.dart`)

- Lists available jobs (only when unemployed, gated by education and stats)
- Lists available side gigs (gated by age, stats, career)
- Apply for jobs (probability-based, affected by stat surplus)
- Take/quit side gigs, quit main job

### CareerService (`lib/services/career_service.dart`)

- Maps `careerPath` to `CareerData`
- Checks promotions (40% chance if stat requirements met)
- Applies promotions (increments level, syncs income, logs)
- Enters new career (sets path/level/income, logs)
- Syncs `monthlyIncome` from career level data

### RelationshipService (`lib/services/relationship_service.dart`)

- Generates partners with Ghanaian names, jobs, and personalities
- Ask out (probability based on looks + happiness)
- Progress relationship score (drift by personality, cheating penalty, 15% catch chance)
- Propose (requires Dating, age 22+, score 65+)
- Marry (costs GHS 5,000, debt if short)
- Start cheating, get caught, break up, call off engagement, divorce
- Have child (Married only, age 18-45, costs GHS 2,500)

### HousingService (`lib/services/housing_service.dart`)

- Move out: age 18+, GHS 1,000 deposit, status becomes 'Renting'
- Buy home: age 28+, GHS 25,000 down payment, status becomes 'Homeowner'
- Yearly rent deduction: GHS 2,400/year when renting

### BusinessService (`lib/services/business_service.dart`)

- Lists available business types (6 types: Chop Bar, Barbershop, Poultry, Fashion, Provisions, Transport)
- Start business: deducts startup cost, adds to parallel arrays
- Progress businesses: applies income + health drift (-5 to +3), failures when health hits 0
- Invest small (GHS 3,000, +15 health) or big (GHS 8,000, +30 health)
- Close business (GHS 5,000 refund)

### HealthService (`lib/services/health_service.dart`)

- Determines cause of death (contextual messages by age, illness, or health)
- Calculates life score (0-100) from final stats, relationship, children, housing, businesses
- Returns rating label: Legendary (75+), Solid Run (55+), Average Life (30+), Wasted Potential
- Returns legacy ribbon: Scandal Magnet, The Hustler, Family Hero, Big Person, Church Favorite, Campus Legend, Quiet Survivor, Wasted Talent, Local Legend, Respectable Citizen, Tough Life

### ActivityService (`lib/services/activity_service.dart`)

- 11 activities: Study, Exercise, Doctor, Rest, Church, Go Out, Betting, Help Family, Partner Time, Play With Kids, Risky Hustle
- Each costs action energy and optionally cash
- Filtered by age, partner/child requirements, and available cash
- Effects: stat changes, cash changes, debt, flags, illness removal

### LifeGoalService (`lib/services/life_goal_service.dart`)

- 8 life goals: Graduate University, Get Married, Raise 3 Children, Own A Home, Start A Business, Reach GHS 100,000, Die Debt Free, Reach Age 80
- Each has an id, title, description, target, and current value function
- Auto-assigns goals on creation, rotates to new goal on completion
- Progress checked every age-up

### MetaProgressService (`lib/services/meta_progress_service.dart`)

- Tracks cross-life progress via SharedPreferences
- Records: unlocked ribbons, unlocked achievements, completed life goals, lives completed
- 10 achievements: First Life Completed, Family Hero, Big Person, Hustler, University Graduate, Homeowner, Business Owner, Debt Survivor, Church Favorite, Scandal Magnet
- Records life completion rewards on death (prevents double-counting via `deathRewardsRecorded`)

## 13. Screens Overview

### OnboardingScreen
4-page swipeable intro. Sets `onboarding_seen` in SharedPreferences.

### CharacterCreationScreen
Name input + gender selection. Animated entry. Creates Character with randomized starting stats.

### LifeScreen *(most important screen)*
Main gameplay hub with:
- Header: character avatar, name, age, life stage
- Stats card: gradient card with 8 stat bars (happiness, health, smarts, looks, reputation, connections, streets, discipline)
- Career row (if employed): job title, income, education badge
- Funds card: available cash, debt
- Active life goal card with progress bar
- Activities section: grid of available actions with energy counter
- Housing and Business quick-nav cards
- Recent journey log (timeline)
- Bottom nav: Social, Job, AGE button (center), School, Doing
- SIM LIFE button: jump directly to death
- Trophy + book icon buttons: Achievements and full Life Log

Event dialogs appear after age-up with choice buttons.

### SocialScreen
Relationship status, partner details, bond score bar, children display, family circle (mother, father, sibling with bond scores). Actions: Meet Someone, Ask Out, Propose, Marry, Cheat, Break Up, Divorce, Call Off Engagement, Have Child.

### JobScreen
Current job card (with quit). Job listings (filtered by education/stat gates). Side gigs list (active + available).

### SchoolScreen
Current enrollment progress. Education level badge. Available programs (filtered by prerequisites, smarts, cash).

### HousingScreen
Status card (With Parents/Renting/Homeowner). Move out / buy home actions with requirements.

### BusinessScreen
Owned businesses with health bars, income, invest/close actions. Start new business section with type cards.

### AchievementsScreen
Cross-life progress: lives completed, unlocked ribbons, achievements list (locked/unlocked), completed life goals.

### LifeLogScreen
Scrollable full life log with alternating row colors.

### DeathScreen
Death card (name, age, cause), life rating circle with score, legacy ribbon, rewards/unlocks, final stats grid, life log summary, "View Legacy Progress" and "Live Again" buttons.

## 14. Static Game Data

### Careers (`lib/data/careers.dart`)
7 career paths: Civil Service, Healthcare, Education, Tech, Trade, Entertainment, Hustle. Each has 3 levels with title, salary, and stat requirements.

### Side Gigs (`lib/data/side_gigs.dart`)
12 side gigs: Private Tutor, Uber/Bolt Driver, Mobile Money Agent, Event MC, Hair Braider/Barber, Food Vendor, Freelance Designer, Church Musician, Social Media Manager, Sports Coach, Legal Clerk, Medical Locum.

### Education (`lib/data/education.dart`)
5 programs: Primary (6yr, free), JHS (3yr, free), SHS (3yr, cost 2/unit/year), Vocational (2yr, cost 3/unit/year), University (4yr, cost 5/unit/year).

### Businesses (`lib/data/businesses.dart`)
6 business types: Chop Bar, Barbershop/Salon, Poultry Farm, Clothing/Fashion, Provisions Shop, Transport. Each has startup cost, base monthly income, min age, stat requirements.

### Relationship Data (`lib/data/relationship_data.dart`)
20 male names, 17 female names, 12 personalities, 15 partner jobs. Functions for generating random partners.

## 15. Design System

Light theme with soft pastel styling:

- **Primary purple/lilac**: `#B39DDB`, `#D1C4E9`
- **Teal**: `#B2DFDB`, `#009688`
- **Gold/yellow**: `#FFD700`, `#FFB300`, `#FFF8E1`
- **Backgrounds**: `#FCFAFF`, `#FAF9FE`, white
- **Text**: `#424242` (primary), `#757575` (secondary), `#9E9E9E` (muted)
- **Material 3** with dark seed color scheme (but screens use explicit light colors)
- **Rounded cards** with border radius 13–19
- **Pastel gradient stat panels**
- **Bottom navigation** on life screen
- **Life stage color coding**: pink (Toddler), teal (Child), purple (Teen), blue (Young Adult), green (Adult), orange (Middle Aged), grey (Senior)
- Emoji avatars by gender and life stage

### Note on Theme Inconsistency

`main.dart` sets `Brightness.dark` in the ColorScheme seed, but all screens use explicit light backgrounds and colors. This is a known inconsistency.

## 16. Testing Status

### Test File
`test/widget_test.dart` — 4 tests, all passing.

Tests cover:
1. Character cash, debt, flags, and child tracking
2. Family seeding, action energy consumption via activity, legacy ribbon
3. Life goal completion and rotation
4. Meta-progress recording (ribbons, achievements, goals, lives completed)

### Commands

```bash
flutter pub get       # ✓ passes
flutter test          # ✓ 4/4 tests pass
flutter analyze       # 58 issues (all info-level deprecation warnings, no errors)
```

### Analyze Status

All 58 issues are info-level:
- `deprecated_member_use`: `withOpacity` should be `withValues(alpha: ...)` — widespread across screens
- `unnecessary_non_null_assertion`: `!` on non-nullable types in character_creation_screen.dart (7 warnings)
- `unnecessary_import`: `dart:ui` in character_creation_screen.dart
- `unnecessary_underscores`: triple underscores in page route builder
- `unnecessary_to_list_in_spreads`: `.toList()` in spread

**No compile errors. No test failures.**

## 17. Development Setup

```bash
# Install dependencies
flutter pub get

# Regenerate Hive adapter (after model changes)
flutter pub run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Analyze
flutter analyze

# Run on Chrome (quickest)
flutter run -d chrome

# Run on macOS
flutter run -d macos
```

## 18. Common Development Issues

### Android Signature Mismatch
```bash
adb uninstall com.wesleyconsults.ghanalifesim
flutter run
```

### Stale Build
```bash
flutter clean
flutter pub get
flutter run
```

## 19. Save Data Considerations

- Single save slot (`current_character` in Hive box `ghana_life_box`)
- No cloud sync, no accounts
- Always append new Hive fields with default values
- Never change existing field numbers
- Run `build_runner` after schema changes

## 20. Implemented Systems Summary

| System | Status |
|---|---|
| Character creation | Implemented |
| Onboarding | Implemented |
| Local save/load | Implemented |
| Age-up life progression | Implemented |
| Life stage transitions (modals) | Implemented |
| Stats (9 core + relationship score) | Implemented |
| Cash + debt economy | Implemented |
| School enrollment + graduation | Implemented |
| Career entry + promotion | Implemented |
| Side gigs | Implemented |
| Relationships (dating → marriage → divorce) | Implemented |
| Cheating + consequences | Implemented |
| Children tracking (name, age, gender, bond) | Implemented |
| Family tracking (mother, father, sibling) | Implemented |
| Housing (with parents → renting → homeowner) | Implemented |
| Businesses (start, invest, close, failure) | Implemented |
| Business health + income drift | Implemented |
| Health decline + random health events | Implemented |
| Illnesses + doctor treatment | Implemented |
| Death + life scoring + legacy ribbons | Implemented |
| Life log | Implemented |
| Event library (13 files, 150+ events) | Implemented |
| Weighted event selection | Implemented |
| Multi-event years | Implemented |
| Event flags for consequence chains | Implemented |
| Activities between age-ups (11 actions) | Implemented |
| Action energy system | Implemented |
| Life goals (8 goals) | Implemented |
| Meta-progress / achievements (10 achievements) | Implemented |
| Legacy ribbons (11 ribbons) | Implemented |
| Cross-life progress tracking | Implemented |

### Missing / Light

- Parenting depth (children don't age beyond basic tracking)
- Deep business simulation (single health stat, no employees/competition)
- Crime/risky behavior depth (only gambling + risky hustle activity)
- Cloud saves / accounts
- Monetization (ads, premium packs) — not integrated
- Audio/music
- Achievement notifications during life (only shown on death screen)
- No family death events (family ages but doesn't die)
- Children don't grow up or have their own lives
- No will/inheritance system
- No emigration/visa/"japa" mechanic
- No political involvement depth
- No social media depth beyond the viral event

## 21. Important Files for New Developers

1. `lib/main.dart` — entry point, routing
2. `lib/models/character.dart` — all persistent state
3. `lib/models/event.dart` — event/choice model
4. `lib/screens/life_screen.dart` — main gameplay loop (largest file, ~2200 lines)
5. `lib/data/events.dart` — event registry
6. `lib/services/save_service.dart` — persistence
7. `lib/services/school_service.dart` — education logic
8. `lib/services/job_service.dart` — employment logic
9. `lib/services/career_service.dart` — career data + promotions
10. `lib/services/relationship_service.dart` — relationship state machine
11. `lib/services/business_service.dart` — business simulation
12. `lib/services/housing_service.dart` — housing progression
13. `lib/services/health_service.dart` — death + scoring
14. `lib/services/activity_service.dart` — between-age-up actions
15. `lib/services/life_goal_service.dart` — life goals
16. `lib/services/meta_progress_service.dart` — cross-life achievements

## 22. Recommended Next Steps

### Before Rebuilding

1. Clean the 58 `flutter analyze` warnings — replace `withOpacity` with `withValues(alpha:)`
2. Fix theme inconsistency (dark seed with light screens)
3. Add more unit tests for service classes

### For Rebuilding

1. Improve `LifeScreen` architecture — it's 2200+ lines and does too much
2. Add more activities and make action energy matter more
3. Deepen family/children — family members should age and die, children should grow up
4. Add more event chains using flags for compound consequences
5. Improve UI polish: better transitions, haptic feedback, sound
6. Add monetization only after gameplay feels complete

## 23. Quick Onboarding Checklist

1. `flutter pub get`
2. `flutter test`
3. Read this document
4. Read `lib/models/character.dart`
5. Read `lib/models/event.dart`
6. Read `_ageUp()` in `lib/screens/life_screen.dart`
7. `flutter run -d chrome`
8. Create a life, age up several years, explore all tabs
