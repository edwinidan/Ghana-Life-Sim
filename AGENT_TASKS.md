# Ghana Life Sim — Agent Task Tracker

## How To Use This File

You are an AI agent working on **Ghana Life Sim**, a Flutter mobile life simulation game inspired by BitLife, built for a Ghanaian audience. Before doing anything, read this file top to bottom to understand where the project is and what to do next.

**Rules:**
- Tasks are ordered by build order — do not skip ahead. A task marked `TODO` may depend on all tasks above it being `DONE`.
- When you complete a task, change its status from `[ ] TODO` to `[x] DONE`.
- If a task is partially done or blocked, mark it `[~] IN PROGRESS` and leave a note underneath it explaining what was done and what is blocking it.
- For full project context, read `GHANA_LIFE_SIM_SCOPE.md` in the project root.
- All code lives in `lib/`. The main entry point is `lib/main.dart`.

**Status Key:**
- `[x] DONE` — complete and working
- `[ ] TODO` — not started
- `[~] IN PROGRESS` — started but not finished

---

## Current Project Stack
- **Framework:** Flutter (Dart)
- **Platform target:** Android + iOS
- **Editor:** Cursor (VS Code-based)
- **Android SDK:** version 33+
- **Java:** OpenJDK 17
- **Testing:** Physical Android device + Chrome browser

---

## Phase 1 — Foundation (Core Loop) ✅

These are the bare minimum pieces needed for a playable prototype. All are complete.

### 1.1 Project Setup
- [x] DONE — Flutter installed and configured on Ubuntu Linux
- [x] DONE — Android SDK installed and licensed
- [x] DONE — Flutter project created at `~/ghana_life_sim`
- [x] DONE — Project folder structure created (`lib/models`, `lib/screens`, `lib/data`, `lib/widgets`)

### 1.2 Character Model (`lib/models/character.dart`)
- [x] DONE — Character class created with name, gender, age, isAlive fields
- [x] DONE — All 9 stats implemented: health, happiness, smarts, looks, money, reputation, discipline, streetSense, connections
- [x] DONE — Stats randomly seeded at character creation within realistic ranges
- [x] DONE — `adjustStat()` method implemented with 0–100 clamping
- [x] DONE — `isDead` getter (health <= 0 OR age >= 90)
- [x] DONE — `lifeStage` getter returning stage name based on age
- [x] DONE — `lifeLog` list for recording key life events

### 1.3 Event Model (`lib/models/event.dart`)
- [x] DONE — `LifeEvent` class with title, description, choices, minAge, maxAge, statRequirements
- [x] DONE — `EventChoice` class with text, statChanges map, outcome string

### 1.4 Initial Event Library (`lib/data/events.dart`)
- [x] DONE — 12 starter events written covering childhood through adult stages
- [x] DONE — Events cover: exam season, fights, family visitors, SHS choice, cheating, university decision, job offer, business idea, health scare, family pressure, dumsor, unexpected money

### 1.5 Character Creation Screen (`lib/screens/character_creation_screen.dart`)
- [x] DONE — Name text input field
- [x] DONE — Gender selection (Male / Female) with animated card toggle
- [x] DONE — Fade-in animation on screen load
- [x] DONE — Validation (empty name shows snackbar error)
- [x] DONE — Creates Character object and navigates to LifeScreen on submit
- [x] DONE — Background decoration circles for visual depth
- [x] DONE — "Made in Ghana 🇬🇭" footer

### 1.6 Main Life Screen (`lib/screens/life_screen.dart`)
- [x] DONE — Header bar with character name, life stage badge, gender, health display
- [x] DONE — Life stage color coding (each stage has a unique accent color)
- [x] DONE — Animated pulsing avatar (emoji changes by gender)
- [x] DONE — Age progress bar showing 0–90 lifespan with stage labels
- [x] DONE — 9-stat grid with emoji, label, color-coded progress bar, and value
- [x] DONE — Event card renders when an event fires after age-up
- [x] DONE — Event card has slide-in scale animation
- [x] DONE — Choice buttons are color-coded (blue, green, orange) with numbered circles
- [x] DONE — Outcome card renders after a choice is made
- [x] DONE — Age-up button at bottom triggers year progression and event selection
- [x] DONE — Button label changes to "Continue Life" when showing an outcome
- [x] DONE — Natural health decay after age 50 (−2 health per year)
- [x] DONE — Death check after every age-up and every choice

