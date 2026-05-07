# Ghana Life Sim BitLife-Style Phase Plan

This file is the working implementation plan for making Ghana Life Sim feel more replayable, reactive, and close to the "one more year" loop of BitLife while keeping the Ghana-specific identity of the project.

Use this alongside `PLAYABILITY_ROADMAP.md`. The roadmap explains the broad product direction; this file tracks the practical phases we can implement one by one.

## Current Foundation

Already implemented:

- Weighted and state-aware yearly event selection
- Multi-event years
- Real cash and debt systems
- Housing and business actions
- Partner, marriage, cheating, children, and child bond tracking
- Doing-tab activities with yearly action energy
- Family Circle display in Social
- Legacy ribbons on the death screen
- Hive save support for new character fields
- Basic tests for model behavior, family, action energy, and ribbons

Known technical note:

- `flutter test` is passing.
- `flutter analyze` still reports existing lint cleanup items, mostly `withOpacity` deprecations and some character creation screen warnings.

## Phase 1: Replayability Foundation

Priority: Highest

Status: Completed

Goal:

Give players a reason to start new lives, chase different endings, and feel progress across multiple characters.

Features:

- [x] Add persistent meta-progress storage.
- [x] Track unlocked legacy ribbons across all lives.
- [x] Add achievements for major life patterns.
- [x] Add life goals that the player can pursue during a run.
- [x] Show goal progress in the app.
- [x] Reward completed goals at death.

Suggested achievements:

- First Life Completed
- Family Hero
- Big Person
- Hustler
- University Graduate
- Homeowner
- Business Owner
- Debt Survivor
- Church Favorite
- Scandal Magnet

Suggested life goals:

- Graduate university
- Get married
- Raise 3 children
- Own a home
- Start a business
- Reach GHS 100,000 cash
- Die with no debt
- Reach 80+ years old

Likely files:

- `lib/models/character.dart`
- `lib/services/save_service.dart`
- `lib/services/health_service.dart`
- `lib/screens/life_screen.dart`
- `lib/screens/death_screen.dart`
- New `lib/services/meta_progress_service.dart`
- New `lib/screens/achievements_screen.dart`
- New tests in `test/widget_test.dart` or a dedicated service test

Definition of done:

- [x] Ribbons unlock permanently after death.
- [x] Player can view unlocked ribbons/achievements.
- [x] A life goal is assigned or selectable.
- [x] Goal progress updates during play.
- [x] Tests verify unlock and progress logic.

## Phase 2: Decision Chains

Priority: Very High

Goal:

Move beyond one-off yearly events by adding story arcs that can continue across multiple years.

Features:

- Add chain IDs to events or create a separate chain service.
- Use flags to remember previous choices.
- Trigger follow-up events after delays.
- Add outcomes that can branch depending on stats, money, relationships, or reputation.

Example chains:

- A friend offers a shady business opportunity.
- A teacher notices your talent and pushes you toward scholarship.
- A family member asks for support, then remembers whether you helped.
- A partner suspects cheating, then confronts you later.
- A side hustle grows into a real business or collapses into debt.

Likely files:

- `lib/models/event.dart`
- `lib/models/character.dart`
- `lib/screens/life_screen.dart`
- `lib/data/consequence_events.dart`
- New `lib/services/story_chain_service.dart`

Definition of done:

- At least 5 multi-year chains exist.
- Player choices unlock delayed consequences.
- The same chain can end in multiple ways.
- Tests verify chain flag/progression logic.

## Phase 3: NPC Memory

Priority: High

Goal:

Make family, partners, children, bosses, and friends remember how the player treats them.

Features:

- Expand tracked people beyond simple names and bond scores.
- Add memory flags per important NPC.
- Let future events reference those memories.
- Make relationship actions affect future trust, support, conflict, and inheritance-style outcomes.

NPC memory examples:

- Partner remembers cheating.
- Children remember neglect or support.
- Parents remember financial help.
- Boss remembers discipline or workplace drama.
- Church/community remembers generosity or scandal.

