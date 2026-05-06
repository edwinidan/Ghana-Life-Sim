# Ghana Life Sim Playability Roadmap

This roadmap focuses on the highest-impact changes first so the game becomes more playable, more replayable, and closer to the "one more year" feel of BitLife while still building on the Ghana-specific identity already in the project.

## Core Goal

Make each life feel:

- More reactive to player choices
- Less random-for-random's-sake
- More financially and socially believable
- More dramatic over time through chained consequences

## Priority 1: Upgrade The Event Engine

This is the highest-impact area. Right now the game has a lot of content, but the yearly flow is still too flat because events are mostly picked from a broad valid pool.

### Why this matters

- This is the main loop the player feels every year
- Better event selection instantly improves replayability
- It makes stats, careers, housing, and relationships matter more

### Current pain points

- `statRequirements` exist in `lib/models/event.dart` but are not used when filtering events in `lib/screens/life_screen.dart`
- Only one random valid event is usually selected per year
- Events do not strongly build on previous outcomes
- `careerToSet` exists on `EventChoice` but is not applied after selecting a choice

### Implementation goals

- Filter or weight events using stat thresholds
- Introduce weighted event selection instead of flat random selection
- Allow some years to trigger multiple events
- Add consequence flags so earlier choices unlock later events
- Apply event-side effects beyond raw stat changes

### Concrete changes

#### 1. Use event stat requirements

In `lib/screens/life_screen.dart`:

- Check `e.statRequirements` during event validation
- Reject events when required stats are not met
- Later, optionally convert this into a weighting system instead of a hard filter

#### 2. Add weighted event selection

Instead of:

- taking all valid events
- choosing one random event

Do this:

- assign each event a base weight
- boost weight when the event matches the current life situation
- reduce weight when a similar event happened recently

Suggested weight boosters:

- current life stage
- low health
- being in school
- being unemployed
- being in a relationship
- owning a business
- low money
- high reputation

#### 3. Support multi-event years

Suggested rule:

- Ages 0-12: 1 event
- Ages 13-25: 1-2 events
- Ages 26-60: 1-2 events
- Ages 61+: 1-3 events with more health/family events

This will make adulthood feel fuller and less empty.

#### 4. Apply richer event outcomes

In `_makeChoice()` inside `lib/screens/life_screen.dart`:

- apply `careerToSet` when present
- add support for future fields like:
  - `relationshipStatusToSet`
  - `housingStatusToSet`
  - `flagToAdd`
  - `cashChange`
  - `childNameToAdd`

#### 5. Add consequence flags

Extend `Character` with a lightweight list like:

- `List<String> flags`

Example flags:

- `got_scholarship`
- `family_disappointed`
- `went_viral`
- `criminal_record`
- `church_favorite`
- `known_cheater`
- `dropout`
- `abroad_returnee`

Then gate future events using those flags.

### Definition of done

- Events respond to stats and current life state
- Event choices can trigger real branching outcomes
- Some lives feel career-heavy, some romance-heavy, some struggle-heavy
- Players can clearly feel that earlier decisions shape later years

## Priority 2: Fix The Economy

The economy is the second highest-impact system because money is central to jobs, housing, business, schooling, and status.

### Why this matters

- BitLife-style games become addictive when money changes your options
- Right now income exists, but the financial simulation is still too abstract
- The game needs stronger tradeoffs and resource pressure

### Current pain points

- `money` is treated like a 0-100 stat in `lib/models/character.dart`
- jobs and businesses use real-seeming GHS income numbers, but those are compressed back into tiny yearly stat gains
- `sideGigIncome` is computed but not paid out during age-up
- school costs and housing costs exist, but financial pressure is still too light

### Implementation goals

- Separate wealth from the abstract stat model
- Make salaries, side gigs, and businesses meaningfully affect the player
- Add recurring expenses and financial risk
- Make big life choices require real tradeoffs

### Concrete changes

#### 1. Add a real cash field

In `lib/models/character.dart`, add something like:

- `int cash`

Use this for:

- school fees
- wedding costs
- moving out
- buying a home
- starting a business
- medical bills
- family support requests

Keep `money` only if you want it to represent financial stability or status, otherwise replace it fully.

#### 2. Pay all income streams during age-up

In `lib/screens/life_screen.dart`:

- add career income payout
- add side gig payout
- add business income payout

Use cash for payouts, not the 0-100 stat.

#### 3. Add yearly expenses

Examples:

- rent
- child support
- school fees
- wedding expenses
- medical treatment
- business maintenance
- funeral contributions
- helping family members

#### 4. Add debt and emergency pressure

Add a simple debt system:

- `int debt`

Possible sources:

- hospital bills
- failed business
- wedding spending
- job loss
- reckless choices

