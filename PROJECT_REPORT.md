# Ghana Life Sim - Project Report

Last updated: 2026-05-06

## 1. Executive Summary

Ghana Life Sim is a Flutter-based mobile life simulation game inspired by BitLife, designed around Ghanaian and West African culture. The player creates a character, ages through life year by year, makes choices during random and contextual events, builds education/career/relationship progress, manages money, and eventually reaches death with a final life summary.

The project is currently a single Flutter app with local persistence, no backend, no account system, and no cloud sync. Most game logic is implemented client-side in Dart through model classes, data files, service classes, and Flutter screens.

The most important thing for a new developer to understand is that this is a text-driven simulation. The game's quality comes from four connected layers:

- Character state in `lib/models/character.dart`
- Event definitions in `lib/data/*_events.dart`
- Simulation rules in `lib/services/*.dart`
- Player-facing UI and age-up orchestration in `lib/screens/life_screen.dart`

## 2. Product Vision

Ghana Life Sim is intended to feel funny, chaotic, culturally familiar, and replayable. It should not be a generic life simulator with Ghanaian names pasted on top. The best features should reflect Ghanaian school life, family pressure, hustle culture, church/community expectations, relationship drama, money pressure, and social reputation.

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

### Main Dependencies

From `pubspec.yaml`:

- `hive`: local object persistence
- `hive_flutter`: Flutter integration for Hive
- `shared_preferences`: onboarding state and simple key-value app preferences
- `cupertino_icons`: icon support

### Dev Dependencies

- `flutter_test`: test framework
- `hive_generator`: generates Hive adapters
- `build_runner`: code generation runner
- `flutter_launcher_icons`: launcher icon generation
- `flutter_lints`: lint rules

### Supported Platforms In Repo

The repository contains platform folders for:

- Android
- iOS
- macOS
- Linux
- Windows
- Web

The practical development target right now appears to be Android first, with Chrome and macOS also available for quick testing.

## 4. App Identity And Package Info

### App Name

- Flutter app name: `ghana_life_sim`
- User-facing title: `Ghana Life Sim`

### Android

- Namespace: `com.example.ghana_life_sim`
- Application ID: `com.example.ghana_life_sim`
- Main Android activity: `android/app/src/main/kotlin/com/example/ghana_life_sim/MainActivity.kt`

### Version

From `pubspec.yaml`:

- Version name: `1.0.0`
- Build number: `1`

### Launcher Icon

Configured with `flutter_launcher_icons`:

- Source image: `ghanalife.png`
- Android icon name: `launcher_icon`
- iOS icons enabled
- Android adaptive icon background: `#000000`

## 5. Repository Structure

### Important Root Files

| File | Purpose |
|---|---|
| `pubspec.yaml` | Flutter dependencies, app version, launcher icon config |
| `analysis_options.yaml` | Lint configuration |
| `GHANA_LIFE_SIM_SCOPE.md` | Product scope and feature direction |
| `PLAYABILITY_ROADMAP.md` | Gameplay improvement roadmap |
| `PROGRESS_REPORT.md` | Historical progress notes |
| `PROJECT_REPORT.md` | This developer onboarding report |
| `ghanalife.png` | App/logo source image |

### Main Source Folders

| Folder | Purpose |
|---|---|
| `lib/models` | Core data models such as `Character` and `LifeEvent` |
| `lib/data` | Static game data: events, careers, education, businesses, side gigs |
| `lib/services` | Game logic services for career, school, housing, health, etc. |
| `lib/screens` | Flutter UI screens and gameplay screens |
| `test` | Automated tests |

## 6. App Startup Flow

Entry point:

- `lib/main.dart`

Startup sequence:

1. `main()` calls `WidgetsFlutterBinding.ensureInitialized()`.
2. `SaveService.init()` initializes Hive and opens the save box.
3. `GhanaLifeSimApp` builds the root `MaterialApp`.
4. `AppEntry` checks `SharedPreferences` for `onboarding_seen`.
5. If onboarding has not been seen, it opens `OnboardingScreen`.
6. If onboarding is complete and a non-dead saved character exists, it opens `LifeScreen`.
7. Otherwise, it opens `CharacterCreationScreen`.

