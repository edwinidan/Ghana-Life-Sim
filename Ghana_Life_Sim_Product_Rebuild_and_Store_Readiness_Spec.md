---
title: "Ghana Life Sim"
subtitle: "Product Rebuild, BitLife-Inspired UX, and Store Readiness Specification"
author: "Wesley Consults"
date: "26 July 2026"
lang: en-US
geometry: margin=0.75in
toc: true
toc-depth: 3
colorlinks: true
linkcolor: blue
urlcolor: blue
---

# Document Control

| Field | Value |
|---|---|
| Product | Ghana Life Sim |
| Document type | Product requirements and implementation specification |
| Status | Proposed rebuild specification |
| Date | 26 July 2026 |
| Primary platform | Android |
| Secondary platform | iOS |
| Framework | Flutter / Dart |
| Current version in source report | 1.0.0+1 |
| Intended release | Play Store closed testing, production; TestFlight, App Store production |
| Source baseline | Ghana Life Sim Project Report, last updated 9 July 2026 |

# 1. Executive Summary

Ghana Life Sim already contains the foundation of a full text-based life simulator: character creation, ageing, more than 150 events, education, careers, side gigs, relationships, children, housing, businesses, health, activities, life goals, achievements, death summaries, legacy ribbons, and local save/load. The main problem is not a lack of features. The problem is that the systems currently feel like separate cards, screens, and service functions rather than one connected life story.

This specification defines the changes required to turn the current build into a polished, store-ready Ghanaian life simulator with the clarity, speed, and replayability associated with BitLife, while keeping an original Ghana Life Sim identity. The product should borrow proven interaction patterns - a central life timeline, one-tap ageing, simple category navigation, compact stat presentation, fast decision dialogs, and strong replay loops - without copying BitLife's exact artwork, branding, wording, icons, screen composition, or trade dress.

The rebuild has five priorities:

1. Make the player's life story the centre of the interface.
2. Make every important choice produce visible short-term and long-term consequences.
3. Reduce dashboard clutter and make the game fast to understand and play.
4. restructure the code so simulation logic is testable outside `LifeScreen`.
5. Meet current Google Play and Apple App Store quality, privacy, metadata, testing, and technical requirements.

The recommended release strategy is a focused Version 1.0 vertical slice. It should be deep enough to produce clearly different lives, but it should not attempt to match every system accumulated by BitLife over many years. Crime empires, politics, migration, detailed vehicles, advanced investments, celebrity systems, and independent adult lives for every relative should remain post-launch expansions unless they are already essential to the core loop.

# 2. Source Basis and Decision Method

This specification is based on:

- The uploaded Ghana Life Sim Project Report, which is treated as the primary source for current implementation, architecture, systems, limitations, and release status.
- The uploaded research brief, which recommends a question-first, source-tiered, validation-heavy method and clear separation between facts, assumptions, recommendations, and unresolved decisions.
- Current official Apple, Google Play, Android, and Flutter documentation checked on 26 July 2026.
- Current official BitLife store listings, used only to identify broad category expectations and proven interaction patterns.

Each major recommendation in this document is framed as one of the following:

- **Required:** Needed for the target player experience, technical stability, or store readiness.
- **Recommended:** High-value improvement that should be included if time allows before launch.
- **Post-launch:** Valuable, but not required for the first polished release.
- **Validation item:** Must be tested with players or verified against the final build before being locked.

# 3. Product Definition

## 3.1 Product vision

Ghana Life Sim is a choice-driven text life simulator in which the player lives a culturally grounded Ghanaian life from birth to death. The player should experience family expectations, school pressure, friendships, relationships, work, unemployment, side hustles, rent, debt, business opportunities, faith and community, health, reputation, scandal, success, and loss.

The game must not feel like a generic simulator with Ghanaian names pasted on top. Ghanaian culture must affect the situations, options, consequences, terminology, humour, social expectations, and available life paths.

## 3.2 Core player promise

> Live a complete Ghanaian life, make meaningful choices, face the consequences, and try a completely different path next time.

## 3.3 Target audience

- Ghanaian and West African mobile players.
- Players familiar with text-based life simulators.
- Young adults and university-age players.
- Players who enjoy humour, drama, progression, and consequence-driven choices.
- International players interested in a culturally distinctive life simulator.

## 3.4 Product pillars

### Identity

The player understands who their character is, where they come from, what their family situation is, and what pressures shape their life.

### Story

The interface reads like a life story, not a management dashboard.

### Agency

Player actions affect stats, money, relationships, flags, future events, opportunities, and endings.

### Consequence

The game remembers major decisions and brings them back later.

### Replayability

Every completed life creates a reason to start another.

### Ghanaian authenticity

Local culture changes the simulation itself, not only its names and artwork.

# 4. Current-State Diagnosis

## 4.1 Strengths to preserve

The following existing systems should be retained and improved rather than rebuilt from zero:

- Local offline save/load through Hive.
- One-year age-up loop.
- Weighted event selection with age, stats, flags, career, relationship, housing, and business filters.
- Cash and debt as real GHS balances.
- Education, career, side gig, relationship, family, housing, business, activity, health, goal, achievement, death, and legacy services.
- Ghana-specific event library.
- Cross-life progress and legacy rewards.
- A single-player, offline-first model with no mandatory account.

## 4.2 Critical product problems

### The Life Screen is overloaded

The current Life Screen includes a character header, eight stat bars, career, funds, life goal, activity grid, housing, business, recent log, bottom navigation, simulation shortcut, achievements, and full log controls. Too many elements compete for attention.

### The story is secondary

The life log exists, but it is not the primary visual object. In a text life simulator, the chronological story should occupy most of the screen.

### Systems are introduced all at once

Players can see or learn about systems before they become relevant. This increases cognitive load and reduces the emotional effect of growing through life stages.

### Choices do not always communicate consequences clearly

The simulation changes state, but the player needs stronger feedback showing what changed now and what may return later.

### Parallel data structures are fragile

Children, family, and businesses are stored in parallel arrays. This is error-prone and makes future depth harder to implement.

### Architecture is concentrated in `LifeScreen`

At roughly 2,200 lines, `LifeScreen` mixes orchestration, simulation, navigation, presentation, random selection, dialogs, and persistence. This makes testing and safe changes difficult.

### Automated test coverage is insufficient

Four tests cannot adequately protect a simulation with education, careers, relationships, finance, businesses, events, ageing, death, migrations, and multiple platforms.

### Theme configuration is inconsistent

The root app declares a dark seed colour scheme while screens explicitly implement a light visual design. This should be replaced by one intentional design system.

### Release-readiness gaps

The source report does not show a complete analytics plan, crash reporting on both platforms, accessibility pass, store metadata pack, privacy and SDK audit, integration-test suite, device matrix, or release rollback process.

## 4.3 Keep, change, add, remove matrix

