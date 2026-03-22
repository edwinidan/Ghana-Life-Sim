# Ghana Life Sim — Full Project Scope

## Overview

Ghana Life Sim is a mobile life simulation game inspired by BitLife, built specifically for a Ghanaian and West African audience. The game puts the player in control of a character's entire life — from birth to death — through a series of choices, random events, and stat-driven outcomes. The tone is comedic and culturally authentic, blending real Ghanaian social dynamics, humor, and hustle culture into a deeply replayable experience.

The game is being built with Flutter for Android and iOS, targeting young adults and university-age players. Monetization is free-to-play with ads and optional premium content packs.

---

## 1. Game Identity

- **Genre:** Text-based life simulation with choice-driven gameplay
- **Tone:** Comedy with real consequences — funny, chaotic, culturally familiar, but with meaningful long-term outcomes
- **Unique angle:** A Ghana-inspired life simulator. No other life sim game is built for this audience or reflects this cultural reality
- **Target audience:** Broad mobile audience with a strong core of young adults, university-age players, and people who relate to Ghanaian school, hustle, jobs, and social drama
- **Setting:** A fictionalized world clearly inspired by Ghana — real cultural flavor, thinly veiled institution names, authentic social scenarios
- **Naming approach:** Slightly altered fictional names for schools, companies, and institutions (e.g. "Koftech University" instead of KNUST) to avoid legal exposure while keeping cultural authenticity

---

## 2. Version 1 Scope

### Must-Have Systems for v1
- Full life progression from birth to death (age 0–90)
- Aging system with year-by-year progression
- Core stat system (9 stats)
- School and education progression
- Job and career system
- Money and basic economy
- Health and death system
- Relationship system (family and romance)
- Risky behavior and social consequences
- Marriage and children (lighter implementation)
- Property and housing (milestone-based)
- Business ownership (lighter implementation)
- Local save and load
- Working monetization (ads + premium hooks)

### Depth Approach
- **Deep core systems:** Aging, school, jobs, money, health, relationships
- **Lighter advanced systems:** Marriage, children, property, business ownership
- **Explicitly out of scope for v1:** Cloud saves, user accounts, leaderboards, deep business simulator, deep parenting simulator, cosmetic customization, achievements system (planned for v2)

---

## 3. Core Gameplay Loop

### Main Loop
1. Player creates a character (name, gender, randomized starting stats)
2. Player presses "Age Up" to advance one year
3. A random life event fires based on current age and stats
4. Player reads the event and picks from 2–3 choices
5. Stats update based on the choice made
6. An outcome message confirms what happened
7. Player continues aging until death (health reaches 0 or age reaches 90)
8. Death screen shows life summary and life log
9. Player starts a new life

### Age-Up Behavior
- One year passes per age-up
- 1–2 events may fire per year depending on age stage
- Natural stat decay begins after age 50 (health slowly declines)
- Certain events only appear within specific age ranges
- Stat thresholds can gate or weight certain events

---

## 4. Stat System

The player has 9 core stats, each ranging from 0 to 100. Stats affect which events appear, which choices succeed, and the overall life outcome.

| Stat | Description |
|---|---|
| Health | Physical wellbeing. Reaches 0 = death |
| Happiness | Emotional state. Affects relationship and mental events |
| Smarts | Intelligence and education level. Affects school and career outcomes |
| Looks | Physical appearance. Affects romance and social events |
| Money | Financial position. Affects housing, business, lifestyle events |
| Reputation | Social standing. Affects connections, career, and community events |
| Discipline | Self-control and work ethic. Affects career and education outcomes |
| Street Sense | Practical survival intelligence. Affects hustle and risky behavior outcomes |
| Connections | Social network strength. Affects job opportunities and relationship events |

### Stat Rules
- All stats are clamped between 0 and 100
- Stats can increase or decrease based on event choices
- Health reaching 0 at any age triggers death
- Age 90 triggers natural death regardless of health
- Stats are randomly seeded at character creation within realistic ranges

---

## 5. Life Stages

Stages are internal logic only — not heavily presented as rigid named phases to the player. Age ranges determine which events, actions, and opportunities appear.