Important classes:

- `GhanaLifeSimApp`
- `AppEntry`
- `SaveService`

## 7. Core Gameplay Loop

The main gameplay loop happens in `LifeScreen`.

The player:

1. Creates a character.
2. Ages up one year at a time.
3. Receives one or more life events.
4. Chooses from event options.
5. Stats, money, relationships, school, health, career, flags, and life log update.
6. Continues until health reaches 0 or age reaches 90.
7. Lands on `DeathScreen` for summary and restart.

Main orchestration file:

- `lib/screens/life_screen.dart`

Key function:

- `_ageUp()`

Key responsibilities of `_ageUp()`:

- Increment age
- Age children
- Apply aging health decay
- Progress school
- Progress career and income
- Progress relationship state
- Apply rent and child expenses
- Progress businesses
- Update consequence flags
- Pick valid events
- Show event dialog(s)
- Save game state
- Navigate to death screen when needed

## 8. Character Model

Primary model:

- `lib/models/character.dart`

Generated adapter:

- `lib/models/character.g.dart`

The `Character` class is a Hive object. It contains almost all persistent player state.

### Core Identity

- `name`
- `gender`
- `age`
- `isAlive`

### Core Stats

Stats are mostly 0-100 values:

- `health`
- `happiness`
- `smarts`
- `looks`
- `money`
- `reputation`
- `discipline`
- `streetSense`
- `connections`

Important distinction:

- `money` is now best understood as financial stability/status on a 0-100 scale.
- `cash` is actual spendable money in GHS.

### Economy Fields

- `cash`: spendable GHS balance
- `debt`: outstanding debt in GHS
- `monthlyIncome`: main career monthly income in GHS
- `sideGigIncome`: total side gig monthly income in GHS
- `totalBusinessIncome`: total business monthly income in GHS

### Education Fields

- `educationLevel`
- `isEnrolled`
- `enrolledIn`
- `yearsLeftInSchool`

### Career Fields

- `careerPath`
- `careerLevel`
- `monthlyIncome`

### Relationship Fields

- `relationshipStatus`
- `partnerName`
- `partnerJob`
- `partnerPersonality`
- `relationshipScore`
- `isCheating`
- `sidePartnerName`

### Children Fields

The original `numberOfChildren` still exists for compatibility and summary logic. The newer child tracking system adds:

- `childNames`
- `childGenders`
- `childAges`
- `childBondScores`

### Housing And Business Fields

- `housingStatus`
- `rentExpensePerYear`
- `businessNames`
- `businessTypes`
- `businessHealthList`
- `businessIncomeList`

### Health And Consequence Fields

- `causeOfDeath`
- `activeIllnesses`
- `flags`

`flags` are string markers for long-term consequences. Examples:

- `in_debt`
- `low_cash`
- `has_children`
- `family_disappointed`
- `distant_parent`

## 9. Hive Persistence Rules

Persistence service:

- `lib/services/save_service.dart`

Hive box:

- Box name: `ghana_life_box`
- Save key: `current_character`

### Critical Rule For New Developers

When adding fields to `Character`, always append new `@HiveField` numbers. Do not reorder existing fields. Do not reuse old field numbers.

Current latest field number:

- `48`

If adding a new persistent field:

1. Add it to `Character`.
2. Give it the next `@HiveField` number.
3. Add a sensible `defaultValue` if older saves should keep loading.
4. Initialize it in the constructor.
5. Run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

6. Run:

```bash
flutter test
```

## 10. Event System

Event model:

- `lib/models/event.dart`

Event registry:

- `lib/data/events.dart`

Event files:

- `adult_events.dart`
- `career_events.dart`
- `childhood_events.dart`
- `consequence_events.dart`
- `doing_events.dart`
- `ghana_events.dart`
- `health_events.dart`
- `rare_events.dart`
- `relationship_events.dart`
- `senior_events.dart`
- `teen_events.dart`
- `young_adult_events.dart`