### 1.7 Death Screen (`lib/screens/death_screen.dart`)
- [x] DONE — Shows character name and age at death
- [x] DONE — Displays final values for key stats
- [x] DONE — Scrollable life log showing key decisions made during the life
- [x] DONE — "Live Again" button navigates back to CharacterCreationScreen

---

## Phase 2 — Save System

The save system must be built before any further systems are added. Without it, all progress is lost when the app closes, making testing painful and the game unshippable.

### 2.1 Add `shared_preferences` or `hive` Package
- [ ] TODO — Add `shared_preferences` to `pubspec.yaml` dependencies
- [ ] TODO — Run `flutter pub get` to install
- [ ] TODO — Verify package installs without conflict

> **Agent note:** Use `shared_preferences` for simplicity in v1. Hive can be adopted later if save complexity grows. Do not introduce both.

### 2.2 Create Save/Load Logic (`lib/services/save_service.dart`)
- [ ] TODO — Create `lib/services/` folder
- [ ] TODO — Create `SaveService` class with `saveGame(Character c)` method
- [ ] TODO — Serialize all Character fields to JSON (name, gender, age, all 9 stats, job, education, lifeLog list)
- [ ] TODO — Store serialized JSON string via shared_preferences under key `'saved_game'`
- [ ] TODO — Create `loadGame()` method that reads and deserializes saved JSON back into a Character object
- [ ] TODO — Create `hasSavedGame()` method returning bool
- [ ] TODO — Create `deleteSave()` method for when player dies and restarts

### 2.3 Wire Save Into Life Screen
- [ ] TODO — Call `SaveService.saveGame()` after every age-up in `life_screen.dart`
- [ ] TODO — Confirm save happens silently (no UI feedback needed in v1)

### 2.4 Wire Load Into App Entry
- [ ] TODO — On app launch in `main.dart`, check `SaveService.hasSavedGame()`
- [ ] TODO — If save exists, navigate directly to `LifeScreen` with loaded character
- [ ] TODO — If no save exists, navigate to `CharacterCreationScreen` as normal

### 2.5 Wire Delete Into Death and Restart Flow
- [ ] TODO — Call `SaveService.deleteSave()` when player presses "Live Again" on the death screen
- [ ] TODO — Confirm new life starts fresh with no leftover data

---

## Phase 3 — Event Library Expansion

The event library must reach a minimum of 300 events before the game feels replayable. This phase expands the library systematically by category. Each sub-task is a writing and data task, not a code change — the event engine already handles any event added to `lib/data/events.dart`.

> **Agent note:** All events follow the exact same `LifeEvent` structure already established in `lib/data/events.dart`. Add new events to the `allEvents` list in that file. Keep the writing tone: funny, chaotic, culturally Ghanaian, with real consequences.

### 3.1 Childhood Events (Age 0–12) — Target: 40 events
- [x] DONE — Starter events exist (family visitor, childhood fight)
- [ ] TODO — Write 38 more childhood events covering: first day of school, parent arguments, sibling rivalry, church/mosque events, report card day, being sent on errands, growing up poor vs comfortable, making first friends, being bullied, early talent discovery, primary school prize-giving, holiday trips to hometown, learning a skill from a parent or relative

### 3.2 Teenage Events (Age 13–17) — Target: 50 events
- [x] DONE — Starter events exist (exam season, SHS choice, cheating in exams)
- [ ] TODO — Write 47 more teenage events covering: first crush, peer pressure, social media drama, school prefect election, inter-school competitions, sneaking out, getting caught lying to parents, first job (selling things), sports tryouts, religious youth group, fashion and looks pressure, first heartbreak, choosing friends wisely or badly, school trip, graduation

### 3.3 Young Adult Events (Age 18–25) — Target: 50 events
- [x] DONE — Starter events exist (university choice, job offer, business idea)
- [ ] TODO — Write 47 more young adult events covering: campus life drama, NYSC/national service, first salary, moving out, roommate issues, romantic relationship milestones, friend group changes, side hustle attempts, skill-building choices, visa application attempt, social media clout, first car, family expectations about career