| Area | Decision | Required change |
|---|---|---|
| Age button | Keep | Make it the strongest central action and connect it to the timeline |
| Event system | Keep and deepen | Add stable IDs, categories, cooldowns, chains, visibility rules, and test fixtures |
| Main dashboard | Replace | Use a timeline-first life screen |
| Eight visible stat bars | Reduce | Show 4 primary stats by default; place advanced traits in profile/details |
| Bottom navigation | Replace | Use clear BitLife-style categories with original Ghana Life Sim styling |
| Action energy | Redesign | Hide complexity during childhood; make actions intentional and stage-based |
| Life goals | Keep | Move to optional goal/legacy area, not dominant dashboard card |
| Housing/business quick cards | Remove from home | Access through Assets/Activities categories |
| SIM LIFE button | Remove from normal UI | Keep only as a developer/debug command |
| Parallel family/business arrays | Replace gradually | Introduce typed entity models and safe save migration |
| Single `LifeScreen` orchestration | Replace | Move to controllers/use cases/repositories/view models |
| Four-test suite | Replace | Build unit, widget, integration, migration, and deterministic simulation tests |
| Explicit light colours everywhere | Replace | Centralise design tokens and theme extensions |
| Offline-only model | Keep for v1 | Add export/backup only if it can be done safely; cloud sync is post-launch |

# 5. Inspiration Boundary: Feel Familiar, Remain Original

## 5.1 Interaction patterns to adopt

The game may use these broad category conventions:

- A chronological life feed as the primary screen.
- A large, persistent Age action.
- Compact top-level stats.
- Category-based action menus.
- Fast modal or bottom-sheet choices.
- Clear green/red stat deltas after a choice.
- A complete life from birth to death.
- Strong death summary, achievements, challenges, and replay.

## 5.2 Elements that must remain original

- Ghana Life Sim name, icon, logo, characters, copy, humour, event content, and visual identity.
- Original layout proportions and component shapes.
- Original icons or licensed icon library.
- Original colour palette and typography.
- Ghana-specific systems and terminology.
- Original store screenshots and promotional copy.

## 5.3 Explicit restrictions

Do not:

- Reproduce BitLife screenshots in the app or store listing.
- Copy its logo, sperm icon, fonts, exact green colour, exact tab icons, or exact screen arrangement.
- Copy event text, challenge names, descriptions, premium names, or store copy.
- Market Ghana Life Sim as an official Ghanaian BitLife edition.
- Use "BitLife" in the app name, icon, subtitle, keywords, or screenshots.

Apple's current review guideline 4.1 warns against minor UI/name changes to a popular app and requires developers to create an original product. This is both a legal and store-review requirement.

# 6. Target Player Journey

## 6.1 First launch

1. Brand splash, no longer than necessary.
2. One-screen welcome with **Start a New Life**.
3. Optional **How to Play** link.
4. Character setup.
5. Birth reveal.
6. Guided first age-up.
7. Progressive introduction of systems as the character grows.

The current four-page onboarding should be removed or reduced. Instructions should appear at the moment the relevant feature becomes available.

## 6.2 Returning launch

When a live character exists:

- Primary button: **Continue [Name]'s Life**.
- Secondary options: **New Life**, **Legacy**, **Settings**.
- Show age, current occupation/school, money, and a short latest-life snippet.
- Confirm before replacing an active save.

## 6.3 Character creation

### Required inputs

- First name.
- Gender presentation options appropriate to the intended product scope.
- Birth region or **Random**.

### Recommended optional controls

- Randomise all.
- Surname selection or generation.
- Appearance avatar selection.

### Do not ask at creation

- Career.
- Education path.
- Life goal.
- Detailed traits.
- Religion.
- Income.

Those should emerge from the life rather than be configured like settings.

## 6.4 Birth generation

Generate and store:

- Full name.
- Birth year and region/town.
- Mother, father, and possible siblings.
- Household financial class.
- Family structure.
- Initial health, happiness, smarts, and looks.
- One or two hidden personality tendencies.
- A short origin paragraph.

### Example birth reveal

> You were born in Takoradi to Abena and Kofi Mensah. Your family gets by, but money becomes tight whenever an unexpected bill appears. Your mother is warm and protective. Your father expects discipline and good school results.

This should be dynamically generated from stored family and household attributes.

## 6.5 Guided childhood

- Ages 0-4: mostly narrative events and family choices.
- Age 5/6: introduce school.
- Age 10+: introduce limited activities and friendships.
- Teenage years: expand education, reputation, discipline, romance, peer pressure, and small money choices.
- Age 18+: unlock adult categories such as job, housing, business, adult relationships, and major financial commitments.

# 7. New Information Architecture

## 7.1 Primary navigation

Use five destinations with the Age button centred:

1. **Life** - chronological feed and identity.
2. **People** - family, partner, children, friends, and social actions.
3. **Age** - large central action, not a navigation page.
4. **Activities** - education, health, faith/community, fun, risky actions, and personal development.
5. **Assets** - job, money, side gigs, housing, businesses, property, and future financial systems.

Alternative label validation:

- Test **Occupation** versus **Assets** for clarity.
- Test whether **School** belongs inside Activities or as a context-specific top action.

## 7.2 Secondary navigation

Accessible from the character header or top-right menu:

- Profile and advanced stats.
- Full life log.
- Achievements.
- Life goals/challenges.
- Legacy.
- Settings.
- Help.
- Privacy policy.
- Restore purchases, once IAP exists.

# 8. UI and Visual Design Specification

## 8.1 Design objective

The UI should feel as fast and understandable as BitLife, but warmer, more culturally expressive, and recognisably Ghana Life Sim.

## 8.2 Visual direction

### Base style

- Light, paper-like background rather than a card-heavy pastel dashboard.
- Strong typography hierarchy.
- Simple separators and compact rows.
- Limited gradients.
- Rounded surfaces used mainly for dialogs, cards that need grouping, and primary actions.
- Ghana-inspired patterns used subtly in headers, empty states, milestones, and legacy screens.

### Proposed palette

| Token | Suggested use |
|---|---|
| Deep cocoa `#2B2118` | Main text and dark surfaces |
| Ghana green `#177245` | Primary positive action and progress |
| Warm gold `#D4A017` | Brand accent, Age button highlight, milestones |
| Brick red `#A83A32` | Negative outcomes, debt, danger |
| Cream `#FFF9EE` | Main background |
| White `#FFFFFF` | Dialog and elevated surfaces |
| Neutral grey `#767676` | Secondary text |
| Divider `#E7DFD2` | Timeline separators |

Final colours must be contrast-tested and should not rely on colour alone.

### Typography

- Use a highly legible system or licensed font for body text.
- Keep Georgia only if testing confirms readability and visual consistency on both platforms.
- Use a distinctive display face only for major titles and milestone cards.
- Support large text without clipping.

## 8.3 Main Life Screen

The Life Screen should be rebuilt in this order:

### Header

- Small avatar.
- Character name.
- Age and life stage.
- One-line status, for example: "SHS Student", "Unemployed", or "Nurse".
- Tap opens Profile.

### Compact stats strip

Show four primary stats:

- Happiness.
- Health.
- Smarts.
- Looks.

Use compact bars or rings. Advanced traits - reputation, discipline, street sense, connections, and financial stability - belong in Profile and appear contextually when changed.

### Life timeline

The timeline occupies most of the screen.

Each year has:

- Age label.
- One or more event entries.
- Small icons by category.
- Important deltas.
- Tap to expand full details when needed.

Example:

> **Age 17**
>
> Your WASSCE results arrived. You qualified for university, but your family cannot comfortably cover the fees.
>
> Smarts +4 | Family bond +2 | New decision available

### Sticky bottom navigation

- Four destinations around the central Age button.
- Age button uses the brand green/gold treatment.
- The button animates briefly when the year is ready to progress.
- No intrusive bounce loop.

## 8.4 Age-up experience

1. User taps Age.
2. Provide subtle haptic feedback.
3. Increment age only through a simulation transaction.
4. Add new year marker to timeline.
5. Present major decisions one at a time.
6. Show passive outcomes in the timeline.
7. Summarise yearly income, expenses, debt interest, relationship drift, school progress, and business results in one expandable **Year in Review** entry.
8. Save only after the transaction completes or safely checkpoint before/after each decision.

The game should not display three unrelated modal events with no sense of chronology. Events should form one readable annual chapter.

## 8.5 Choice dialogs

Use a bottom sheet or centred adaptive dialog with:

- Event title.
- Concise setup text.
- Optional illustration or emoji.
- 2-4 clearly differentiated choices.
- No visible exact outcome before the decision unless the choice is obviously financial.
- Confirm step only for irreversible high-impact actions.

After the choice, show an outcome panel containing:

- Narrative result.
- Immediate stat/money changes.
- Relationship changes.
- New condition or remembered consequence, when appropriate.

Do not expose raw internal flag names.

## 8.6 Category screens

Category screens should use simple grouped lists instead of grids of pastel cards.

Each row should show:

- Icon.
- Action or destination title.
- One-line status or requirement.
- Cost/energy where applicable.
- Chevron or action button.

Unavailable actions should either be hidden or shown with a clear unlock condition. Avoid screens dominated by disabled buttons.

## 8.7 Milestone presentation

Use special full-width timeline cards for:

- Starting school.
- Graduation.
- First job.
- Marriage.
- Birth of a child.
- Buying a home.
- Starting a business.
- Major illness.
- Death of a close relative.
- Retirement.
- Death.

These moments should feel more important than ordinary events.

## 8.8 Motion and feedback

Required:

- Haptics on Age, major choices, success, and destructive actions.
- 150-300 ms transitions.
- Count-up/down animations for money and key stat changes.
- Respect reduced motion.
- No animation should block input longer than necessary.

Recommended:

- Small original sound pack for Age, positive outcome, negative outcome, milestone, and death.
- Separate sound and haptic settings.

# 9. Core Simulation Redesign

## 9.1 Transactional age-up engine

Create an `AgeUpUseCase` or `LifeYearEngine` that runs outside the widget tree.

Inputs:

- Character snapshot.
- Current world state.
- Deterministic random generator.
- Event repository.
- Simulation configuration.

Outputs:

- Updated character/world state.
- Ordered list of timeline entries.
- Ordered list of required player decisions.
- Passive financial summary.
- Milestones.
- Death result, if any.

The engine must be testable without rendering Flutter widgets.

## 9.2 Deterministic randomisation

Store a life seed and use injectable random sources.

Benefits:

- Reproduce bugs.
- Test event distributions.
- Replay failed test cases.
- Prevent accidental different outcomes during widget rebuilds.

Do not generate consequential random values directly inside widgets.

## 9.3 Event identity and lifecycle

Every event needs:

- Stable ID.
- Version.
- Category.
- Age range.
- Life-stage range.
- Base weight.
- Requirements.
- Blockers.
- Cooldown.
- Maximum occurrences.
- Chain ID where relevant.
- Priority.
- Tags.
- Content rating tags.
- Choice IDs.
- Outcome IDs.

## 9.4 Event chains

At least 25-35 percent of flagship events in Version 1.0 should have a later consequence or follow-up.

Example chain:

1. Player borrows money from an uncle.
2. Player delays repayment.
3. Family reputation falls.
4. Uncle refuses help during a later emergency.
5. A funeral or family gathering creates confrontation.

The consequence may occur years later and should reference the original action in natural language.

## 9.5 Event selection rules

The selector should:

- Prefer stage-relevant events.
- Avoid recent repetition.
- Avoid contradictory events.
- Limit the number of major decisions per year.
- Use passive timeline entries for low-stakes developments.
- Guarantee minimum coverage of school, career, relationship, money, health, and family stories over a life.
- Increase rare-event probability only within safe bounds.
- Track event history and choice history separately.

## 9.6 Life stages

Recommended stages:

| Stage | Ages | Primary systems |
|---|---:|---|
| Infant | 0-2 | Family, health, origin |
| Early childhood | 3-5 | Family, play, early personality |
| Child | 6-12 | School, family, friendships, discipline |
| Teenager | 13-17 | School, peer pressure, identity, reputation, first romance |
| Young adult | 18-25 | Higher education, NSS, work, housing, side gigs, relationships |
| Adult | 26-39 | Career growth, marriage, children, business, property |
| Middle age | 40-59 | Health, leadership, family responsibility, peak career |
| Senior | 60+ | Retirement, legacy, health, adult children, bereavement |

Exact stage boundaries should be configuration data, not hard-coded throughout UI code.

# 10. Stats and Traits

## 10.1 Primary stats

Keep as visible core stats:

- Health.
- Happiness.
- Smarts.
- Looks.

## 10.2 Secondary stats

Keep but move to Profile and contextual feedback:

- Reputation.
- Discipline.
- Street sense.
- Connections.
- Financial stability.

## 10.3 Hidden or semi-hidden traits

Add typed traits that affect event weighting and outcomes:

- Ambition.
- Kindness.
- Risk tolerance.
- Faith/community orientation.
- Loyalty.
- Confidence.
- Resilience.

The player may see a personality summary, but not necessarily exact 0-100 values for every trait.

## 10.4 Stat design rules

- Every visible stat must affect multiple systems.
- Avoid tiny changes that never matter.
- Clamp values centrally.
- Document thresholds.
- Explain significant threshold effects through natural-language feedback.
- Do not allow the same action to be spammed every year with identical guaranteed gains.

# 11. Activities and Player Control

## 11.1 Replace the always-visible activity grid

Activities should live under the Activities tab and be grouped by category:

- Mind and education.
- Health and wellness.
- Faith and community.
- Social and family.
- Fun.
- Risky choices.

## 11.2 Action allowance

Keep a yearly action limit, but present it as **Time This Year** rather than an abstract energy currency.

- Children: 1-2 actions.
- Teenagers: 2-3 actions.
- Adults: 3 actions by default.
- Some careers, illnesses, parenthood states, or events may alter the allowance.

## 11.3 Activity outcome model

Activities should have:

- Immediate effects.
- Diminishing returns.
- Cooldowns.
- Random outcomes where suitable.
- Cost and affordability checks.
- Possible flags or event unlocks.
- Stage-specific variants.

Example: **Go to church** should not always provide identical happiness and reputation. It may strengthen family bonds, create connections, unlock a relationship, cause conflict, or produce no major change.

# 12. Education System

## 12.1 Ghanaian progression

Recommended Version 1.0 structure:

- Primary school.
- JHS.
- BECE outcome.
- SHS, TVET/vocational, apprenticeship, or early work/hustle paths.
- WASSCE outcome for SHS.
- University, nursing/teacher training, polytechnic/technical university, vocational advancement, or direct employment.
- National Service Scheme for eligible tertiary graduates.

The current simple Primary -> JHS -> SHS -> Vocational/University model should be expanded into branching choices rather than only programme enrolment.

## 12.2 School performance

Track:

- Academic performance.
- Attendance/discipline.
- School reputation or peer standing.
- Fee pressure.

Performance should be affected by smarts, study activity, health, family pressure, school events, and money constraints.

## 12.3 Examination outcomes

- Provide a result reveal.
- Use deterministic weighted calculation based on preparation and life state.
- Offer realistic next options.
- Avoid making one bad exam permanently destroy every future path; provide retakes, vocational routes, entrepreneurship, and informal work.

## 12.4 Fees and funding

Add:

- Family support.
- Scholarships/bursaries.
- Student debt or family debt where appropriate.
- Part-time work.
- Sponsorship from a relative, church, employer, or community figure.

# 13. Career, Work, and Hustle

## 13.1 Career architecture

Replace fixed career levels with `CareerTrack` and `JobRole` entities.

A role should define:

- Education requirement.
- Stat requirements.
- Minimum age.
- Salary range.
- Promotion path.
- Sector.
- Risk/stability.
- Relevant events.
- Retirement rules.

## 13.2 Ghanaian career breadth for Version 1.0

The seven broad paths can remain, but should contain more recognisable roles:

- Civil/public service.
- Healthcare.
- Education.
- Technology/engineering.
- Trades and technical work.
- Entertainment/media/sports.
- Commerce and private sector.
- Informal economy/hustle.

## 13.3 Job flow

- Browse eligible openings.
- Apply.
- Receive interview/result event.
- Accept or reject offer.
- Build performance.
- Request promotion/raise or wait for review.
- Face redundancy, dismissal, transfer, workplace conflict, and retirement.

## 13.4 Side gigs

Side gigs should have hours/time cost, income variability, risk, and event chains. They should not be passive permanent salary multipliers with no trade-off.

## 13.5 National Service

Add NSS as a Ghana-specific bridge between tertiary education and employment:

- Placement location/sector.
- Allowance.
- Work experience.
- Networking.
- Possible retention after service.
- Posting-related events.

# 14. Money and Economy

## 14.1 Single source of truth

Keep:

- `cash`: spendable GHS.
- `debt`: outstanding GHS.

Rename or redesign the `money` 0-100 stat as **Financial Stability** to prevent confusion.

## 14.2 Annual financial statement

Every age-up should create an expandable statement:

- Employment income.
- Side-gig income.
- Business income.
- Rent/mortgage/housing cost.
- School fees.
- Child/family support.
- Healthcare.
- Debt interest.
- Event costs.
- Net change.

## 14.3 Economy balancing

Required balancing work:

- Replace hard-coded costs with configuration tables.
- Define a base-year economy and inflation strategy.
- Test low-, middle-, and high-income life paths.
- Prevent guaranteed wealth through passive businesses.
- Ensure debt is painful but recoverable.
- Make family obligations and emergencies meaningful without occurring every year.

## 14.4 Currency display

- Use `GHS 1,000` consistently.
- Use compact values only where space is limited.
- Always show full values in details and transaction history.

# 15. Relationships, Family, and Social Life

## 15.1 Replace parallel arrays with person entities

Create a `Person` or `RelationshipPerson` model with:

- Stable ID.
- Name.
- Gender.
- Age/birth year.
- Relation type.
- Alive status.
- Bond.
- Location.
- Job/education.
- Personality traits.
- Relationship state.
- Flags/history.

## 15.2 Family lifecycle

Required:

- Relatives age.
- Relatives can become ill and die.
- Family bonds affect support and events.
- Family members may ask for help or provide help.
- Siblings can study, work, marry, move, or struggle through simplified state changes.

Version 1.0 does not need a full independent simulation for every relative, but they must feel alive.

## 15.3 Romantic relationship flow

- Meet potential partner through life context, not only a generic button.
- Date.
- Improve or damage bond.
- Propose/engage.
- Marry.
- Have or adopt children where supported by product scope.
- Separate, reconcile, divorce, or become widowed.

## 15.4 Relationship personality

Partner personality should alter:

- Bond drift.
- Conflict events.
- Money decisions.
- Faith/community expectations.
- Jealousy and loyalty.
- Parenting decisions.
- Career support.

## 15.5 Children

Required for Version 1.0:

- Children age.
- School-stage milestones.
- Parent-child bond.
- Basic health and behaviour events.
- Education/support costs.
- Adult transition summary.

Post-launch:

- Detailed independent careers, partners, grandchildren, inheritance, and playable descendants.

## 15.6 Friends and enemies

Recommended minimum Version 1.0:

- 0-5 significant friends.
- Meet through school, work, neighbourhood, church, social events, or business.
- Bond, conflict, help, betrayal, and drift.

This provides social depth without building a full social network simulator.

# 16. Health, Ageing, and Death

## 16.1 Health model

Replace simple age-decay-only behaviour with:

- Baseline age effects.
- Lifestyle effects.
- Active conditions.
- Treatment status.
- Healthcare affordability.
- Recovery and chronic illness.
- Rare accidents.

## 16.2 Illness data model

Each illness should define:

- ID and display name.
- Severity.
- Age/stage relevance.
- Duration or chronic status.
- Health impact.
- Treatment options and costs.
- Untreated risk.
- Event tags.

## 16.3 Family death and bereavement

Add family death events with:

- Funeral cost and family contribution.
- Happiness impact.
- Reputation/family consequences.
- Optional inheritance where appropriate.
- Follow-up grief or family-conflict events.

## 16.4 Death rules

Do not automatically kill every character at age 90. Use a maximum safety cap only if necessary. Death should result from health, illness, accident, violence, or age-related probability.

## 16.5 Death screen

Show:

- Name, age, portrait, and cause of death.
- One-paragraph obituary generated from major life facts.
- Life score and original Ghana Life Sim legacy title.
- Key milestones.
- Family left behind.
- Wealth/debt at death.
- Most important choices.
- Achievements and unlocks.
- **Live Again** as the primary action.

# 17. Housing, Business, and Assets

## 17.1 Housing

Expand from With Parents -> Renting -> Homeowner to:

- With family.
- Shared rental.
- Renting.
- Employer/official accommodation.
- Homeowner.
- Temporarily homeless or staying with relatives, only if handled respectfully.

Each housing type affects cost, happiness, family bond, reputation, and events.

## 17.2 Businesses

Replace health-only simulation with a simple but meaningful model:

- Type.
- Revenue.
- Expenses.
- Reputation.
- Risk.
- Growth level.
- Staff count band.
- Business events.

Annual outcome should include profit/loss, not only base income multiplied by health.

## 17.3 Business actions

- Start.
- Invest.
- Hire/help from family.
- Borrow.
- Expand.
- Close/sell.
- Handle inspections, competition, theft, supply problems, and customer trends.

## 17.4 Post-launch assets

- Cars.
- Land.
- Investments.
- Multiple houses.
- Inheritance and wills.

These should not block Version 1.0.