### LifeEvent Fields

Each `LifeEvent` supports:

- `title`
- `description`
- `choices`
- `minAge`
- `maxAge`
- `statRequirements`
- `baseWeight`
- `requiredFlags`
- `blockedFlags`
- `requiredCareer`
- `requiredRelationshipStatus`
- `requiredHousingStatus`
- `requiresBusiness`

### EventChoice Fields

Each choice supports:

- `text`
- `statChanges`
- `outcome`
- `careerToSet`
- `illnessToAdd`
- `relationshipStatusToSet`
- `housingStatusToSet`
- `flagToAdd`
- `flagToRemove`
- `cashChange`
- `debtChange`

### How Events Are Selected

Events are filtered and weighted in `LifeScreen`.

Current selection logic:

- Age must match `minAge` and `maxAge`.
- Career, relationship, housing, and business requirements must match.
- `statRequirements` must be met.
- `requiredFlags` must exist on the character.
- `blockedFlags` must not exist on the character.
- Events receive a weight through `_eventWeight()`.
- Recent duplicate events are reduced in weight.
- Some years can trigger multiple events.

### How To Add A New Event

1. Choose the right event file in `lib/data`.
2. Add a `LifeEvent`.
3. Give it age bounds.
4. Add meaningful choices.
5. Use stat changes and cash/debt changes carefully.
6. Use flags if the event should create future consequences.
7. Import the event list in `lib/data/events.dart` if it is a new file.

Example pattern:

```dart
LifeEvent(
  title: 'Family Support Request',
  description: 'A family member needs help with fees.',
  minAge: 18,
  maxAge: 75,
  baseWeight: 14,
  choices: [
    EventChoice(
      text: 'Send money',
      statChanges: {'reputation': 8, 'money': -2},
      cashChange: -800,
      outcome: 'You helped, and the family praised you.',
    ),
  ],
)
```

## 11. Economy System

The economy now has two concepts:

- `cash`: real GHS balance
- `money`: 0-100 financial stability/status stat

### Income Sources

Main income:

- Career salary from `monthlyIncome`
- Side gigs from `sideGigIncome`
- Businesses from `businessIncomeList` and `totalBusinessIncome`

Age-up currently applies:

- Career and side-gig yearly cash payout
- Business yearly cash payout based on business health
- Financial status stat updates

### Expenses

Current major expenses:

- School fees
- Rent
- Moving out deposit
- Home down payment
- Business startup costs
- Business investments
- Wedding costs
- Divorce/legal costs
- Childbirth costs
- Child yearly expenses

### Debt

Debt can come from:

- School fee shortfalls
- Rent shortfalls
- Wedding shortfalls
- Divorce/legal shortfalls
- Child expense shortfalls
- Failed businesses
- Consequence events

Debt affects:

- Happiness
- Money stat
- Event flags
- Debt collector events

## 12. Services Overview

### `SaveService`

File:

- `lib/services/save_service.dart`

Purpose:

- Initialize Hive
- Save current character
- Load saved character
- Check if save exists
- Delete save

### `SchoolService`

File:

- `lib/services/school_service.dart`

Purpose:

- Determine available education programs
- Enroll character
- Progress school each age-up
- Apply school fees
- Graduate and update education level

Important note:

- School costs now convert old cost units into GHS through `programYearlyCashCost()`.

### `JobService`

File:

- `lib/services/job_service.dart`

Purpose:

- List available jobs
- List available side gigs
- Apply for jobs
- Start/quit side gigs
- Quit main job

### `CareerService`

File:

- `lib/services/career_service.dart`

Purpose:

- Get current career data
- Check promotion requirements
- Apply promotion
- Enter career
- Sync income from career data

### `RelationshipService`

File:

- `lib/services/relationship_service.dart`

Purpose:

- Generate partners
- Ask out
- Progress relationship score
- Propose
- Marry
- Cheat and get caught
- Break up
- Call off engagement
- Divorce
- Have children

Important note:

- Breakup, called-off engagement, and divorce are separate flows. Do not route all relationship endings through `divorce()`.