### 3.4 Adult Events (Age 26–49) — Target: 60 events
- [x] DONE — Starter events exist (health scare, family pressure, unexpected money)
- [ ] TODO — Write 57 more adult events covering: marriage proposal, wedding planning, having children, buying a house, career promotion, getting fired, business launch and early struggles, office politics, investment choices, relationship strain, divorce possibility, supporting aging parents, community reputation events, social scandals, political connections

### 3.5 Middle Age Events (Age 50–64) — Target: 40 events
- [ ] TODO — Write 40 middle age events covering: health checkups, children growing up, legacy decisions, retirement planning, marriage second wind or breakdown, grandchildren, mentoring younger people, community leadership, business succession, property decisions, long-lost connections returning, reflecting on past choices

### 3.6 Senior Events (Age 65–90) — Target: 30 events
- [ ] TODO — Write 30 senior events covering: retirement life, health decline, grandchildren visits, writing a will, reconnecting with family, final career honors, spiritual reflection, long illness, peaceful vs troubled final years, final life decisions before death

### 3.7 Ghana-Specific Cultural Events (All Ages) — Target: 40 events
- [x] DONE — Starter events exist (dumsor, mobile money mistake)
- [ ] TODO — Write 38 more Ghana-specific events covering: funeral attendance obligations, outdooring ceremonies, paying for a relative's school fees, chieftaincy family drama, election season pressure, ECG bill shock, potholes destroying your car, 'connections' getting you a job, police checkpoint bribe decision, sending money home from abroad, jollof rice debate causing a fight, pastor prophesying about your future, getting 419-scammed, Accra flooding affecting your home, chop bar business, susu savings group

### 3.8 Rare and Wild Events (All Ages) — Target: 15 events
- [ ] TODO — Write 15 rare events (very low trigger probability, surprising and memorable): winning the lottery, being approached for a movie role, viral social media moment, accidentally becoming a meme, long-lost wealthy relative appearing, surviving a serious accident, being offered a bribe by a government official, witnessing something you should not have

---

## Phase 4 — Career Progression System

Requires Phase 2 (save system) to be complete first so career state persists.

### 4.1 Extend Character Model for Career
- [ ] TODO — Add `careerPath` string field to Character (e.g. 'Civil Service', 'Tech', 'Trade', 'Healthcare', 'Education', 'Entertainment', 'Hustle', 'None')
- [ ] TODO — Add `careerLevel` int field (0 = unemployed, 1 = entry, 2 = mid, 3 = senior)
- [ ] TODO — Add `monthlyIncome` int field derived from careerPath + careerLevel
- [ ] TODO — Update `SaveService` to serialize and deserialize new fields

### 4.2 Create Career Data (`lib/data/careers.dart`)
- [ ] TODO — Create `Career` class with fields: name, levels (list of level names), salaries (list per level), statRequirements per level
- [ ] TODO — Define all 7 career paths with 3 levels each and salary ranges
- [ ] TODO — Define stat requirements for each promotion level (e.g. Tech mid-level requires smarts >= 60)

### 4.3 Career Entry Events
- [ ] TODO — Write career selection events that fire around age 18–22 allowing player to enter a career path
- [ ] TODO — Career entry event choices should set `careerPath` and `careerLevel = 1` on the character
- [ ] TODO — Entry requirements should check relevant stats (e.g. university education for healthcare)

### 4.4 Career Progression Logic
- [ ] TODO — Create `CareerService` in `lib/services/career_service.dart`
- [ ] TODO — Implement `checkPromotion(Character c)` — evaluates if character meets stat thresholds for next career level
- [ ] TODO — Implement `applyPromotion(Character c)` — increments careerLevel, updates income, adds to lifeLog
- [ ] TODO — Call `checkPromotion` annually during age-up in life screen
- [ ] TODO — Promotion chance should not be guaranteed — add randomness factor so same stats don't always promote same year

### 4.5 Career-Specific Events
- [ ] TODO — Write 5–8 events per career path (fired, promoted, office drama, difficult boss, opportunity to switch careers) — total ~45 events
- [ ] TODO — Filter these events by `careerPath` field so only relevant career events fire