# 18. Ghanaian Content Requirements

## 18.1 Content domains

The event library should cover:

- Naming/outdooring and childhood family life.
- School admission, BECE, WASSCE, tertiary applications, fees, and NSS.
- Trotro/taxi/ride-hailing and commuting.
- Dumsor and utility problems.
- Rent advance and landlord issues.
- Church, mosque, traditional/community life, and family expectations without mocking protected beliefs.
- Weddings, funerals, festivals, and family contributions.
- Side hustles, mobile money, online work, trading, transport, food, beauty, farming, and technical work.
- Football, music, social media, and entertainment.
- Extended-family pressure, remittances, and requests for help.
- Regional and language flavour used carefully and respectfully.
- Migration aspirations as post-launch or limited event chains.

## 18.2 Content quality rules

- Do not reduce Ghana to poverty, scams, religion, or comic stereotypes.
- Include ordinary, successful, aspirational, and quiet lives.
- Use humour without humiliating ethnic, religious, disability, gender, or economic groups.
- Review sensitive events with Ghanaian readers from different backgrounds.
- Separate fictional satire from real public figures unless legal review permits otherwise.

## 18.3 Writing style

- Event setup: usually 1-3 short paragraphs.
- Choice labels: direct and distinct.
- Outcome: concise, specific, and consequence-focused.
- Use Ghanaian English naturally, not excessively.
- Avoid explaining local terms inside every event; use optional glossary/help where needed.

# 19. Content Tooling and Authoring

## 19.1 Move content out of large Dart lists

Recommended:

- Store event definitions in validated JSON/YAML assets or generated Dart data.
- Use a schema validator and build step.
- Keep executable effect handlers typed and whitelisted.

## 19.2 Event authoring validator

Validate:

- Unique event and choice IDs.
- Valid age/stage range.
- Valid stat names.
- Valid flags.
- Reachable conditions.
- At least two choices for decision events.
- No empty text.
- No impossible required/blocked combination.
- No broken chain references.
- Content rating tags.

## 19.3 Content analytics

Track anonymously, if analytics is added and disclosed:

- Event shown.
- Choice selected.
- Event skipped because no valid choice.
- Chain completion.
- Repeat frequency.
- Death causes.
- Most common life paths.

Do not collect player-entered character names unless there is a clear need and disclosure. Prefer local-only storage.

# 20. Technical Architecture Rebuild

## 20.1 Target architecture

Use feature-based separation with:

- Views.
- View models/controllers.
- Repositories.
- Services.
- Domain use cases for complex simulation.

Flutter's current architecture guidance emphasises separation of concerns and keeping data/business logic outside views.

## 20.2 Proposed folder structure

```text
lib/
  app/
    app.dart
    routing/
    theme/
    config/
  core/
    errors/
    random/
    analytics/
    persistence/
    utilities/
  domain/
    models/
    repositories/
    use_cases/
  data/
    repositories/
    sources/
    content/
    migrations/
  features/
    home/
    character_creation/
    life_timeline/
    age_up/
    people/
    activities/
    assets/
    education/
    career/
    relationships/
    business/
    health/
    death/
    legacy/
    settings/
  shared/
    widgets/
    formatters/
    accessibility/
```

## 20.3 Break up `LifeScreen`

`LifeScreen` should become a thin view composed of:

- `CharacterHeader`.
- `PrimaryStatsStrip`.
- `LifeTimeline`.
- `AgeButton`.
- `LifeNavigationBar`.

Move logic into:

- `LifeViewModel`.
- `AgeUpUseCase`.
- `EventSelectionService`.
- `FinancialYearService`.
- `RelationshipProgressionService`.
- `FamilyProgressionService`.
- `HealthProgressionService`.
- `TimelineRepository`.

## 20.4 State management

The report does not identify a dedicated state-management package. Choose one consistent approach before the rebuild.

Recommended options:

- Riverpod, if the developer wants testable dependency injection and is already comfortable with it.
- Flutter's documented view-model approach with `ChangeNotifier`/`Listenable` for a smaller dependency footprint.

Do not mix several state-management patterns across features.

## 20.5 Persistence

### Required

- Keep local offline play.
- Add save schema version.
- Add migrations.
- Add transaction/checkpoint handling.
- Add corruption recovery.
- Add backup of the last valid save.
- Add explicit delete-life action.

### Recommended

- Auto-save after every completed decision and safe age-up stage.
- Display a small save status only when needed.
- Add export/import save file only after security and compatibility review.

## 20.6 Data model migration

Migrate gradually from one large 58-field `Character` object and parallel arrays toward composed typed models.

Suggested additions:

- `LifeSave` root object.
- `CharacterIdentity`.
- `CharacterStats`.
- `FinanceState`.
- `EducationState`.
- `CareerState`.
- `RelationshipState`.
- `PersonState` list.
- `BusinessState` list.
- `HealthState`.
- `EventHistory`.
- `TimelineEntry` list.
- `MetaProgress` remains cross-life.

Do not renumber or remove existing Hive fields without a migration strategy. Create new type IDs and convert old saves into the new root schema.

## 20.7 Error handling

- No silent catch blocks for simulation errors.
- Capture unexpected errors with context excluding sensitive player text.
- Recover to last valid save if age-up fails.
- Show a friendly error with retry/report options.
- Ensure errors cannot duplicate income, children, purchases, or life rewards.

# 21. Testing and Quality Assurance

## 21.1 Test strategy

Flutter recommends many unit and widget tests, supported by enough integration tests to cover important user journeys. The current four tests must be expanded substantially.

## 21.2 Unit tests

Required coverage:

- Stat clamping.
- Cash/debt calculations.
- Annual income and expenses.
- Debt interest.
- School eligibility, fees, progress, exams, and graduation.
- Job eligibility, application, salary, promotion, dismissal, and retirement.
- Relationship state transitions.
- Family ageing/death.
- Child ageing.
- Business profit/loss/failure.
- Health progression and treatment.
- Life goals.
- Death causes and life score.
- Event requirements and blockers.
- Event weights, cooldowns, and duplicate prevention.
- Deterministic random seeds.
- Save migrations.
- Reward idempotency.

## 21.3 Widget tests

Required:

- Character creation validation.
- Birth reveal.
- Life timeline rendering.
- Large text layouts.
- Choice dialog actions.
- Category screens.
- Empty states.
- Locked action requirements.
- Money/stat delta feedback.
- Death screen.
- Settings and privacy links.

## 21.4 Integration tests

Required end-to-end scenarios:

1. New install -> create character -> first age-up -> save -> relaunch -> continue.
2. Child -> school enrolment -> examination -> next education path.
3. Job application -> employment -> annual salary -> promotion.
4. Dating -> engagement -> marriage -> child.
5. Debt -> interest -> repayment/recovery.
6. Business start -> annual outcome -> investment -> closure/failure.
7. Illness -> treatment -> recovery/death.
8. Death -> legacy reward -> new life -> reward not duplicated.
9. Old save -> migration -> continued gameplay.
10. App killed during age-up -> restart -> no duplicate or corrupted state.

## 21.5 Simulation tests

Run thousands of headless lives to detect:

- Impossible progressions.
- Event starvation.
- Repetition.
- Unavoidable debt/death.
- Guaranteed wealth exploits.
- Careers that are never reachable.
- Broken chain events.
- Stat distributions stuck at extremes.
- Gender/region unfairness not justified by intentional simulation design.

## 21.6 Device matrix

Minimum manual/device-cloud matrix:

- Low-memory Android phone.
- Mid-range Android phone.
- Recent Samsung device.
- Pixel/Android emulator on current API.
- 64-bit-only Android environment.
- Small iPhone screen.
- Standard modern iPhone.
- Large iPhone.
- iPad if the app remains available for iPad.
- Light/dark system settings, even if the game initially supports only one in-app theme.
- Large text, VoiceOver, and TalkBack.

# 22. Analytics, Crash Reporting, and Product Validation

## 22.1 Minimum analytics events

- App opened.
- New life started.
- Character created.
- Birth reveal completed.
- Age-up started/completed/failed.
- Life stage reached.
- Event shown and choice selected.
- Category opened.
- Education started/completed/dropped.
- Job started/lost/quit.
- Relationship milestones.
- Business milestones.
- Debt threshold reached/recovered.
- Life completed.
- New life started after death.
- Tutorial/help shown.

## 22.2 Metrics

Primary launch metrics:

- First-life start rate.
- First age-up completion rate.
- Age 5, 13, 18, 30, and death reach rates.
- Average ages completed per session.
- New-life replay rate after death.
- Day 1 and Day 7 retention.
- Crash-free users/sessions.
- ANR rate.
- Event repetition complaints.
- Store rating and review themes.

## 22.3 Privacy rule

Only add analytics and crash SDKs after:

- SDK privacy audit.
- Google Play Data Safety mapping.
- Apple App Privacy mapping.
- Updated privacy policy.
- Consent implementation where legally/platform-required.

# 23. Accessibility and Platform Adaptation

## 23.1 Accessibility requirements

- Semantic labels for all icons and stat bars.
- VoiceOver and TalkBack navigation in logical order.
- Minimum touch targets.
- Text scaling without clipping.
- Contrast compliance.
- Do not communicate positive/negative outcomes only through green/red.
- Reduced-motion support.
- Haptic feedback must have a non-haptic equivalent.
- Dialog focus management.
- Accessible timeline headings by age.

## 23.2 Adaptive behaviour

- Respect safe areas, notches, rounded corners, and system bars.
- Support common phone widths without horizontal clipping.
- Use adaptive dialogs and page transitions where appropriate.
- Test tablet layout if distributed to tablets; do not simply stretch phone UI.
- Ensure keyboard/focus usability for desktop/web builds if those platforms remain supported internally.

# 24. Performance Requirements

## 24.1 Startup

- Defer non-critical content parsing and analytics initialization.
- Avoid loading the entire event library into expensive UI structures at launch.
- Measure time to first frame and full interactive display.
- Target clearly below Android's excessive startup thresholds: 5 seconds cold, 2 seconds warm, and 1.5 seconds hot.

## 24.2 Runtime

- Age-up simulation should feel immediate for normal saves.
- Long timeline lists must use lazy rendering.
- Avoid rebuilding the entire screen for small stat changes.
- Cache formatted timeline entries where safe.
- Profile memory after long simulated lives.
- Remove unused desktop platform assets from mobile release if they increase size unnecessarily.

## 24.3 Stability

- Monitor Android vitals and iOS crash reports.
- Set alerts for crashes and ANRs.
- Define a hotfix path and staged rollout.

# 25. Privacy and Security

## 25.1 Default Version 1.0 posture

Because the game can work entirely offline, the safest launch configuration is:

- No account required.
- No contact, location, photo, microphone, camera, or storage permission.
- No collection of character names.
- No advertising ID unless ads are introduced and fully disclosed.
- No unnecessary SDKs.

## 25.2 Required documents and disclosures

- Public privacy policy URL.
- In-app privacy policy link.
- Accurate Google Play Data Safety form.
- Accurate Apple App Privacy responses, including third-party SDK practices.
- Terms or EULA link if custom terms are used.
- Support contact.

## 25.3 Save security

The save contains fictional game data, but still:

- Validate imported/migrated data.
- Prevent arbitrary file execution.
- Avoid logging full save contents to third-party services.
- Protect purchase state against trivial duplication if IAP is added.

# 26. Monetization Readiness

Monetization should not be required for Version 1.0 unless the core game already passes retention and quality testing.

## 26.1 Recommended first products

- One-time **Remove Ads** purchase.
- Optional supporter pack with original themes or cosmetic timeline styles.
- Future expansion packs containing substantial new careers or life systems.

## 26.2 Ads principles

- No interstitial on every age-up.
- No ad during emotionally significant events or death sequence.
- Rewarded ads must be optional and provide clear value.
- Never design the simulation to create artificial suffering that requires an ad to fix.
- The app must remain playable without purchase.

## 26.3 Store billing

Digital goods must use the platform's permitted billing system for the applicable storefront and region. Purchase restoration, failure handling, entitlement persistence, and disclosure must be tested before release.

# 27. Google Play Store Readiness

## 27.1 Technical requirements

- Use Android App Bundle for release.
- Confirm 64-bit support.
- Target the required API level at submission time. From 31 August 2026, new apps and updates must target Android 16 / API 36 or higher, subject to Google's stated exceptions.
- Compile and test against the chosen API before submission.
- Verify signing and Play App Signing.
- Remove debug flags and test endpoints.
- Verify package name `com.wesleyconsults.ghanalifesim`.
- Confirm version code/version name policy.

## 27.2 Quality requirements

- Closed test with real users and multiple devices.
- No startup crash, broken navigation, placeholder copy, or debug controls.
- Monitor pre-launch report and Android vitals.
- Test permission rejection even if the intended release requests no dangerous permissions.
- Test offline launch and play.
- Test restore after process death.

## 27.3 Play Console content

- App name and short description.
- Full description.
- Game category and tags.
- App icon.
- Feature graphic.
- Phone screenshots from production UI.
- Tablet screenshots if tablet distribution remains enabled.
- Content rating questionnaire.
- Target audience and content declaration.
- Data Safety form.
- Privacy policy.
- Ads declaration.
- App access instructions if any content is gated.
- Support email and website.

## 27.4 Recommended store positioning

Do not position the app as a clone. Suggested message:

> Live a complete Ghanaian life from birth to death. Face school pressure, family expectations, jobs, side hustles, love, money, business, health, and the consequences of every choice.

# 28. Apple App Store Readiness

## 28.1 Product originality

The app must be visibly original and not a minor visual variation of BitLife. Ghanaian systems, original writing, original visual design, and distinctive product depth are essential for review and long-term brand safety.

## 28.2 App quality

- No placeholder screens.
- No broken links.
- No debug or "SIM LIFE" developer control.
- Full review access without requiring an unavailable account.
- Review notes explaining the game loop and any non-obvious content.
- Stable performance on supported iPhones and iPads.

## 28.3 App Store Connect information