### `HousingService`

File:

- `lib/services/housing_service.dart`

Purpose:

- Check move-out eligibility
- Check home purchase eligibility
- Move out
- Buy home
- Apply yearly rent

Important constants:

- `moveOutDeposit`
- `homeDownPayment`
- `rentPerYear`

### `BusinessService`

File:

- `lib/services/business_service.dart`

Purpose:

- List available business types
- Start business
- Progress businesses annually
- Apply business income
- Apply health drift
- Handle business failure
- Invest in business
- Close business

Important note:

- Business startup costs are converted to GHS through `startupCashCost()`.

### `HealthService`

File:

- `lib/services/health_service.dart`

Purpose:

- Determine cause of death
- Calculate final life score
- Return final rating and subtitle

## 13. Screens Overview

### `OnboardingScreen`

File:

- `lib/screens/onboarding_screen.dart`

Purpose:

- First-run onboarding
- Sets `onboarding_seen` in `SharedPreferences`

### `CharacterCreationScreen`

File:

- `lib/screens/character_creation_screen.dart`

Purpose:

- Character name and gender
- Creates `Character`
- Starts new life

### `LifeScreen`

File:

- `lib/screens/life_screen.dart`

Purpose:

- Main gameplay hub
- Age-up loop
- Stats display
- Funds display
- Recent journey log
- Bottom navigation
- Event dialog handling

This is the most important screen in the project.

### `SchoolScreen`

File:

- `lib/screens/school_screen.dart`

Purpose:

- Show current education level
- Show enrollment progress
- List available education programs
- Enroll in school

### `JobScreen`

File:

- `lib/screens/job_screen.dart`

Purpose:

- Show current job
- Apply for jobs
- Start and quit side gigs

### `SocialScreen`

File:

- `lib/screens/social_screen.dart`

Purpose:

- Dating
- Marriage
- Children
- Cheating
- Breakups/divorce
- Relationship status display

### `HousingScreen`

File:

- `lib/screens/housing_screen.dart`

Purpose:

- Show housing status
- Move out
- Buy home

### `BusinessScreen`

File:

- `lib/screens/business_screen.dart`

Purpose:

- Show owned businesses
- Start businesses
- Invest in businesses
- Close businesses

### `LifeLogScreen`

File:

- `lib/screens/life_log_screen.dart`

Purpose:

- Show character life log/history

### `DeathScreen`

File:

- `lib/screens/death_screen.dart`

Purpose:

- Show cause of death
- Show final score/rating
- Show final stats
- Show life log
- Restart flow

## 14. Static Game Data

### Careers

File:

- `lib/data/careers.dart`

Each career has:

- Name
- Levels
- Titles
- Salary
- Stat requirements

Career paths include:

- Civil Service
- Healthcare
- Education
- Tech
- Trade
- Entertainment
- Hustle

### Side Gigs

File:

- `lib/data/side_gigs.dart`

Side gigs have:

- Name
- Description
- Monthly income
- Minimum age
- Stat requirements
- Optional required career

### Education

File:

- `lib/data/education.dart`

Education programs include:

- Primary School
- Junior High School
- Senior High School
- Vocational Training
- University

### Businesses

File:

- `lib/data/businesses.dart`

Business types include:

- Chop Bar
- Barbershop / Salon
- Poultry Farm
- Clothing / Fashion
- Provisions Shop
- Transport

## 15. Design System And UI Direction

The current UI direction is a modern light theme with soft pastel styling.

Common colors:

- Lilac/purple: `#B39DDB`
- Teal: `#B2DFDB`
- Gold/yellow: `#FFD700`
- Soft white/off-white backgrounds

General UI conventions:

- Material 3
- Rounded cards
- Pastel gradient stat panels
- Bottom navigation on the life screen
- Event dialogs with choice buttons
- Ghanaian cultural tone in copy

Important note:

- `main.dart` currently sets a dark `ColorScheme` seed, but many screens explicitly use light backgrounds and custom colors. A future cleanup should align the global theme with the actual light UI direction.

## 16. Current Testing Status

Current test file:

- `test/widget_test.dart`

Current test coverage:

- Basic model test for cash, debt, flags, and child tracking

Verified commands:

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter test
```

Current result:

- `flutter test` passes.

### Flutter Analyze

`flutter analyze` currently reports lint/deprecation warnings, mostly:

- `withOpacity` deprecation warnings
- unnecessary non-null assertions in older UI code
- minor style warnings

There are no known compile errors from the current gameplay changes.

Recommended future cleanup:

- Replace `withOpacity()` with `withValues(alpha: ...)`
- Remove unnecessary null assertions
- Clean old character creation screen style warnings

## 17. Development Setup

### Install Dependencies

```bash
flutter pub get
```

### Generate Hive Adapter

Run this after changing Hive model annotations:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run Tests

```bash
flutter test
```

### Analyze

```bash
flutter analyze
```

### Run App

List devices:

```bash
flutter devices
```

Run on default device:

```bash
flutter run
```

Run on Chrome:

```bash
flutter run -d chrome
```

Run on macOS:

```bash
flutter run -d macos
```

Run on connected Android device:

```bash
flutter run -d <device-id>
```

Known connected Android device during recent testing:

```text
SM S908B - R3CT7022MVJ
```

So this command may work when that phone is connected:

```bash
flutter run -d R3CT7022MVJ
```

## 18. Common Development Issues

### Android Signature Mismatch

Error:

```text
INSTALL_FAILED_UPDATE_INCOMPATIBLE
Existing package com.example.ghana_life_sim signatures do not match newer version
```

Cause:

- The phone already has the app installed with a different signing key.

Fix:

```bash
adb uninstall com.example.ghana_life_sim
flutter run
```

Or uninstall the app manually from the phone.

### Stale Build Path

Error example:

```text
Failed to create parent directory '/home/edwin'
```

Cause:

- Stale build/cache path from a previous environment.

Fix:

```bash
flutter clean
flutter pub get
flutter run
```

### Flutter SDK Cache Permission

If Flutter needs to update SDK cache files and fails with permission errors, rerun the command after ensuring Flutter has permission to write to its SDK cache. In this environment, some Flutter commands required elevated execution because the SDK is installed under `/opt/homebrew/share/flutter`.

## 19. Save Data Considerations

The app uses local Hive storage. There is no cloud sync.

During development, save data may be lost when:

- App is uninstalled from Android
- Hive schema changes incorrectly
- Save box is deleted
- Debug install replaces incompatible app signature

When changing persistent fields:

- Preserve existing Hive field numbers
- Add new fields at the end
- Provide default values where possible
- Regenerate `character.g.dart`
- Test loading old saves if possible

## 20. Gameplay Systems Implemented

### Implemented Or Partially Implemented

- Character creation
- Onboarding
- Local save/load
- Age-up life progression
- Life stages
- Event library
- Weighted/contextual events
- Multi-event years
- Stat changes
- Cash and debt economy
- School enrollment and graduation
- Career entry and promotion
- Side gigs
- Relationships
- Marriage
- Cheating consequences
- Breakups and divorce
- Children tracking
- Housing
- Businesses
- Business health and failure
- Health decline
- Illnesses
- Death screen and life scoring
- Life log

### Still Light Or Needing Expansion

- Parenting depth
- Medical treatment actions
- Crime/risky behavior depth
- Achievements
- Premium/ads integration
- Cloud saves
- Deep business simulation
- More intentional actions between age-ups
- Better automated UI tests

## 21. Current Roadmap Priorities

See:

- `PLAYABILITY_ROADMAP.md`

Highest-impact roadmap areas:

1. Event engine improvements
2. Economy realism
3. Relationship and family depth
4. Player actions between age-ups
5. More Ghana-specific long-term pressure systems

Recent work has already started the first three:

- Event stat requirements
- Weighted event selection
- Multi-event years
- Event flags
- Real GHS cash
- Debt
- Side-gig/business payouts
- Separate breakup/divorce logic
- Tracked children
- Consequence events

## 22. How To Safely Add New Features

### Adding A New Event

Use this when the feature is mostly story-driven.

Steps:

1. Add event to the appropriate `lib/data/*_events.dart` file.
2. Use age, stat, career, relationship, housing, business, and flag requirements.
3. Use `cashChange` and `debtChange` for financial impact.
4. Use `flagToAdd` for future consequences.
5. Make sure the event file is included in `lib/data/events.dart`.
6. Run `flutter test`.

### Adding A New Character Field

Use this only when the feature needs to persist across app restarts.

Steps:

1. Add the field to `Character`.
2. Use the next Hive field number.
3. Add default value if needed.
4. Initialize it in the constructor.
5. Add helper methods if logic repeats.
6. Regenerate Hive adapter.
7. Run tests.

### Adding A New Screen

Use this when the player needs a repeated manual action area.

Steps:

1. Create screen in `lib/screens`.
2. Pass the current `Character`.
3. Pass `onCharacterUpdated` callback.
4. Put actual state changes in a service class when possible.
5. Save character state after meaningful updates.
6. Add navigation from `LifeScreen` or another relevant screen.

### Adding A New Service

Use this when gameplay logic grows beyond a screen.

Service classes should:

- Receive `Character`
- Mutate character state intentionally
- Add life log entries for major changes
- Avoid direct UI dependencies
- Call `character.save()` only when appropriate

## 23. Code Style Notes

Current project style:

- Dart/Flutter standard style
- Service classes use static methods
- Static data is stored as Dart lists/constants
- Screens directly compose custom Flutter widgets
- The project currently has some older UI lint warnings

Recommended style for new work:

- Keep business/game logic in services
- Keep static content in `lib/data`
- Keep UI state and display in screens
- Avoid adding backend assumptions
- Avoid changing generated files manually unless absolutely necessary
- Keep Ghanaian copy culturally specific and playful

## 24. Important Files For New Developers

Start here:

1. `lib/main.dart`
2. `lib/models/character.dart`
3. `lib/models/event.dart`
4. `lib/screens/life_screen.dart`
5. `lib/data/events.dart`
6. `lib/services/save_service.dart`
7. `lib/services/school_service.dart`
8. `lib/services/job_service.dart`
9. `lib/services/relationship_service.dart`
10. `lib/services/business_service.dart`
11. `lib/services/housing_service.dart`
12. `lib/services/health_service.dart`

Supporting docs:

1. `GHANA_LIFE_SIM_SCOPE.md`
2. `PLAYABILITY_ROADMAP.md`
3. `PROGRESS_REPORT.md`

## 25. Suggested Next Developer Tasks

### High Priority

- Add more focused tests for `LifeScreen` age-up logic through service-level extraction.
- Clean `flutter analyze` warnings.
- Add more manual actions between age-ups.
- Improve child/parenting system.
- Add treatment/doctor actions for illnesses.

### Medium Priority

- Improve global theme consistency.
- Add more event flags and follow-up event chains.
- Add more career-specific promotion/firing events.
- Add more debt recovery options.
- Add better death/life summary metrics.

### Lower Priority

- Achievements
- Monetization hooks
- Cloud save
- Account system
- Leaderboards

## 26. Quick Onboarding Checklist

For a new developer:

1. Run `flutter pub get`.
2. Run `flutter test`.
3. Read `GHANA_LIFE_SIM_SCOPE.md`.
4. Read `PLAYABILITY_ROADMAP.md`.
5. Read `lib/models/character.dart`.
6. Read `lib/models/event.dart`.
7. Read `_ageUp()` in `lib/screens/life_screen.dart`.
8. Run the app with `flutter run`.
9. Create a new life and age up several years.
10. Inspect how life log, cash, debt, school, job, relationship, housing, and business screens change.

## 27. Final Notes

The game already has a strong foundation: a large event library, culturally specific tone, local saves, and several connected simulation systems. The main engineering challenge now is not simply adding more content. It is making consequences compound so every life feels different.

The best future work should focus on:

- More linked event chains
- More player actions
- More family and social pressure
- Better economy tuning
- Better test coverage around simulation rules