| Stage | Age Range | Focus |
|---|---|---|
| Toddler | 0–5 | Family events, personality seeds |
| Child | 6–12 | School beginnings, friendships, family dynamics |
| Teenager | 13–17 | SHS, social drama, first major choices |
| Young Adult | 18–25 | University or hustle, first jobs, romance |
| Adult | 26–49 | Career growth, marriage, children, business |
| Middle Aged | 50–64 | Legacy building, health risks, family outcomes |
| Senior | 65–90 | Retirement, health decline, final events |

---

## 6. Education System

Education follows a guided progression with branching path elements. The player's choices and stats influence outcomes at each stage.

### Education Path Options
- **Primary school** — automatic, sets early smarts baseline
- **BECE / Junior High** — exam events, outcome affects SHS placement
- **Senior High School (SHS)** — major branching point, 3 approach choices
- **Post-SHS options:**
  - University (high smarts/money cost, high long-term reward)
  - Vocational/Technical School (moderate cost, practical skills)
  - Apprenticeship (low cost, trade-focused)
  - Drop out and hustle (no cost, high risk/reward, streetSense path)

### Education Effects
- Higher education unlocks better career paths
- Smarts stat influences exam event outcomes
- Discipline stat influences study choice outcomes
- Education level is tracked as a character attribute

---

## 7. Career and Income System

A hybrid career and hustle system. Players can pursue regular employment, side hustles, connections-based opportunities, and eventually small business ownership.

### Career Paths (v1)
Each career has an entry level, mid level, and senior level with associated salary ranges and career-specific events.

| Path | Entry | Mid | Senior |
|---|---|---|---|
| Civil Service | Junior Officer | Manager | Director |
| Healthcare | Nurse/Orderly | Doctor | Chief Medical Officer |
| Education | Teacher | Headmaster | GES Director |
| Tech | Junior Developer | Senior Developer | CTO / Startup Founder |
| Trade/Business | Market Seller | Shop Owner | Import/Export Operator |
| Entertainment | Local Performer | Regional Artist | Continental Star |
| Hustle/Informal | Roadside Vendor | Established Hustler | Business Owner |

### Income Mechanics
- Salary is represented through the Money stat
- Career progression requires meeting stat thresholds (smarts, discipline, connections)
- Job-specific events can trigger promotions, demotions, or firing
- Side hustles can supplement income independently of main career

---

## 8. Business Ownership System (Light, v1)

Business ownership is one of several money paths with a light management feel. Not a deep standalone business simulator.

### Business Flow
- Player can choose to start a small business from the adult stage onward
- Starting requires a Money threshold
- Business events include: startup struggles, staff issues, customer problems, competition, growth opportunities, and failure scenarios
- Business success/failure is influenced by Money, Reputation, Connections, and Discipline stats
- A failed business damages Money and Reputation
- A successful business grows Money and Reputation over time

---

## 9. Relationship System

Layered relationship system with event-driven drama. Family and romance are deeper; friendships are lighter in v1.

### Relationship Types
- **Family** — parents, siblings. Events include support, conflict, financial pressure, expectations
- **Romance** — dating, breakups, marriage proposals, relationship drama
- **Friends** — lighter system, connections-based events
- **Children** — parenting choices and family outcome events (light in v1)

### Romance and Marriage
- Romance events appear from teenage stage onward
- Marriage is a life milestone that affects happiness, money, and future events
- Marriage introduces shared financial events and family pressure events
- Divorce is possible and carries stat consequences

### Parenting (Light, v1)
- Players can have children through relationship events
- Parenting style choices: supportive, strict, neglectful, education-focused
- Parenting choices affect money, reputation, happiness, and later family events
- Children do not have their own full life simulation in v1

---

## 10. Housing and Property System (Milestone-Based, v1)

Housing acts as a life-state milestone rather than a deep management system.

### Housing States
| State | Description | Effects |
|---|---|---|
| Living with parents | Default early adult state | Low expenses, happiness penalty |
| Renting | Independent living | Moderate expenses, happiness boost |
| Owning a home | Major life milestone | High money cost, reputation and happiness boost |

### Property Effects
- Housing state affects monthly money drain
- Owning property boosts Reputation and Happiness
- Property purchase is a choice event requiring a Money threshold
- Property can be lost through financial events

---

## 11. Health and Death System

A balanced health system. Not a full medical simulator.

### Health Events
- Illness events (mild to serious)
- Accident events
- Hospital or treatment choices (costs money, restores health)
- Lifestyle events that affect health over time
- Aging-related health decline after age 50