### 4.6 Display Career on Life Screen
- [ ] TODO — Add career name and level to the life screen header or a dedicated career row below the stats grid
- [ ] TODO — Show current income somewhere on the main screen (small and clean, not cluttered)

---

## Phase 5 — Relationship System

Requires Phase 4 (career system) since relationship events interact with career and money states.

### 5.1 Extend Character Model for Relationships
- [ ] TODO — Add `relationshipStatus` string field ('Single', 'Dating', 'Engaged', 'Married', 'Divorced', 'Widowed')
- [ ] TODO — Add `partnerName` string field (generated randomly when dating begins)
- [ ] TODO — Add `relationshipScore` int field (0–100, represents relationship health)
- [ ] TODO — Add `numberOfChildren` int field
- [ ] TODO — Update SaveService to include new fields

### 5.2 Romance Event Chain
- [ ] TODO — Write dating events: meeting someone, early relationship choices, deepening or ending the relationship
- [ ] TODO — Dating events should set `relationshipStatus = 'Dating'` and generate a `partnerName`
- [ ] TODO — Write relationship health events: good periods, arguments, jealousy, trust issues
- [ ] TODO — Write marriage proposal event (fires when dating + age 22+ + relationshipScore >= 60)
- [ ] TODO — Marriage event sets `relationshipStatus = 'Married'`, happiness boost, money cost

### 5.3 Children Events
- [ ] TODO — Write pregnancy/children events that fire after marriage
- [ ] TODO — Children event increments `numberOfChildren`
- [ ] TODO — Write light parenting choice events (supportive, strict, neglectful, education-focused)
- [ ] TODO — Parenting choices affect money, happiness, and reputation

### 5.4 Relationship Breakdown Events
- [ ] TODO — Write relationship strain events triggered by low relationshipScore
- [ ] TODO — Write divorce event (fires when relationshipScore <= 20 + adult age)
- [ ] TODO — Divorce sets `relationshipStatus = 'Divorced'`, happiness penalty, money penalty

### 5.5 Family Events
- [ ] TODO — Write family obligation events (supporting parents, sibling issues, family emergencies)
- [ ] TODO — These should interact with money and happiness stats meaningfully

### 5.6 Display Relationship on Life Screen
- [ ] TODO — Show relationship status somewhere on the main screen (clean, not cluttered)
- [ ] TODO — Show number of children if > 0

---

## Phase 6 — Housing and Business Systems

Requires Phase 5. Housing and business both interact with relationship and career state.

### 6.1 Extend Character Model for Housing and Business
- [ ] TODO — Add `housingStatus` string field ('With Parents', 'Renting', 'Homeowner')
- [ ] TODO — Add `ownsBusinesss` bool field
- [ ] TODO — Add `businessName` string field
- [ ] TODO — Add `businessHealth` int field (0–100)
- [ ] TODO — Update SaveService

### 6.2 Housing Progression Events
- [ ] TODO — Write moving out event (fires age 20–28 when money >= threshold)
- [ ] TODO — Write renting struggles events (rent increase, bad landlord, needing to move)
- [ ] TODO — Write home purchase event (fires when money >= high threshold + adult age)
- [ ] TODO — Housing status change should update monthly expenses calculation

### 6.3 Business System Events
- [ ] TODO — Write business launch event (requires money threshold, sets `ownsBusiness = true`)
- [ ] TODO — Write business growth events (good period, new customer, opportunity to expand)
- [ ] TODO — Write business struggle events (competition, staff issues, customer complaints, slow season)
- [ ] TODO — Write business failure event (fires when businessHealth <= 10, sets `ownsBusiness = false`)
- [ ] TODO — Business events should filter by `ownsBusiness` flag

### 6.4 Display Housing and Business on Life Screen
- [ ] TODO — Show housing status on life screen (small indicator)
- [ ] TODO — Show business name and health if player owns one

---

## Phase 7 — Health System Refinement

Can be built in parallel with Phase 6.

