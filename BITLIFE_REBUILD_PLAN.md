# Ghana Life Sim — BitLife-Style Rebuild Plan

Created: 2026-07-09

## Goal

Transform Ghana Life Sim from a functional prototype into a polished, deep, replayable life simulator that feels closer to BitLife in depth, player freedom, consequence chains, and "one more year" addictiveness — while maintaining and deepening its unique Ghanaian cultural identity.

Success criteria: players finish a life, immediately start another, and each life feels genuinely different.

## Phase 1: Stabilize Before Rebuilding

**Duration estimate: 1-2 sessions**

### 1.1 Clean Analyzer Warnings
- Replace all `withOpacity()` with `withValues(alpha: ...)` across all screens
- Remove unnecessary `!` assertions in `character_creation_screen.dart`
- Remove unnecessary `dart:ui` import
- Fix triple underscores in PageRouteBuilder

**Why first:** Clean analyzer output makes real problems visible immediately.

### 1.2 Fix Theme Inconsistency
- Change `main.dart` ColorScheme to use `Brightness.light` since all screens use light backgrounds
- Or: make a single decision about dark vs light and align everything

### 1.3 Extract Age-Up Orchestration
- Create `lib/services/game_loop_service.dart` with `ageUp(Character)` method
- Move all system progression calls from `LifeScreen._ageUp()` into this service
- Keep event selection and UI in LifeScreen
- This makes the yearly progression testable in isolation
- This prevents LifeScreen from growing beyond its current 2210 lines

### 1.4 Add Basic Service Tests
- Test SaveService save/load/delete cycle
- Test SchoolService enrollment and graduation
- Test CareerService promotion checks
- Test HealthService life score calculation with known inputs
- Test RelationshipService state machine transitions

## Phase 2: Architecture Improvements

**Duration estimate: 2-3 sessions**

### 2.1 Shared Utilities
- Extract number formatting into `lib/utils/formatting.dart`
- Extract stat name → value mapping into `Character.getStat(String name)` method
- Deduplicate `_emojiForType` between BusinessService and BusinessScreen
- These reduce copy-paste and make future changes safer

### 2.2 Seedable RNG
- Pass a single `Random` instance through service methods (or use a seedable RNG)
- Enables deterministic testing of game logic
- Enables "replay this life" feature in future

### 2.3 Data-Driven Activities
- Move activity definitions from `ActivityService` constants to `lib/data/activities.dart`
- Use same pattern as careers, businesses, side gigs
- Makes adding new activities a data change, not a code change

### 2.4 Clean Up Legacy Fields
- Remove or deprecate `Character.job` (field 13) — unused, replaced by `careerPath`
- Audit `Character.education` (field 14) usage — mostly replaced by `educationLevel`
- Document which fields are legacy in the model

## Phase 3: Deepen Core Life Simulation

**Duration estimate: 4-6 sessions**

This is the highest-impact phase. Each sub-phase makes lives feel more different from each other.

### 3.1 More Things Between Age-Ups

Currently 11 activities. BitLife has 50+. Target: expand to 25-30.

New activity categories:
- **Education**: Attend extra classes, cheat on exam, bribe teacher, skip school
- **Career**: Ask for raise, slack off, sabotage colleague, network
- **Social**: Make friend, end friendship, gossip, throw party
- **Family**: Visit parents, argue with sibling, ask family for money, send money home
- **Romance**: Go on date, give gift, start argument, ask for forgiveness
- **Health**: Eat healthy, drink, smoke, traditional medicine
- **Risky**: Pickpocket, scam, bribe official, sell fake goods
- **Spiritual**: Consult pastor, visit mallam, fast and pray, give offering
- **Leisure**: Travel, watch football, go to beach, read novel

Each activity should:
- Consume action energy
- Have stat requirements for availability
- Have random outcomes (not always the same result)
- Create flags for future event chains

### 3.2 Random Stat Decay Per Age-Up
Currently only health decays with age. Add small random drift to all stats:
- Happiness: -3 to +1 per year
- Looks: -1 per year after 30
- Discipline: -2 to +2 depending on life situation
- Reputation: small random drift based on recent events

This makes stat management more important and lives feel less static.

### 3.3 More Action Energy Granularity
Currently 3 energy per year (2 for toddlers).
- Teenagers: 4 energy
- Young adults: 5 energy
- Adults: 4 energy
- Middle aged: 3 energy
- Seniors: 2 energy

More energy = more player agency in prime years.