- App name, maximum 30 characters.
- Subtitle, maximum 30 characters.
- Privacy policy URL.
- Required age rating.
- Primary and secondary category/subcategory.
- Description, keywords, promotional text, support URL, and marketing URL where used.
- Production screenshots for each required device family.
- App privacy answers that include the practices of integrated third-party SDKs.
- Export compliance answers.
- Content rights confirmation.
- DSA trader status/information where applicable.

## 28.4 Review-risk content

Because the game may contain gambling, crime, relationships, illness, alcohol, death, or mature humour:

- Complete age-rating questions accurately.
- Keep simulated gambling clearly fictional and avoid real-money mechanisms.
- Do not target children unless the entire design and data practice meet children's requirements.
- Avoid misleading reward or purchase language.

# 29. Store Assets and ASO Deliverables

Prepare:

- Final icon with original Ghana Life Sim branding.
- 6-8 phone screenshots telling one coherent life story.
- Optional preview video after UI is final.
- Feature graphic for Google Play.
- Short description.
- Long description.
- Apple subtitle and keyword set.
- Privacy policy.
- Support page.
- Press kit with logo and screenshots.

Suggested screenshot narrative:

1. "Live a Ghanaian life from birth to death."
2. "Every choice changes your story."
3. "Survive school, exams, and family pressure."
4. "Build a career - or chase a side hustle."
5. "Find love, raise a family, and face the drama."
6. "Manage money, rent, debt, homes, and businesses."
7. "Your past choices return later."
8. "See your legacy and live again."

# 30. Implementation Roadmap

## Phase 0 - Baseline and protection

- Freeze current working build.
- Tag repository and back up signing/configuration.
- Add golden save files for migration tests.
- Record current screenshots and core flows.
- Add crash logging locally and central error abstraction.
- Clean all analyzer warnings.
- Remove theme inconsistency.

**Exit criteria:** Current build remains reproducible and tests pass.

## Phase 1 - Architecture extraction

- Introduce simulation/domain layer.
- Extract age-up engine from `LifeScreen`.
- Add deterministic RNG.
- Add timeline result model.
- Add repository interfaces.
- Expand tests for existing behaviour before changing rules.

**Exit criteria:** Age-up can run and be tested without a widget.

## Phase 2 - New shell and design system

- Create central theme tokens.
- Build welcome/continue screen.
- Rebuild character creation.
- Build birth reveal.
- Build timeline-first Life Screen.
- Build new navigation and choice components.

**Exit criteria:** A player can create a life and progress through the existing simulation using the new UI.

## Phase 3 - Simulation cohesion

- Add Year in Review.
- Add event IDs/history/cooldowns.
- Add chain framework.
- Introduce life-stage feature unlocks.
- Redesign activities/time allowance.
- Rebalance visible/secondary stats.

**Exit criteria:** Choices and annual changes are clearly understandable.

## Phase 4 - Ghanaian progression depth

- Education branching, exams, TVET/apprenticeship, tertiary options, and NSS.
- Career role expansion.
- Relationship and family lifecycle improvements.
- Family deaths and milestone events.
- Economy configuration and balancing.

**Exit criteria:** At least five clearly distinct viable life paths exist.

## Phase 5 - Typed data and save migration

- Introduce person, business, illness, and timeline models.
- Build migration from existing Hive save.
- Add backup and corruption recovery.
- Test kill/restart at every critical save point.

**Exit criteria:** Existing test saves migrate without data loss or crashes.

## Phase 6 - Quality, accessibility, and performance

- Complete unit/widget/integration suites.
- Run headless life simulations.
- Accessibility audit.
- Performance profile.
- Device matrix testing.
- Fix all release blockers.

**Exit criteria:** Release candidate meets acceptance criteria in Section 32.

## Phase 7 - Store preparation and beta

- Analytics/privacy finalisation.
- Store metadata and screenshots.
- Google Play closed test.
- TestFlight internal and external beta.
- Collect structured feedback.
- Fix crashes, confusing flows, repetition, and balance problems.

**Exit criteria:** No critical issues; store submissions complete.

## Phase 8 - Production and monitoring

- Staged Android rollout.
- Manual or phased iOS release.
- Monitor crashes, ANRs, reviews, retention, and save failures.
- Ship hotfixes before adding major content.

# 31. Priority Backlog

## P0 - Must complete before store submission

- Timeline-first Life Screen.
- Remove developer-only SIM LIFE control from production.
- Extract age-up logic from UI.
- Deterministic RNG and stable event IDs.
- Safe save schema/migration/versioning.
- Expanded automated tests and integration tests.
- Analyzer clean.
- Original central design system.
- Privacy policy and accurate platform disclosures.
- Accessibility baseline.
- Store assets and metadata.
- Target SDK/64-bit/signing checks.
- Crash/ANR monitoring plan.

## P1 - Strongly recommended before Version 1.0

- Birth reveal and progressive tutorial.
- Event chains and cooldowns.
- Year in Review financial summary.
- Education branching and NSS.
- Family ageing/death.
- Friend system with a small significant-person limit.
- Typed person/business/illness models.
- Sound and haptics.
- Headless balance simulation.

## P2 - Post-launch expansions

- Deep crime and prison.
- Politics/chieftaincy.
- Migration/japa and travel.
- Cars, land, investments, wills, and inheritance.
- Detailed adult lives for children and siblings.
- Playable descendants.
- Cloud sync and accounts.
- Leaderboards.
- Large expansion packs.
- Advanced fame/social media systems.

# 32. Release Acceptance Criteria

## Product

- A new player can start a life without reading a multi-page tutorial.
- The player understands how to age up and make a choice within the first session.
- The timeline is the dominant screen element.
- Major decisions show immediate feedback and can cause later consequences.
- At least five distinct life paths are achievable.
- A full life can be completed without getting stuck.
- Death produces a meaningful summary and a clear replay action.

## UX

- No production screen contains debug controls or placeholder copy.
- Core actions are reachable with one or two taps from the relevant category.
- Text remains usable at large accessibility sizes.
- No clipped content on the supported device matrix.
- All destructive actions require confirmation.
- The interface is original and clearly Ghana Life Sim.

## Engineering

- `flutter analyze` has no unresolved errors or warnings accepted without documentation.
- Unit, widget, migration, and integration tests pass.
- Age-up, event selection, finance, and reward recording are deterministic in tests.
- App restart during critical flows does not duplicate or lose transactions.
- Old saves either migrate safely or receive a transparent, safe reset path.
- Release builds contain correct signing, IDs, versioning, and production configuration.

## Performance and stability

- No known P0/P1 crash.
- Cold launch is comfortably below platform excessive-startup thresholds on target devices.
- Long timelines remain smooth.
- Closed-beta crash-free rate and ANR rate meet the team's defined targets.
- No memory growth indicating a leak during long-life testing.

## Store and privacy

- Accurate privacy policy and store disclosures.
- Accurate age/content rating.
- Required screenshots and metadata complete.
- Google Play target API requirement met at submission date.
- Apple review notes complete.
- Third-party SDK list audited.
- Digital purchases, if present, use approved billing and restore correctly.

# 33. Validation Plan

Before locking the final UI and balance, test with at least:

- 5 players familiar with BitLife.
- 5 Ghanaian players unfamiliar with BitLife.
- 3 players using lower-end Android devices.
- 2 accessibility-focused sessions using large text and a screen reader.