### Death Causes
- Health stat reaching 0 (illness, accident, neglect)
- Natural death at age 90
- Specific catastrophic event outcomes (rare)

### Death Screen
- Shows character name, age at death, and life stage
- Displays final stat values
- Shows a life log of key decisions and outcomes
- "Live Again" button restarts with character creation

---

## 12. Risky Behavior System

Layered risky behavior through event-driven systems rather than a separate crime simulator.

### Risk Tiers
- **Small mischief** — cheating in exams, minor lies, small scams
- **Social scandals** — reputation-damaging events, relationship betrayals
- **Street hustles** — informal economy, grey market activity
- **Risky shortcuts** — bribery, cutting corners in business or career
- **Occasional criminal paths** — rare high-stakes events with serious consequences

### Risk Mechanics
- Risky choices offer high short-term stat gains with negative long-term risks
- Street Sense stat influences success rates on risky choices
- Reputation damage from failed risky behavior
- Some risky paths unlock unique event chains not available through straight paths

---

## 13. Event System

### Event Structure
Each event has:
- A title and description
- 2–3 choices
- Each choice has stat changes (positive and negative) and an outcome message
- Age range (minAge, maxAge) — event only fires within this range
- Optional stat requirements for filtering

### Event Categories
- Family and home life
- School and education
- Career and work
- Relationships and romance
- Health and body
- Money and finances
- Social and community
- Ghana-specific cultural events (dumsor, mobile money, family pressure, jollof debates, visa hustle, etc.)
- Risky and chaotic events
- Business and hustle
- Random/funny rare events

### Event Engine Rules
- Events are filtered by age range first
- Stat-based weighting applied to filtered pool (higher relevant stats = higher chance of matching events)
- Random selection from weighted pool
- Replayability improved through large event pool and randomness
- Rare events exist with very low trigger probability for surprise moments

### Content Target (v1)
- Minimum 300 events across all categories
- Each major life stage must have at least 40 unique events
- Ghana-specific events should make up at least 25% of the total pool

---

## 14. Monetization

### Model
Free-to-play with ads and optional premium content.

### Ad Strategy
- **Rewarded ads** — main ad experience. Player chooses to watch for optional benefits: rerolls, second chances on bad outcomes, small stat boosts, or bonus choices
- **Interstitial ads** — light usage only at natural milestone moments (death screen, major life transitions). Not mid-gameplay.
- No banner ads cluttering the main life screen

### Premium Content (v1 Launch)
- **Ad Removal** — one-time purchase, removes all non-rewarded ads
- **Chaos Pack** — extra dramatic, funny, and wild event scenarios not in the base game
- **Career and Hustle Pack** — additional money-making routes, special careers, and hustle-specific event chains

### Pricing Direction
- Ad removal: $0.99–$1.99
- Content packs: $0.99–$2.99 each
- No subscriptions in v1

### Revenue Stack
- Google AdMob for ad delivery
- Google Play Billing for in-app purchases
- Apple StoreKit for iOS in-app purchases

---

## 15. Technical Stack

### Framework
**Flutter** — chosen for cross-platform mobile development (Android + iOS from one codebase), strong UI toolkit, and suitability for screen/stat/card-driven gameplay.

### Language
**Dart** — Flutter's native language.

### Development Environment
- OS: Ubuntu Linux (primary) / Windows (secondary)
- Editor: Cursor (VS Code-based) with Flutter and Dart extensions
- Android SDK: version 33+, command line tools
- Java: OpenJDK 17 (required for Android SDK compatibility)
- Testing: Physical Android device via USB + Chrome for web preview

### Project Structure
```
lib/
  main.dart               — App entry point and theme
  models/
    character.dart        — Character class, stats, stat adjustment logic
    event.dart            — LifeEvent and EventChoice classes
  data/
    events.dart           — Full event library
  screens/
    character_creation_screen.dart
    life_screen.dart
    death_screen.dart
  widgets/                — Reusable UI components
```

### Save System
- Local save only in v1 using shared_preferences or hive
- Designed so cloud save can be added later without restructuring
- No user accounts in v1

### Content Architecture
- Events start close to code for prototyping
- Will migrate to a separate structured content system (JSON or similar) as event library grows, to allow easier editing, balancing, and scaling