### 3.4 Random Trait System
Add 2-3 random personality traits at character creation that affect stat drift:
- "Hardworking": +1 discipline/year, -1 happiness/year
- "Lazy": -1 discipline/year, +1 happiness/year
- "Charming": +2 to relationship drift
- "Troublemaker": +5 to risky activity success, more random negative events
- "Blessed": small random positive events more often
- "Spiritual": church activities give double reputation

This gives each character a built-in "play style" tendency.

## Phase 4: Deepen Relationships and Family

**Duration estimate: 3-4 sessions**

### 4.1 Family Members Age and Die
- Parents die naturally in their 60s-80s based on starting age
- Sibling gets married, has children, moves away
- Events fire when family members die (funeral costs, inheritance, grief)
- `ensureFamilySeeded()` adds more variety (aunt, uncle, grandparent)

### 4.2 Children Grow Up
- Children reach milestones: start school at 4, JHS at 10, SHS at 13
- At 18, children may leave home (go to university, move out, stay)
- Children's choices affect parent: pride events, disappointment events, requests for money
- Adult children may have their own children (player becomes grandparent)

### 4.3 Deeper Partner Simulation
- Partners have their own income that contributes to household
- Partner may lose job, get promoted, start business
- Partner may develop health issues
- Partner personality affects more than just relationship drift:
  - "Ambitious" partner pushes you to earn more
  - "Spiritual" partner wants you at church more
  - "Jealous" partner restricts your social activities
  - "Clingy" partner costs more action energy

### 4.4 In-Law System
- After marriage, generate in-laws (mother-in-law, father-in-law)
- In-law events: visits, requests for money, family drama
- In-law approval score affects marriage stability

### 4.5 Multiple Relationships Per Life
- After divorce/widowhood, can find new partner
- Track ex-partners for potential drama events
- Remarriage possible

### 4.6 Friendship System
- Track 2-3 named friends
- Friend events: borrowing money, getting in trouble, celebrations
- Friends affect happiness and connections
- Falling out with friends affects reputation

## Phase 5: Improve School, Career, and Money

**Duration estimate: 3-4 sessions**

### 5.1 Exam Events
- Actual exam events during school years
- BECE at end of JHS, WASSCE at end of SHS
- University exams each year
- Results affect smarts, reputation, and future options
- Cheating is possible with risk

### 5.2 Career Depth
- Job-specific random events: office politics, difficult boss, big project
- Firing/retrenchment risk (higher at low discipline/performance)
- Job switching: apply for new jobs while employed
- Multiple job offers to compare
- Workplace rivalries and alliances
- Salary negotiation events

### 5.3 More Career Paths
- Add: Law, Media/Journalism, Sports, Agriculture, Military/Police, NGO/Development
- Each with Ghana-specific flavor (e.g., "NGO Worker" dealing with donor reports)

### 5.4 Side Hustle Depth
- Side gigs can grow into full businesses
- Some side gigs have risk (e.g., Uber driver gets into accident)
- Side gig income fluctuates based on economy and luck

### 5.5 Financial Depth
- Savings accounts with interest
- Investment options (T-bills, land, stocks)
- Loan options from banks (not just debt from shortfalls)
- Microfinance/susu system with community pressure
- Remittance system: family abroad sends money, or you send money home
- Emergency fund events: medical emergency, family funeral contribution

### 5.6 Asset Ownership
- Beyond housing: car, land, investments
- Assets affect reputation and connections
- Assets can be sold in emergencies
- Car accidents, land disputes as event sources

## Phase 6: Improve Events and Consequences

**Duration estimate: 3-4 sessions**

### 6.1 Event Chains
Create multi-year story arcs using flags:
- "Scholarship opportunity" → study abroad → return as "been-to" → job opportunities
- "Start small business" → grow → competitor appears → business war → resolution
- "Church volunteer" → deacon → pastor asks for donation → church politics
- "Political involvement" → campaign volunteer → party position → corruption dilemma
- "Family feud" → escalation → mediation → reconciliation or permanent split

### 6.2 More Flag-Gated Events
Ensure every major choice flag has at least one follow-up event:
- `got_scholarship` → study abroad events
- `criminal_record` → police harassment, job rejection
- `went_viral` → fame management events
- `family_disappointed` → reconciliation attempts
- `church_favorite` → church leadership pressure

### 6.3 Seasonal/Periodic Events
- Christmas events (spending pressure, family gatherings)
- Easter events
- Election year events (political tension, opportunities)
- World Cup/AFCON events (when Ghana plays)