Likely files:

- `lib/models/character.dart`
- `lib/services/relationship_service.dart`
- `lib/services/activity_service.dart`
- `lib/screens/social_screen.dart`
- New `lib/services/npc_memory_service.dart`

Definition of done:

- At least family and partner memories are tracked.
- Memories influence future events.
- Social screen exposes enough context for the player to understand relationship history.

## Phase 4: Crime And Trouble System

Priority: High

Goal:

Add high-risk choices and consequences, which are important for BitLife-style replayability.

Features:

- Add crime actions.
- Add risk rolls based on discipline, street sense, reputation, and age.
- Add police encounters.
- Add fines, debt, jail time, and criminal record flags.
- Add court outcomes.
- Add jail-year progression if imprisoned.

Possible actions:

- Pickpocket
- Scam
- Bribe official
- Illegal betting ring
- Fraudulent business move
- Street fight

Likely files:

- `lib/models/character.dart`
- `lib/services/activity_service.dart`
- `lib/screens/life_screen.dart`
- New `lib/services/crime_service.dart`
- New `lib/screens/trouble_screen.dart` if the system grows large

Definition of done:

- Crime actions exist and are age-gated.
- Criminal record affects jobs, relationships, and reputation.
- Jail blocks or changes some normal yearly actions.
- Tests verify crime risk and consequence behavior.

## Phase 5: Generational Mode

Priority: Medium-High

Goal:

Let the player continue as a child after death, making family and legacy matter more.

Features:

- On death, offer "Continue as child" if children exist.
- Create a new character from selected child data.
- Inherit a portion of cash/debt/legacy.
- Carry over family history or surname.
- Preserve meta-progress.

Likely files:

- `lib/models/character.dart`
- `lib/screens/death_screen.dart`
- `lib/services/save_service.dart`
- New `lib/services/legacy_service.dart`

Definition of done:

- Player can continue as one of their children.
- New life starts with inherited context.
- Parent's legacy remains visible in the log or meta-progress.

## Phase 6: Ghana-Specific Content Expansion

Priority: Ongoing

Goal:

Make the simulation feel unmistakably Ghanaian through grounded events, social pressure, humor, and local life choices.

Content areas:

- SHS and university life
- Trotro and transport events
- Church and mosque/community events
- Family obligations
- Weddings, funerals, naming ceremonies
- ECG/light-off moments
- Rent, landlords, and compound house drama
- Football and local fame
- Politics and public reputation
- Migration, abroad dreams, and returnee stories
- Side hustles, market trading, mobile money, food businesses

Likely files:

- `lib/data/childhood_events.dart`
- `lib/data/teen_events.dart`
- `lib/data/young_adult_events.dart`
- `lib/data/adult_events.dart`
- `lib/data/senior_events.dart`
- `lib/data/ghana_events.dart`
- `lib/data/doing_events.dart`
- `lib/data/consequence_events.dart`

Definition of done:

- Every life stage has Ghana-specific content.
- Local culture affects mechanics, not only flavor text.
- Events include consequences, costs, flags, and future hooks.

## Recommended Implementation Order

1. Phase 1: Replayability Foundation
2. Phase 2: Decision Chains
3. Phase 3: NPC Memory
4. Phase 4: Crime And Trouble System
5. Phase 5: Generational Mode
6. Phase 6: Ghana-Specific Content Expansion

## Testing Checklist Per Phase

Run after each implementation phase:

- `dart format`
- `flutter test`
- `flutter analyze`
- Manual app run with `flutter run`

Manual checks:

- Existing saves still load.
- New games still start cleanly.
- Age-up still works.
- Death screen still works.
- New features save and reload correctly.
- New features are visible enough that a player understands what changed.

## Working Rule

Each phase should end with:

- A focused implementation
- Updated tests
- Clear manual testing instructions
- A commit with a descriptive message
- No hidden save-breaking changes without migration/default handling