### 7.1 Illness and Accident Events
- [ ] TODO — Write 10 illness events with treatment choices (hospital, local remedy, ignore)
- [ ] TODO — Write 5 accident events with outcome variance based on health and money
- [ ] TODO — Treatment choices should cost money and restore health
- [ ] TODO — Ignoring illness should apply health penalty and risk triggering worse events

### 7.2 Aging Health Curve
- [ ] TODO — Refine the aging decay curve — currently flat −2 after 50
- [ ] TODO — Implement: no decay 0–49, −1/year age 50–64, −2/year age 65–79, −3/year age 80+
- [ ] TODO — Add random chance of serious illness event increasing with age

### 7.3 Death Screen Enhancement
- [ ] TODO — Add cause of death message to death screen (illness, old age, accident, specific event)
- [ ] TODO — Add a "life rating" score calculated from final stats (e.g. average of all 9 stats)
- [ ] TODO — Show life rating label: 'Wasted Potential', 'Average Life', 'Solid Run', 'Legendary'

---

## Phase 8 — UI Polish and Life Screen Enhancement

Can be started after Phase 3 (more events) is done so there is enough content to see the UI working well.

### 8.1 Life Log Screen
- [ ] TODO — Create `lib/screens/life_log_screen.dart`
- [ ] TODO — Full scrollable timeline of lifeLog entries with age labels
- [ ] TODO — Accessible via a button on the main life screen (small icon, not intrusive)

### 8.2 Stats Detail View
- [ ] TODO — Tapping a stat card on the main screen should show a small tooltip or bottom sheet explaining what that stat does and what affects it

### 8.3 Onboarding Flow
- [ ] TODO — Create a first-launch detection flag using shared_preferences
- [ ] TODO — On first launch only, show 3–4 brief onboarding cards explaining stats and how the game works
- [ ] TODO — Skip button available from card 1
- [ ] TODO — Never show onboarding again after it has been seen or skipped

### 8.4 Transition Animations
- [ ] TODO — Add life stage transition moment — when the player crosses into a new life stage (e.g. Child → Teenager), show a brief full-screen overlay announcing the new stage with its color

### 8.5 Character Avatar Progression
- [ ] TODO — Update the header avatar emoji to reflect life stage (baby, child, teen, adult, elderly) rather than staying the same through the whole life

---

## Phase 9 — Monetization Integration

Do not start this phase until Phase 7 is complete and the game loop is solid. Monetization on a broken game is wasted effort.

### 9.1 Google AdMob Setup
- [ ] TODO — Create AdMob account at admob.google.com
- [ ] TODO — Create app entry in AdMob for Android and iOS
- [ ] TODO — Add `google_mobile_ads` package to `pubspec.yaml`
- [ ] TODO — Add AdMob App ID to `AndroidManifest.xml` and `Info.plist`
- [ ] TODO — Initialize AdMob in `main.dart` before `runApp()`

### 9.2 Rewarded Ads (Main Ad Experience)
- [ ] TODO — Create `AdService` in `lib/services/ad_service.dart`
- [ ] TODO — Implement rewarded ad load and show methods
- [ ] TODO — Add "Watch ad to reroll this event" button on event cards
- [ ] TODO — Add "Watch ad for a second chance" button on death screen (revive with 20 health)
- [ ] TODO — Rewarded ad buttons should only show if an ad is loaded and ready

### 9.3 Interstitial Ads (Light Usage)
- [ ] TODO — Show one interstitial ad on the death screen before life summary is revealed
- [ ] TODO — Cap at maximum 1 interstitial per death — never more
- [ ] TODO — Do not show interstitials mid-gameplay under any circumstance

### 9.4 In-App Purchases — Ad Removal
- [ ] TODO — Add `in_app_purchase` Flutter package
- [ ] TODO — Create product in Google Play Console: `remove_ads` (one-time purchase)
- [ ] TODO — Create product in App Store Connect: `remove_ads` (one-time purchase)
- [ ] TODO — Implement purchase flow and persist `adsRemoved` flag via shared_preferences
- [ ] TODO — All ad calls should check `adsRemoved` flag before showing