Key tasks:

1. Start a new life without assistance.
2. Explain what the four primary stats mean.
3. Age up three times.
4. Find school/work/relationship actions.
5. Explain why money changed after a year.
6. Identify one past decision that affected a later event.
7. Complete or observe a death summary and start again.

Success thresholds should be set before testing. Example targets:

- 90 percent start a life without help.
- 90 percent find the Age button immediately.
- 80 percent correctly explain the latest financial change.
- 80 percent understand where to find people and activities.
- 70 percent express a clear desire to try a different life after death.

# 34. Risks and Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Scope expands toward full BitLife parity | Release never finishes | Lock Version 1.0 scope and move expansions to P2 |
| UI becomes a direct copy | Store/IP risk | Use original design tokens, layout, copy, iconography, and Ghanaian systems |
| Save migration corrupts existing games | Player trust loss | Versioned root schema, backups, fixtures, migration tests |
| Event library becomes repetitive | Retention loss | Cooldowns, chains, coverage testing, event analytics |
| Ghanaian content becomes stereotypical | Brand harm | Diverse writing, sensitivity review, balanced life paths |
| Economy is exploitable or punishing | Poor replayability | Config-driven values and thousands of simulated lives |
| Refactor breaks existing systems | Delays | Characterisation tests before behaviour changes |
| Ads reduce narrative flow | Poor reviews | Launch without ads or use restrained placements after retention validation |
| Platform policies change | Submission delay | Recheck official requirements immediately before release |

# 35. Definition of Done for Each Feature

A feature is complete only when:

- Product behaviour is documented.
- UI states include loading, empty, success, failure, and locked states where applicable.
- Accessibility labels and text scaling are tested.
- Analytics are added only if approved by privacy mapping.
- Unit/widget/integration tests are added at the appropriate layer.
- Save migration is handled if the feature changes persistence.
- Content is reviewed for cultural quality.
- Android and iOS release builds are tested.
- Acceptance criteria pass.

# 36. Final Product Decision

Ghana Life Sim should not try to win by being "BitLife with Ghanaian names." It should win by being the easiest, funniest, and most replayable way to live a recognisably Ghanaian life on mobile.

The correct rebuild is therefore:

- BitLife-inspired in speed, readability, and life-timeline interaction.
- Original in visual identity and screen composition.
- Ghanaian in systems, pressures, opportunities, language, humour, and consequences.
- Focused in Version 1.0 scope.
- Architected for years of content expansion after launch.

The first polished release is ready only when the core loop feels coherent from birth to death, the app survives real-world device and save-state testing, the store presentation reflects the production experience, and players finish one life wanting to immediately begin another.

# Appendix A - Suggested New Models

```text
LifeSave
  schemaVersion
  lifeSeed
  character
  people[]
  businesses[]
  illnesses[]
  eventHistory
  timeline[]
  worldState
  pendingDecision
  lastSafeCheckpoint

Character
  identity
  primaryStats
  secondaryStats
  traits
  finance
  education
  career
  housing
  health
  activeGoal
  flags

Person
  id
  name
  gender
  birthYear
  relationType
  alive
  bond
  location
  occupation
  personality
  relationshipState
  flags

TimelineEntry
  id
  age
  year
  type
  title
  body
  deltas[]
  relatedEntityIds[]
  sourceEventId
  importance
```

# Appendix B - Event Authoring Template

```yaml
id: education.wassce.results.v1
version: 1
category: education
lifeStages: [teenager]
ageRange: [17, 19]
baseWeight: 100
priority: major
cooldownYears: 999
maxOccurrences: 1
requirements:
  educationState: shs_final_year
blockedFlags:
  - wassce_completed
choices:
  - id: celebrate
    text: Celebrate with your friends
    effects:
      happiness: 4
      cash: -80
    outcome: You celebrated the end of a difficult school chapter.
  - id: plan_next_step
    text: Discuss the next step with your family
    effects:
      familyBond: 3
      discipline: 2
    addFlags:
      - tertiary_planning_started
    outcome: Your family began weighing university, training, and work options.
contentTags:
  - education
  - examination
  - ghana
ratingTags: []
```

# Appendix C - Release Checklist

## Common

- [ ] Production app name and IDs confirmed.
- [ ] Version and build numbers increased.
- [ ] Release signing verified.
- [ ] Debug menu disabled.
- [ ] Test data and test ad IDs removed or correctly gated.
- [ ] Privacy policy live.
- [ ] Support page live.
- [ ] Crash reporting tested.
- [ ] Analytics disclosure verified.
- [ ] All purchases tested, if included.
- [ ] Full offline play tested.
- [ ] Fresh install tested.
- [ ] Upgrade/migration tested.
- [ ] Process-kill recovery tested.
- [ ] Accessibility tested.
- [ ] Store screenshots match production build.

## Google Play

- [ ] Android App Bundle generated.
- [ ] Target API requirement verified on submission day.
- [ ] 64-bit support verified.
- [ ] Play App Signing configured.
- [ ] Data Safety complete.
- [ ] Content rating complete.
- [ ] Target audience declaration complete.
- [ ] Ads declaration complete.
- [ ] Closed test feedback resolved.
- [ ] Pre-launch report reviewed.

## Apple

- [ ] Distribution certificate/profile valid.
- [ ] Archive uploaded and processed.
- [ ] TestFlight internal test complete.
- [ ] External beta feedback resolved where used.
- [ ] App Privacy published.
- [ ] Age rating complete.
- [ ] Export compliance complete.
- [ ] Screenshots complete by device family.
- [ ] Review notes and contact complete.
- [ ] Support and privacy URLs valid.
- [ ] IAP items submitted with the app where required.

# Appendix D - References

1. **Ghana Life Sim - Project Report.** Internal project document supplied by the product owner, last updated 9 July 2026.
2. **Deep Research Brief for an Unspecified Topic.** Internal research-method document supplied by the product owner, 26 July 2026.
3. **BitLife - Life Simulator, official App Store listing.** https://apps.apple.com/us/app/bitlife-life-simulator/id1374403536
4. **BitLife - Life Simulator, official Google Play listing.** https://play.google.com/store/apps/details?id=com.candywriter.bitlife
5. **Apple App Review Guidelines.** https://developer.apple.com/app-store/review/guidelines/
6. **Apple App Store Connect - Manage app privacy.** https://developer.apple.com/help/app-store-connect/manage-app-information/manage-app-privacy
7. **Apple App Store Connect - App information reference.** https://developer.apple.com/help/app-store-connect/reference/app-information/app-information
8. **Google Play target API level requirement.** https://developer.android.com/google/play/requirements/target-sdk
9. **Android vitals.** https://developer.android.com/topic/performance/vitals
10. **Android app startup time.** https://developer.android.com/topic/performance/vitals/launch-time
11. **Flutter guide to app architecture.** https://docs.flutter.dev/app-architecture/guide
12. **Flutter testing overview.** https://docs.flutter.dev/testing/overview
13. **Flutter accessibility guidance.** https://docs.flutter.dev/ui/accessibility

*External platform requirements were checked on 26 July 2026 and must be rechecked immediately before submission because policies and technical requirements change.*