### 6.4 More Ghana-Specific Systems
- Dumsor (power outage) system: random outages that affect business, study, happiness
- Chieftaincy: rare path where family becomes involved in chieftaincy disputes
- "Japa" (emigration) mechanic: visa lottery, abroad opportunities, returnee status
- Funeral contribution pressure: periodic requests for funeral donations
- Naming ceremony (outdooring) for children
- Traditional marriage (engagement ceremony) as separate from wedding
- Land guard / land litigation events

## Phase 7: Improve UI/UX

**Duration estimate: 3-4 sessions**

### 7.1 Smoother Transitions
- Slide transitions between screens
- Event choices have subtle animation on selection
- Age-up has a brief "year passing" animation
- Life stage transition is already good — keep and polish

### 7.2 Stat Change Indicators
- When stats change, show brief +/- indicators (e.g., "+5 Health")
- Color-code: green for positive, red for negative
- Accumulate changes from event choice and show summary

### 7.3 Better Event Presentation
- Events should show which stats/requirements triggered them
- Color-coded event types (health=red, career=blue, relationship=pink, etc.)
- Consequence preview: show potential stat changes before choosing (optional, as premium feature)

### 7.4 Action Feedback
- Activities show outcome animation
- Success/failure has distinct visual treatment
- Energy bar is more prominent

### 7.5 Polish
- Add haptic feedback on key actions (age-up, major events)
- Sound effects for age-up, death, marriage, childbirth
- Background music (light highlife instrumental)
- Achievement unlocked notifications during life (not just at death)
- Pull-to-refresh on life log

### 7.6 Improved Death Screen
- Animated stat reveal (count up numbers)
- Share life summary as image (for social media)
- "Life recap" with key moments highlighted
- Compare this life to previous lives

## Phase 8: Monetization (Only After Gameplay is Strong)

**Duration estimate: 2-3 sessions**

### 8.1 Rewarded Ads
- Watch ad to reroll a bad event outcome
- Watch ad for extra action energy
- Watch ad for small cash boost
- Never interrupt gameplay — always opt-in

### 8.2 Premium Features
- Ad removal (one-time purchase)
- Extra activity slots
- More starting trait choices
- "God mode" — see stat change previews before choosing
- Additional career paths
- Additional event packs

### 8.3 No Pay-to-Win
- Premium features add options, not guaranteed advantages
- Core game must be fully enjoyable for free players
- Monetization is about convenience and variety, not power

## Implementation Priority Matrix

| Priority | Phase | Impact | Effort |
|---|---|---|---|
| 1 (immediate) | Phase 1: Stabilize | Low | 1-2 sessions |
| 2 (next) | Phase 2: Architecture | Medium | 2-3 sessions |
| 3 | Phase 3.1: More activities | High | 2-3 sessions |
| 4 | Phase 3.4: Traits system | High | 1 session |
| 5 | Phase 4.1-4.2: Family/children depth | High | 2-3 sessions |
| 6 | Phase 6: Event chains | High | 3-4 sessions |
| 7 | Phase 5: School/career/money depth | High | 3-4 sessions |
| 8 | Phase 4.3-4.6: Partner/friends depth | Medium | 2-3 sessions |
| 9 | Phase 7: UI polish | Medium | 3-4 sessions |
| 10 (last) | Phase 8: Monetization | Medium | 2-3 sessions |

## First Sprint Recommendation

Start with these items in order:

1. **Clean analyzer warnings** (Phase 1.1) — quick win, improves signal
2. **Extract GameLoopService** (Phase 1.3) — prevents LifeScreen from growing, enables testing
3. **Add 10-15 new activities** (Phase 3.1) — immediately makes game feel richer
4. **Add personality traits** (Phase 3.4) — makes every life feel different from creation
5. **Family death events** (Phase 4.1) — adds emotional weight and realism
6. **First event chain** (Phase 6.1) — prove the compound-consequence concept

This sprint would produce visible, playable improvements while improving code quality.

## What NOT to Do

- Don't add multiplayer, cloud saves, or accounts until v1 gameplay is excellent
- Don't add monetization until the free experience feels complete
- Don't rewrite entire systems that work — incrementally improve
- Don't remove Ghanaian flavor — it's the project's unique value
- Don't copy BitLife exactly — BitLife is a reference for depth and feel, not a template to clone
- Don't let LifeScreen grow past 2500 lines — extract widgets and services aggressively
- Don't change Hive field numbers — always append

## Success Metrics

After completing the rebuild plan, the game should achieve:
- Average session length: 15+ minutes per life
- Replay rate: player starts new life immediately after death
- Stat spread: no two lives produce identical stat distributions
- Event variety: player sees <30% of total events in a single life
- Cultural authenticity: Ghanaian players recognize their experience
- Emotional engagement: players feel the weight of major life choices