### 9.5 In-App Purchases — Content Packs
- [ ] TODO — Create `chaos_pack` product in both stores
- [ ] TODO — Create `career_hustle_pack` product in both stores
- [ ] TODO — Tag relevant events in `events.dart` with a `requiredPack` field
- [ ] TODO — Event engine should filter out pack-locked events unless that pack is purchased
- [ ] TODO — Add a simple "Premium" screen showing available packs with purchase buttons

---

## Phase 10 — Audio

### 10.1 Basic Sound Effects
- [ ] TODO — Add `audioplayers` or `just_audio` Flutter package
- [ ] TODO — Source or create 4–5 short sound effects: button tap, event card appear, good outcome, bad outcome, death
- [ ] TODO — Add `AudioService` in `lib/services/audio_service.dart`
- [ ] TODO — Wire sound effects to relevant UI interactions
- [ ] TODO — Add mute toggle in settings or life screen header

### 10.2 Background Music
- [ ] TODO — Source or create 1–2 short looping background music tracks (Afrobeats-inspired, lightweight)
- [ ] TODO — Music loops during gameplay, fades on death screen
- [ ] TODO — Respects mute toggle

---

## Phase 11 — Store Preparation and Launch

### 11.1 App Icon and Splash Screen
- [ ] TODO — Design app icon (Ghana flag colors, life sim feel — gold and green on dark)
- [ ] TODO — Generate all required icon sizes using `flutter_launcher_icons` package
- [ ] TODO — Create splash screen using `flutter_native_splash` package

### 11.2 Android Build
- [ ] TODO — Update `AndroidManifest.xml` with correct app name, permissions
- [ ] TODO — Configure signing keystore for release build
- [ ] TODO — Run `flutter build appbundle --release`
- [ ] TODO — Test release build on physical device

### 11.3 iOS Build
- [ ] TODO — Configure `Info.plist` with correct app name and permissions
- [ ] TODO — Set bundle identifier in Xcode
- [ ] TODO — Run `flutter build ipa --release` (requires Mac)
- [ ] TODO — Test on physical iOS device

### 11.4 Google Play Store Listing
- [ ] TODO — Write app title (max 30 characters)
- [ ] TODO — Write short description (max 80 characters)
- [ ] TODO — Write full description (max 4000 characters)
- [ ] TODO — Create 8 screenshots (phone size, show key screens)
- [ ] TODO — Create feature graphic (1024x500px)
- [ ] TODO — Answer content rating questionnaire (target: Teen)
- [ ] TODO — Add privacy policy URL
- [ ] TODO — Declare monetization and ad usage
- [ ] TODO — Submit for review

### 11.5 App Store Listing
- [ ] TODO — Write app title and subtitle
- [ ] TODO — Write description and keywords
- [ ] TODO — Upload screenshots (6.5 inch and 5.5 inch sizes minimum)
- [ ] TODO — Set age rating (12+ or 17+)
- [ ] TODO — Add privacy policy URL
- [ ] TODO — Submit for review

### 11.6 Analytics Setup
- [ ] TODO — Add Firebase or Mixpanel for basic analytics
- [ ] TODO — Track: session start, age-up count per session, event choices made, death age, store screen views, purchase attempts
- [ ] TODO — Crash reporting enabled via Firebase Crashlytics

---

## Quick Reference — File Map

```
lib/
  main.dart                          [x] DONE
  models/
    character.dart                   [x] DONE
    event.dart                       [x] DONE
  data/
    events.dart                      [x] DONE (12 starter events)
    careers.dart                     [ ] TODO (Phase 4)
  screens/
    character_creation_screen.dart   [x] DONE
    life_screen.dart                 [x] DONE
    death_screen.dart                [x] DONE
    life_log_screen.dart             [ ] TODO (Phase 8)
  services/
    save_service.dart                [ ] TODO (Phase 2)
    career_service.dart              [ ] TODO (Phase 4)
    ad_service.dart                  [ ] TODO (Phase 9)
    audio_service.dart               [ ] TODO (Phase 10)
  widgets/                           [ ] TODO (as needed)
```

---

## What To Do Next

**The next incomplete task is Phase 2.1 — Add `shared_preferences` package.**

Start there. Work downward through Phase 2 in order. Do not move to Phase 3 or beyond until all of Phase 2 is marked `DONE`.