Consequences:

- lower happiness
- reputation hits
- blocked housing/business choices
- debt-collection events

#### 5. Rebalance cost scaling

Current costs like:

- moving out
- buying a home
- marriage
- childbirth

should all use cash and feel meaningfully different from each other.

### Definition of done

- Money changes what the player can and cannot do
- Side gigs and business feel worth pursuing
- Financial problems create drama
- Big milestones feel earned

## Priority 3: Deepen Relationship And Family Systems

This is the third highest-impact area because relationships are where a lot of BitLife-style emotional stickiness comes from.

### Why this matters

- Relationships create long-term storylines
- Family pressure is culturally important for this game
- Romance, cheating, children, and marriage should create ripple effects

### Current pain points

- breakup and divorce currently use the same method flow
- children are tracked only as a number
- partners have a name, job, and personality, but not much long-term behavior
- family obligations are not yet a major gameplay force

### Implementation goals

- Separate dating, engagement, marriage, breakup, and divorce properly
- Make children into simple tracked people
- Add family pressure and social consequences
- Make relationships produce more follow-up events

### Concrete changes

#### 1. Split breakup from divorce

In `lib/services/relationship_service.dart`:

- create `breakUp()`
- create `callOffEngagement()`
- keep `divorce()` for marriage only

Update `lib/screens/social_screen.dart` to use the correct action for each status.

#### 2. Track children as records

Replace or supplement `numberOfChildren` with something like:

- child name
- age
- gender
- bond score
- education progress
- behavior trait

This does not need full simulation yet. A light child record is enough for v1.5 depth.

#### 3. Add partner events

Examples:

- partner loses job
- partner wants marriage
- partner wants a child
- partner catches you cheating
- partner asks for money
- in-law drama
- breakup over distance

#### 4. Add family pressure system

Examples:

- younger siblings need fees
- parents ask for support
- funeral contribution pressure
- aunties asking when you will marry
- family disappointment after dropping out

### Definition of done

- Relationships feel like ongoing storylines, not just labels
- Children create future choices and costs
- Family can help or burden the player
- Romance has real upside and real risk

## Priority 4: Add Player Actions Between Age-Ups

Once the first three priorities are in place, the next best improvement is giving the player more intentional actions outside the random event system.

### Why this matters

- BitLife feels sticky because the player can always choose to do something
- This reduces the feeling of just pressing "Age Up" and waiting

### Suggested actions

- Study harder
- Visit doctor
- Go to gym
- Spend time with partner
- Spend time with child
- Pray / attend church
- Party
- Apply for jobs
- Ask family for help
- Send money home
- Gamble
- Rest for mental health

### Best place to add these

- `lib/screens/life_screen.dart`
- `lib/screens/social_screen.dart`
- `lib/screens/job_screen.dart`
- `lib/screens/school_screen.dart`

## Priority 5: Add More Ghana-Specific Long-Term Pressure

This is where the game can become more distinctive than a generic BitLife clone.

### Best systems to add

- dumsor affecting business and study
- remittance pressure from family
- wedding and funeral contribution culture
- church reputation
- landlord and compound-house stress
- trotro and transport frustration
- "abroad" opportunities and returnee status
- political/campus/student drama
- social-media shame and fame

## Suggested Implementation Order

### Phase 1: Event engine foundation

1. Use `statRequirements`
2. Apply `careerToSet`
3. Add event weighting
4. Add multi-event years
5. Add character flags

### Phase 2: Economy rewrite

1. Add `cash`
2. Add income payouts for all streams
3. Move school, housing, marriage, and business costs to cash
4. Add debt
5. Add emergency finance events

### Phase 3: Relationships and family

1. Split breakup/divorce logic
2. Add child records
3. Add partner-driven events
4. Add family pressure events

### Phase 4: Intentional actions

1. Health actions
2. Education actions
3. Relationship actions
4. Lifestyle and risk actions

### Phase 5: Ghana flavor expansion

1. Pressure systems
2. Local milestones
3. fame/scandal/compound reputation

## First Implementation Sprint

We should start here first:

1. Event engine wiring
2. Economy foundations

That means the first coding pass should likely cover:

- event stat requirement filtering
- `careerToSet` support in event choices
- side gig and business income payout during age-up
- introduction of a real `cash` field

## Files Most Likely To Change First

- `lib/models/character.dart`
- `lib/models/event.dart`
- `lib/screens/life_screen.dart`
- `lib/services/job_service.dart`
- `lib/services/business_service.dart`
- `lib/services/school_service.dart`
- `lib/services/relationship_service.dart`

## Notes

- The project already has a strong content base
- The next leap in quality comes from system wiring, not just adding more event text
- The best short-term win is making yearly progression feel more reactive and more expensive