---

## 16. UI and Visual Design

### Design Direction
- Dark theme throughout
- Primary accent: Gold (#FFD700) — Ghanaian flag reference
- Secondary accent: Green (#4CAF50) — Ghanaian flag reference
- Background: Deep navy/dark (#0D0D1A, #12122A)
- Clean, mobile-friendly layout with expressive event cards
- Life stage color coding for visual progression feedback

### Key Screens
- **Character Creation** — Name input, gender selection, animated intro
- **Main Life Screen** — Header with character info and health, age progress bar, 9-stat grid, event card area, bottom age-up button
- **Event Card** — Title, description, color-coded choice buttons with numbered options
- **Outcome Card** — Result of choice, shown before next age-up
- **Death Screen** — Final stats, life log, restart button

### Onboarding
- Short guided intro on first launch
- Simple stat explanations with optional tooltips
- Early guided prompts for first few age-ups

### Audio (Light, v1)
- Basic tap and event sound effects
- Simple background music loop
- Audio kept lightweight — not a major v1 production focus

---

## 17. Publishing and Compliance

### Platforms
- Android (Google Play) — primary
- iOS (App Store) — simultaneous target

### Store Requirements
- Google Play Developer account ($25 one-time)
- Apple Developer account ($99/year)
- Polished app icon, screenshots, store description
- Privacy policy (required for both stores)
- Age rating: Older Teen / Broad General Audience
- Monetization declarations for both stores

### Data and Analytics
- No user accounts in v1
- Light analytics and crash reporting (Firebase or similar)
- Track: retention, session length, feature usage, drop-off points, ad engagement
- Minimal data collection — no sensitive personal data stored

### Legal
- All institution and brand names fictionalized (thinly veiled Ghanaian equivalents)
- No real company logos or trademarks used
- Content stays within older-teen rating — relationship drama, social scandal, moderate risky behavior, implied adult themes, no graphic or explicit content

---

## 18. Launch Plan

### Definition of a Successful v1 Launch
- Game is stable and does not crash during normal play
- Players can complete a full life from birth to death
- Core loop feels fun and replayable — testers want to play again
- Monetization is functional (ads show, premium purchase works)
- Store listing looks professional and trustworthy

### Test Plan
1. Internal testing — developer and close friends
2. Small trusted tester group (10–20 people) for honest feedback
3. Google Play internal test track before public launch
4. Fix critical issues, then open beta or full launch

### First Release Goals
- Full life loop playable
- Minimum 300 events
- All core systems functional
- Working ads and at least one premium pack available
- Polished enough to feel like a real product, not a student project

---

## 19. Post-Launch Roadmap (v2 and Beyond)

These are explicitly out of scope for v1 but planned for future updates:

- Cloud save and user accounts
- Achievements and unlock system
- Special starting backgrounds (royal family, diaspora return, village upbringing)
- Deeper parenting — children with their own stat tracking
- More career paths and hustle routes
- Regional settings (Kumasi, Tamale, Cape Coast vs Accra)
- Abroad / japa mechanic — visa applications, life outside Ghana
- Expanded risky behavior and criminal paths
- More premium content packs
- Leaderboards and social sharing of life summaries
- Localization — Twi phrases and expressions woven into event text

---

## 20. Current Development Status

| Area | Status |
|---|---|
| Flutter environment setup | ✅ Complete |
| Project created | ✅ Complete |
| Character model | ✅ Complete |
| Event model | ✅ Complete |
| Character creation screen | ✅ Complete |
| Main life screen | ✅ Complete |
| Event card and choice system | ✅ Complete |
| Outcome display | ✅ Complete |
| Death screen | ✅ Complete |
| Initial event library (~12 events) | ✅ Complete |
| UI visual redesign (dark theme, gold accents, animations) | ✅ Complete |
| Save system | 🔲 Not started |
| Full event library (300+ events) | 🔲 Not started |
| Career progression logic | 🔲 Not started |
| Relationship system | 🔲 Not started |
| Business system | 🔲 Not started |
| Housing system | 🔲 Not started |
| Health/death refinement | 🔲 Not started |
| Monetization integration | 🔲 Not started |
| Audio | 🔲 Not started |
| Onboarding | 🔲 Not started |
| Store assets and publishing | 🔲 Not started |
