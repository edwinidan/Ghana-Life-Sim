# Ghana Life Sim — Game Flow Preview

## 1. Purpose Of This Document

This document maps the current Ghana Life Sim game from the player's point of view. It describes what a player sees, does, and experiences from first launch through death and restart. It is based on the current codebase implementation as of July 2026, not on old documentation or future plans.

The goal is to make the complete player journey visible — what works, what feels full, and where the experience is thin.

## 2. High-Level Game Loop

```text
Launch App
  ↓
Onboarding (first time only) / Existing Save Check
  ↓
Character Creation (or Continue Saved Life)
  ↓
Life Dashboard
  ↓
Age Up / Activities / Navigation Between Screens
  ↓
Events + Player Choices + Consequences
  ↓
Life Progression (school, career, relationships, housing, business, health, money)
  ↓
Death at health ≤ 0 or age ≥ 90
  ↓
Death Screen (score, rating, ribbon, achievements, life log)
  ↓
Legacy + Restart ("Live Again")
```

The core loop is: view your life dashboard, use activities, navigate to screens to make decisions (enroll in school, apply for jobs, date, move out, start businesses), then tap "Age Up" to advance one year. Each age-up progresses all systems, may trigger random events, and saves the game.

## 3. First-Time User Flow

A new user opening the app for the first time:

1. **App launches.** The app initializes Hive storage and SharedPreferences.

2. **Routing check.** The app checks if the user has seen onboarding. Since it's a first launch, `onboarding_seen` is `false`.

3. **Onboarding screen.** A 4-page swipeable onboarding carousel appears:
   - Page 1: "Welcome to Ghana Life Sim" — explains you control one life from birth to death
   - Page 2: "Your Stats Are Everything" — introduces Health, Happiness, Money, Smarts
   - Page 3: "Study Hard. Hustle Harder." — introduces school and job tabs
   - Page 4: "Life Is Not Just Work" — introduces relationships and businesses
   - Each page has a "Skip" button. The last page has "Start My Life" instead.

4. **Character creation screen.** After onboarding (or skip), the player arrives at character creation. The player enters a name and selects Male or Female. A card shows "Randomizing Traits..." indicating stats will be randomized. The player taps "Begin Your Life."

5. **Life begins.** The character is created with randomized stats, a starting family (mother, father, possibly a sibling), random starting cash (GHS 400–2,500), starting age 0, and a randomly assigned life goal. The game auto-saves immediately.

6. **Life dashboard.** The player sees their newborn character on the main life screen. Age is 0. Stage is "Toddler." Stats are visible. At this age, most screens are locked or empty.

**Auto-save:** The game saves after character creation, after every age-up, and after every activity or screen action that changes character state.

## 4. Returning User Flow

When the user already has a saved character:

1. **Onboarding check.** If `onboarding_seen` is `true`, onboarding is skipped immediately.

2. **Save game check.** The app checks if a saved game exists via Hive:
   - **If a saved character exists AND is alive:** The app loads the character, seeds the family if needed, ensures a life goal is assigned, and sends the player directly to the Life Dashboard. The game resumes exactly where it left off.
   - **If a saved character exists BUT is dead:** The app sends the player to the death screen. From there, they can view legacy progress or tap "Live Again" to start a new life (which deletes the old save and goes to character creation).
   - **If no saved game exists:** The player is sent to character creation.

3. **Restart flow.** After death, the player taps "Live Again." The save is deleted. They return to character creation. Legacy progress (ribbons, achievements, completed life goals, lives completed count) is preserved across lives via SharedPreferences.

## 5. Character Creation Flow

The player can choose:

| Choice | Options | Details |
|--------|---------|---------|
| **Name** | Free text | Required. Cannot be empty. |
| **Gender** | Male or Female | Selected via card tap with visual confirmation. |

Everything else is randomized when the `Character` object is created:

| Randomized Attribute | Range |
|---------------------|-------|
| Health | 60–90 |
| Happiness | 50–80 |
| Smarts | 30–80 |
| Looks | 30–80 |
| Money stat | 5–30 |
| Reputation | 20–50 |
| Discipline | 20–70 |
| Street Sense | 20–60 |
| Connections | 10–40 |
| Starting Cash | GHS 400–2,500 |
| Starting Debt | GHS 0 |
| Life Goal | Randomly assigned from available pool |

The character also gets:
- A randomly generated mother and father with Ghanaian names, ages, and bond scores
- A 50% chance of a randomly generated sibling
- Starting age: 0
- Starting housing: "With Parents"
- Starting education: "None"
- Starting relationship: "Single"
- Action energy: 3 per year (2 for ages 0–5)

### What Character Creation Does Not Yet Include

Based on the current implementation, the following are not available during character creation:

- Personality traits selection
- Country or region selection (Ghana is fixed)
- Family background or wealth class selection
- Talent or special ability selection
- Difficulty selection
- Religion, ethnicity, or community selection
- Appearance customization beyond gender
- Starting stat allocation (all stats are randomized)

## 6. Main Life Dashboard

The life dashboard is the central screen the player returns to. Here's what the player sees:

### Top Area (Header)
- **Avatar emoji** that changes with age and gender (baby, child, teen, adult, elder)
- **"GHANA LIFE"** branding with "LIVE INTENTIONALLY" subtitle
- **"SIM LIFE" button** (debug/development feature — instantly jumps character to age 90 with max stats and faked life log)
- **Achievements icon** (trophy) — navigates to legacy progress screen
- **Life log icon** (book) — navigates to full life log screen

### Stats Card (Purple Gradient)
Displays character name, life stage, age in large text. Below that, an 8-stat grid:

| Stat | What It Means to the Player |
|------|---------------------------|
| Happiness | How content you are. Affects relationships and life rating. |
| Health | Physical wellbeing. Reaches 0 and you die. |
| Smarts | Intelligence. Needed for education and tech careers. |
| Looks | Appearance. Affects romance and entertainment careers. |
| Reputation | How Ghana sees you. Affects connections and opportunities. |
| Connect | Your network. Opens doors money alone cannot. |
| Streets | Hustle instinct. Needed for trade and survival. |
| Discipline | Work ethic. Needed for promotions and civil service. |

Each stat shows a percentage bar and value. Tapping any stat opens a bottom sheet with a detailed description and a progress bar.

If the character has a career, the career path, level title, monthly income, side gig count, and education level badge appear below the stat grid.

### Relationship & Housing Line
- Shows relationship status with emoji and partner name (e.g., "Married to Akosua")
- Shows housing status and business count (e.g., "Renting - 1 business")

### Funds Card
- Available cash in GHS (large number)
- If in debt: shows debt amount in red
- If no debt: shows financial stability rating (money stat out of 100)

### Life Goal Card
- Active life goal title and description
- Progress bar toward completion
- Shows "DONE" when completed

### Activities Section
- Shows remaining action energy (e.g., "2 left" or red "0 left" when exhausted)
- Grid of available activity cards. Each shows emoji, title, cash cost, and subtitle. Disabled cards are greyed out with "Not enough cash" if the player can't afford them.
- Activities available depend on age, cash, relationship status, and whether the player has children.

### "Doing" Navigation
- Housing card: shows current housing status, navigates to housing screen
- My Businesses card: shows business count or "None yet", navigates to business screen

### Recent Journey (Life Log)
- Chronological list of life events with age markers
- Each entry shows: age badge, event title and outcome
- Connected by a vertical timeline line
- Shows empty state ("No journey details yet.") for brand-new characters

### Bottom Navigation Bar (Always Visible)
Five tabs:

| Tab | Icon | Screens |
|-----|------|---------|
| **Social** | Group icon | Relationship status, actions, family circle, stats |
| **Job** | Work icon | Current job, job listings, side gigs |
| **AGE** (center) | Plus icon in gradient circle | **The age-up button** |
| **School** | School icon | Current enrollment, available programs |
| **Doing** | Explore icon | Main dashboard with stats, activities, housing, business |

The center "AGE" button is visually prominent with a gradient circle and drop shadow. This is the primary action in the game.

## 7. Age-Up Flow

When the player taps the AGE button, the following happens in sequence:

```text
Tap "AGE"
  ↓
Age increases by 1
  ↓
Children age (all child ages +1)
  ↓
Family members age (all family ages +1)
  ↓
Action energy resets (3 actions, or 2 for ages 0–5)
  ↓
Life stage check — if stage changed, show stage transition modal
  ↓
Health decay applied (based on age bracket)
  - Ages 40–49: -1 health per year
  - Ages 50–64: -2 health per year
  - Ages 65–79: -3 health per year
  - Ages 80+: -4 health per year
  ↓
Random serious health event check (age-based probability)
  - Age 50+: 5% chance of -5 health
  - Age 65+: 10% chance of -8 health
  - Age 80+: 20% chance of -12 health
  ↓
School progression (if enrolled): deduct fees, decrement years left, check graduation
  ↓
Career promotion check (40% chance if requirements met, max level 3)
  ↓
Job + side gig income applied (monthly income × 12 added to cash, money stat adjusted)
  ↓
Debt interest (8% annual interest on outstanding debt)
  ↓
Debt/low cash/has children flags updated
  ↓
Relationship progression (score drifts based on partner personality; cheating detection)
  ↓
Auto-divorce if relationship score reaches 0
  ↓
Housing expense (rent deducted if renting; shortfall becomes debt)
  ↓
Child expenses (GHS 1,200 per child per year; shortfall becomes debt)
  ↓
Business progression (income applied, health drifts, failure check)
  ↓
Life goal progress updated
  ↓
Eligible events selected (1–3 events based on age and randomness)
  ↓
Event dialog appears → Player makes choice
  ↓
Choice consequences applied (stats, cash, debt, flags, illnesses, career, relationships, housing)
  ↓
Event logged to life log
  ↓
More events if pending (shown sequentially)
  ↓
Save game
  ↓
Death check — if health ≤ 0 or age ≥ 90, navigate to death screen
```

### Event Selection Details

Events are selected from a pool of all eligible events (must pass age, career, relationship, housing, business, stat requirement, and flag checks). Selection is weighted:

- Base weight from event definition
- Health events get +12 weight when health is low (< 35)
- Money events get +8 weight when money stat is low (< 25)
- Relationship events get +10 weight when in a relationship
- Career events get +10 weight when in that career
- Business events get +10 weight when owning businesses
- Recently seen events get their weight divided by 3 (reduces repeats)

Number of events per year:
- Ages 0–12: 1 event
- Ages 13–60: 45% chance of 2 events, otherwise 1
- Ages 61+: 35% chance of 3 events, otherwise 1

### Life Stage Transition

When the player crosses a life stage boundary, a celebratory modal appears showing:
- Stage emoji
- "NEW LIFE STAGE" label
- Stage name in the stage's color
- A brief description of what the stage means
- "Let's Go" button to dismiss

Stage transition descriptions:
- **Child:** "School, chores, and discovering the world."
- **Teenager:** "Exams, crushes, and questionable decisions."
- **Young Adult:** "University, first jobs, and figuring life out."
- **Adult:** "Career, relationships, and real responsibilities."
- **Middle Aged:** "You've seen things. Now you manage things."
- **Senior:** "Legacy time. What will they say about you?"

## 8. Life Stages

Based on the `lifeStage` getter in the Character model:

| Life Stage | Age Range | Available Gameplay | Locked / Limited |
|-----------|----------:|-------------------|-----------------|
| **Toddler** | 0–5 | View stats, age up, rest activity, study activity (age 5+) | No school, no jobs, no relationships, no businesses, no housing actions, 2 action energy per year |
| **Child** | 6–12 | School (Primary, then JHS), study, rest, pray, some childhood events | No jobs, no relationships, no businesses, no move out |
| **Teenager** | 13–17 | School (SHS, Vocational), exercise (age 12+), pray, party (age 16+), gamble (age 18 — not yet), meet someone (age 16+), some side gigs (age 15+), help family (age 16+) | No full jobs, no marriage, no children, no home buying, no businesses (most require 18+) |
| **Young Adult** | 18–24 | Full jobs, university, all side gigs, dating/engagement, marriage (age 22+ with 65+ relationship score), move out (age 18+), start businesses (age 18+), all activities unlocked | Cannot buy home (need age 28+ and renting), cannot have children unless married |
| **Adult** | 25–49 | All systems fully available: career, marriage, children, business, housing, education | Home buying requires age 28+ and renting first |
| **Middle Aged** | 50–69 | All systems available. Health decay begins (-2/year). Career still possible. Children no longer possible (age 45+ cap). Senior events start appearing. | Cannot have more children (capped at age 45), health becomes a concern |
| **Senior** | 70–89 | All systems technically available. Health decay accelerates (-3/year at 65+, -4/year at 80+). Senior-specific events. Death approaches. | No new children, limited career mobility, survival focus |

## 9. First Year / Early Childhood Preview (Ages 0–5)

What the player experiences at the very beginning of life:

### What the Player Can Do
- **View stats** — see their randomized starting stats
- **View family** — mother, father, and possibly a sibling are shown in the Social tab
- **Age up** — advance years
- **Use activities** — limited to Rest (any age) and Study Hard (from age 5)
- **View life log** — initially empty, fills as events fire
- **Navigate all tabs** — but most are empty

### What Is Locked
- **School tab:** Shows "No programs available" or only Primary School (unlocks at age 4, but requires smarts 0 so it shows). Can enroll in Primary School from age 4.
- **Job tab:** Shows "Unemployed" with no job listings (age-gated and stat-gated).
- **Social tab (relationships):** Shows "Single" with no actions (meeting someone requires age 16).
- **Social tab (actions):** Empty.
- **Housing:** Shows "With Parents." Move out requires age 18.
- **Businesses:** Shows "None yet." Starting requires age 18+.
- **Most activities:** Exercise (12+), Pray (6+), Party (16+), Gamble (18+), Help Family (16+), Partner Time (16+), Child Time (requires children), Risky Hustle (16+).

### What Events Can Happen
Childhood events fire. Examples from the codebase:
- School-related events
- Family events
- Play and discovery events
- Ghanaian cultural events (some gated to age 10+)
- General events with min age 0

### What Screens Are Useful
- **Life Dashboard:** Primary screen. Age up and watch stats.
- **Social tab:** See family members and their bond scores.
- **School tab:** From age 4, enroll in Primary School.

### Screens That Feel Empty
- **Job tab:** "Unemployed" with no listings.
- **Housing screen:** Just shows "With Parents" status.
- **Business screen:** "None yet" with startup section showing "don't qualify."

### Early Game Reality
The first 5–6 years pass quickly. The player taps Age Up repeatedly, watches a few childhood events, and might enroll in Primary School at age 4. The game is thin here — this is acceptable for a life sim (BitLife's early years are also sparse), but the player has very few meaningful choices.

## 10. Teen Years Preview (Ages 13–17)

What opens up:

### Education
- **Senior High School (SHS):** Available from age 13, requires JHS completion, smarts 35+, costs 2 fee units/year (GHS 1,000/year)
- **Vocational Training:** Available from age 15, requires JHS, smarts 25+, costs 3 fee units/year (GHS 1,500/year)
- Education is the main teen progression mechanic

### Social / Relationships
- **Meet Someone:** Available from age 16. Generates a random potential partner with Ghanaian name, job, and personality (Ambitious, Clingy, Funny, Jealous, Calm, Spiritual, Caring). Success chance depends on looks and happiness stats.
- **Dating:** If the "Ask Out" succeeds, relationship begins at score 50.
- **Cheating:** Available while dating (from age 16+)
- **Break Up:** Available while dating

### Activities
At age 13+: Study, Rest, Pray, Exercise
At age 16+: Party, Help Family, Risky Hustle, Partner Time (if dating)

### Side Gigs
- Hair Braider/Barber (age 15+, looks 40+): GHS 550/month
- Private Tutor (age 16+, smarts 50+): GHS 600/month
- Church Musician (age 16+, happiness 55+): GHS 400/month
- Food Vendor (age 17+, street sense 30+): GHS 650/month
- Mobile Money Agent (age 18+): not yet available
- Several more unlock at 18–24

### What Is Locked
- Full-time jobs (most require higher education or stats)
- Marriage (requires age 22+ and relationship score 65+)
- Having children (requires marriage and age 18–45)
- Moving out (requires age 18+)
- Most businesses (require age 18–22+)
- Gambling (requires age 18+)
- University (requires SHS completion and age 17+)

### Teen Experience
Teens have more agency than children. They can study for WASSCE, date, pick up side hustles, and get into trouble. The event pool expands to include teen-specific events. This is where the game starts to feel more interactive.

## 11. Adult Life Preview (Ages 18–49)

Full adulthood opens the complete game:

### Education
- **University:** Available from age 17, requires SHS, smarts 55+, costs 5 fee units/year (GHS 2,500/year), 4-year program. Graduation is a major milestone that unlocks healthcare and tech careers.

### Careers (7 paths)
| Career Path | Entry Level | Entry Salary | Key Requirements |
|------------|-------------|-------------|-----------------|
| Civil Service | Junior Officer | GHS 1,800/mo | Discipline 40+, SHS education |
| Healthcare | Nurse/Medical Assistant | GHS 2,200/mo | Smarts 55+, Health 50+, University |
| Education | Class Teacher | GHS 1,600/mo | Smarts 45+, SHS education |
| Tech | Junior Developer/IT Support | GHS 2,500/mo | Smarts 60+, Vocational or University |
| Trade | Shop Attendant/Trader | GHS 1,200/mo | Street Sense 40+, no education gate |
| Entertainment | Upcoming Artist/Comedian | GHS 800/mo | Looks 50+, Happiness 50+, no education gate |
| Hustle | Street Hustle | GHS 900/mo | Street Sense 35+, no education gate |

Each career has 3 levels (Entry → Mid → Senior) with increasing salaries and stat requirements. Promotions have a 40% chance per year when requirements are met.

### Side Gigs (12 types)
All side gigs become available during young adulthood (ages 18–24 unlocks). Some are career-specific (Legal Clerk requires Civil Service, Medical Locum requires Healthcare). Players can hold multiple side gigs simultaneously alongside a main job.

### Relationships
- **Dating** (age 16+)
- **Engagement** (propose while dating, age 22+, relationship score 65+)
- **Marriage** (from engaged state; costs GHS 5,000 wedding; gives +15 happiness; shortfall becomes debt)
- **Children** (married, age 18–45; costs GHS 2,500 per child; randomly named with Ghanaian names)
- **Cheating** (available while dating or married; 15% annual chance of getting caught)
- **Divorce** (costs GHS 3,500 legal fees; -20 happiness, -5 reputation)
- **Break up** (while dating; -12 happiness)
- **Call off engagement** (-16 happiness, -8 reputation)

### Housing
- **Move Out** (age 18+, GHS 1,000 deposit, +10 happiness)
- **Renting** (GHS 2,400/year rent, deducted each age-up)
- **Buy Home** (age 28+, GHS 25,000 down payment, +20 happiness, +10 reputation, no more rent)

### Businesses (6 types)
| Type | Startup Cost | Base Income | Min Age | Key Requirement |
|------|-------------|-------------|---------|----------------|
| Provisions Shop | GHS 10,000 | GHS 1,800/mo | 18 | Street Sense 35+ |
| Barbershop/Salon | GHS 12,000 | GHS 2,000/mo | 18 | Looks 40+ |
| Chop Bar | GHS 15,000 | GHS 2,500/mo | 20 | Street Sense 40+ |
| Clothing/Fashion | GHS 18,000 | GHS 2,200/mo | 20 | Looks 50+ |
| Poultry Farm | GHS 20,000 | GHS 3,000/mo | 22 | Discipline 45+ |
| Transport (Trotro/Taxi) | GHS 25,000 | GHS 3,500/mo | 22 | Street Sense 50+, Discipline 40+ |

Businesses have health (0–100) that drifts -5 to +3 per year. Income scales with health. Businesses can fail (health reaches 0), leaving cleanup debt. Players can invest small (GHS 3,000, +15 health) or big (GHS 8,000, +30 health) to boost business health, or close a business for a GHS 5,000 refund.

### Life Goals (8 types)
Assigned randomly at start and on completion:
1. Graduate University
2. Get Married
3. Raise 3 Children
4. Own A Home
5. Start A Business
6. Reach GHS 100,000
7. Die Debt Free
8. Reach Age 80

### Activities (all 11 types available)
Study, Exercise, Visit Doctor, Rest, Go to Church, Go Out (Party), Try Betting, Help Family, Spend Time with Partner, Play With Kids, Risky Hustle.

## 12. Senior Life Preview (Ages 70–89)

### Health Decline
- Ages 65–79: -3 health per year
- Ages 80+: -4 health per year
- 10% annual chance of -8 health event (age 65+)
- 20% annual chance of -12 health event (age 80+)
- Death at health ≤ 0 or age ≥ 90

### What Changes
- Health becomes the primary concern
- Senior-specific events fire (from senior_events.dart)
- Career income continues but promotions are unlikely (stats decay)
- Children are grown (they age each year alongside the character)
- Family members may die of old age (tracked by familyAlive flags)
- The Visit Doctor activity becomes more important (costs GHS 600, restores 10 health, 65% chance to cure an illness)
- Rest activity restores health and happiness

### What Is Still Available
- All navigation tabs and screens remain accessible
- Businesses still generate income
- Relationships continue (score still drifts)
- Side gig income still comes in
- Events still fire (3 per year at 35% rate for ages 61+)

### What Is Locked
- Cannot have more children (capped at age 45)
- Most education programs are irrelevant (already completed or age-gated)

### Death
When health reaches 0 or age hits 90, the game navigates to the death screen. If cause of death is empty, the HealthService generates one based on circumstances (illness, old age, or health stat collapse).

## 13. Screens And What The Player Can Do

### Onboarding Screen

**Purpose:** Introduces new players to the game concept.

**What the player sees:** 4 swipeable cards with emoji, title, and body text. Dot indicators at the bottom. Skip button (except on last page). "Next" / "Start My Life" button.

**Player can:**
- Swipe through 4 intro cards
- Skip onboarding entirely
- Complete onboarding and proceed to character creation

**Persistence:** Sets `onboarding_seen = true` in SharedPreferences. Never shown again.

### Character Creation Screen

**Purpose:** Create a new character identity.

**What the player sees:** "GHANA LIFE" header, help icon (non-functional), "Begin Your Story" title, "Create your unique identity" subtitle, name text field with edit icon, gender selection cards (Male/Female with icons), "Randomizing Traits..." info card, "Begin Your Life" gradient button at the bottom.

**Player can:**
- Enter a name (required, validated — shows error snackbar if empty)
- Select gender (Male or Female, toggled by tapping cards)
- Tap "Begin Your Life" to start

**What happens next:** A Character object is created with randomized stats. The player is navigated to the Life Screen.

### Life Screen (Main Dashboard)

**Purpose:** Central hub for viewing character state and navigating to all other screens.

**What the player sees:** Described in detail in Section 6 above. Stats card, funds card, life goal card, activities grid, housing/business navigation, recent life log, bottom navigation bar.

**Player can:**
- View all character stats, cash, debt
- See and track life goal progress
- Use activities (consumes action energy)
- Navigate to: Social, Job, School, Housing, Business, Achievements, Life Log screens
- Tap "AGE" to advance one year
- Tap "SIM LIFE" to instantly jump to death (debug feature)
- Tap any stat for a detailed tooltip

### School Screen

**Purpose:** View current enrollment and available education programs.

**What the player sees:**
- If enrolled: progress card with program name, years remaining, progress bar, cost
- Current education level badge
- "Available Programs" section listing eligible programs with duration, cost, min age, smarts requirement
- Each program has an "Enroll" button

**Player can:**
- Enroll in eligible education programs
- View current enrollment progress
- See which programs are unavailable and why (age, prerequisite, smarts, or cost)

**Locked until:** Programs are locked by min age, prerequisite education level, smarts threshold, and available cash.

**Current limitations:**
- Cannot drop out of school once enrolled (must wait for graduation)
- No grade/performance variability — it's deterministic progression
- No scholarship or financial aid system
- School fees come from cash; shortfall becomes debt

### Job / Career Screen

**Purpose:** View current job, apply for jobs, manage side gigs.

**What the player sees:**
- **Current Job section:** If employed — job title, career path, level, monthly income, "Quit Job" button. If unemployed — "Unemployed" message.
- **Job Listings section** (only when unemployed): Available career entry positions with title, salary, and stat requirements. Each has an "Apply" button.
- **Side Gigs section:** Active side gigs with current total income. Available side gigs with description and income. "Take Gig" button. Active gigs show an X to quit.

**Player can:**
- Apply for jobs (success chance based on stat requirements; can fail)
- Quit current job (with confirmation dialog)
- Take side gigs
- Quit individual side gigs
- View active monthly income breakdown

**Locked until:** Job listings only show when character has no career. Job applications are gated by education and stat requirements.

**Current limitations:**
- Job application is a single roll — no interview process
- Only 3 career levels (entry, mid, senior)
- No job-specific events during work
- No coworker relationships or office politics
- No retirement mechanic (income continues until death or quitting)

### Social Screen

**Purpose:** Manage relationships, view family, track social stats.

**What the player sees:**
- **Relationship Status card:** Current status with colored badge, partner details (name, job, personality), bond score bar, children list (if married), cheating indicator
- **Actions card:** Context-sensitive action buttons based on current relationship status
- **Family Circle card:** All family members (mother, father, sibling) with names, relations, ages, bond scores, alive/deceased status. Children listed separately.
- **Social Stats card:** Reputation and Happiness values

**Player can (by status):**
- **Single (age 16+):** "Meet Someone" — generates random partner profile in bottom sheet, then "Ask Out" or "Not Interested"
- **Dating:** Propose (age 22+, score 65+), Cheat, Break Up
- **Engaged:** Get Married, Call Off Engagement
- **Married:** Have a Child (age ≤ 45), Cheat, Divorce
- **Divorced (age 18+):** Meet Someone New
- **Widowed:** No actions ("Take your time. There is no rush.")

**Current limitations:**
- Partners are randomly generated with no persistence beyond the current relationship
- Partner's job and personality affect relationship drift but don't generate independent events
- Children age but don't become independent adults within the same life
- No friendship system (only family and romantic relationships)
- No enemy/rival system
- No in-law dynamics

### Housing Screen

**Purpose:** View housing status and take housing actions.

**What the player sees:**
- **Current Status card:** Housing status with emoji (With Parents, Renting, Homeowner), status-specific subtitle
- **Actions section:** Context-sensitive action button or explanation of why action is unavailable

**Player can:**
- Move Out (age 18+, GHS 1,000 deposit, housing must be "With Parents")
- Buy Home (age 28+, GHS 25,000 down payment, must be renting)

**Locked until:** Age and cash requirements. Player must move out before buying a home.

**Current limitations:**
- Only three housing states
- Rent is fixed at GHS 2,400/year regardless of location
- No home upgrades, mortgage, or property value mechanics
- No location/neighborhood selection
- No landlord interactions beyond rent deduction

### Business Screen

**Purpose:** View owned businesses and start new ones.

**What the player sees:**
- **My Businesses section:** List of owned businesses with emoji, name, type, health bar, monthly income. Each has "Invest Small" (-GHS 3,000, +15 health), "Invest Big" (-GHS 8,000, +30 health), and "Close Business" buttons. Total business income shown at bottom.
- **Start a Business section:** Available business types with emoji, description, startup cost, base income. "Start This Business" button opens naming dialog.

**Player can:**
- Start a business (name it, pay startup cost, begin generating income)
- Invest in existing businesses to boost health
- Close businesses (get GHS 5,000 refund)

**Locked until:** Each business type has min age and stat requirements. Player must have enough cash for startup costs.

**Current limitations:**
- Business health drift is random, not influenced by player skill or market conditions
- No business expansion beyond investing in health
- No employees, suppliers, or customers as distinct entities
- No business competition or market events
- No business-specific events (though events can check `requiresBusiness`)

### Life Log Screen

**Purpose:** View complete chronological history of the character's life.

**What the player sees:** Scrollable list of all life log entries. Alternating white/lavender background. Each entry shows the full log text including age, event title, and outcome.

**Player can:** Scroll through entire life history. Jump to bottom via floating action button.

### Achievements / Legacy Progress Screen

**Purpose:** View meta-progress across all lives played.

**What the player sees:**
- **Summary card:** Lives completed count, ribbons unlocked count, badges unlocked count
- **Unlocked Ribbons:** Colored chips showing all ribbons earned across all lives
- **Achievements:** Full list of 10 achievements with lock/unlock status, title, and description
- **Completed Life Goals:** Full list of 8 life goals with completion status

**Player can:** View progress. Return to previous screen.

**Persistence:** All legacy data is stored in SharedPreferences and persists across lives.

### Death Screen

**Purpose:** Show life summary after character death.

**What the player sees:**
- **Header:** "GHANA LIFE" branding
- **Death Card:** Skull emoji, character name, final life stage, age at death (large text), "YEARS OF LIFE" label, cause of death (italic quote)
- **Life Rating Card:** Score out of 100 in colored circle, rating label (Legendary/Solid Run/Average Life/Wasted Potential), flavor subtitle
- **Legacy Ribbon Card:** Trophy icon, ribbon name, ribbon-specific flavor text
- **New Unlocks Card:** Lists newly unlocked ribbons, achievements, and completed goals from this life
- **Final Stats Grid:** All 11 stats at time of death
- **Life Log:** Last 20 life log entries
- **Bottom Actions:** "View Legacy Progress" button, "Live Again" button (deletes save, returns to character creation)

**Life Score Calculation:**
- Health × 0.10
- Happiness × 0.20
- Money stat × 0.15
- Cash/10,000 (capped at 10 points)
- Minus Debt/10,000 (capped at -15 points)
- Reputation × 0.15
- Smarts × 0.10
- Marriage bonus: +10
- Dating bonus: +5
- Children bonus: +3 per child (capped at +15)
- Homeowner bonus: +5
- Business bonus: +3 per business (capped at +10)

**Ratings:**
- 75+: Legendary
- 55–74: Solid Run
- 30–54: Average Life
- 0–29: Wasted Potential

**Legacy Ribbons (11 types):** Scandal Magnet, The Hustler, Family Hero, Big Person, Church Favorite, Campus Legend, Quiet Survivor, Wasted Talent, Local Legend, Respectable Citizen, Tough Life.

## 14. Activities Between Age-Ups

The activity system gives players things to do between age-ups. Action energy resets each year.

| Activity | Available When | Effect | Cash Cost | Notes |
|----------|---------------|--------|-----------|-------|
| **Study Hard** | Age 5+ | +4 smarts, +2 discipline, -1 happiness | Free | Core activity for education-focused players |
| **Rest** | Age 0+ | +5 happiness, +2 health, -1 discipline | Free | Available from birth; good for recovering happiness |
| **Go to Church** | Age 6+ | +4 happiness, +2 reputation, +1 connections, 25% church_favorite flag | Free | Builds reputation and connections |
| **Exercise** | Age 12+ | +5 health, +2 looks, +1 happiness | GHS 150 | Good for health and appearance |
| **Go Out (Party)** | Age 16+ | +7 happiness, +1 looks, -3 discipline, 15% -2 health + party_animal flag | GHS 250 | High happiness boost, discipline risk |
| **Help Family** | Age 16+ | +8 family bonds, +5 reputation, +2 happiness, family_helper flag | GHS 700 | Improves family relationships |
| **Risky Hustle** | Age 16+ | +5 street sense, 55% win GHS 800–3,000 +2 money, 45% lose GHS 500–1,700 debt -4 reputation + risky_hustle_trouble flag | Free | High risk, high reward street activity |
| **Try Betting** | Age 18+ | +2 street sense, 42% win GHS 900–2,700 +4 happiness, 58% lose add debt -4 happiness | GHS 300 | Gambling with real consequences |
| **Spend Time (Partner)** | Age 16+ | +8 relationship score, +3 happiness | GHS 200 | Only available when dating/engaged/married |
| **Play With Kids** | Any | +8 child bonds, +4 happiness | GHS 150 | Only available when you have children |
| **Visit Doctor** | Any | +10 health, 65% chance to cure an illness | GHS 600 | Critical for managing health in later years |

**Action Energy:**
- Ages 0–5: 2 actions per year
- Ages 6+: 3 actions per year
- Resets on each age-up
- Activities cannot be used when energy is 0 (shows red "0 left" badge)
- Activities are greyed out when unaffordable (shows "Not enough cash" instead of subtitle)

**Early game useful activities:** Study, Rest, Pray, Exercise
**Adult game useful activities:** Doctor (health management), Partner Time (relationship maintenance), Help Family, Risky Hustle, Gamble

## 15. Event System From The Player's View

Events are the primary narrative engine. The codebase contains approximately 11,000 lines of event data across 12 event files.

### How Events Appear
After an age-up, if events are selected, a dialog appears with:
- Age badge (purple pill)
- Event title (bold)
- Event description (grey text, 1–3 sentences of narrative setup)
- 2–4 choice buttons, each with descriptive text

The player picks one choice. The dialog closes, consequences are applied, and the outcome text is logged. If multiple events are pending, the next event dialog appears after the previous one is resolved.

### Event Types

**Childhood Events** (ages 0–12): School, play, family, discovery. Gated by min/max age.

**Teen Events** (ages 13–17): Exams, crushes, peer pressure, WASSCE drama, first hustles.

**Young Adult Events** (ages 18–24): University, career starts, serious relationships, independence.

**Adult Events** (ages 25–49): Career, marriage, children, business, money, status.

**Senior Events** (ages 50+): Health, legacy, family, reflection, aging parents.

**Ghana Events** (ages vary): Culturally specific events — jollof competitions, church prophecies, trotro arguments, chieftaincy disputes, family meetings, dumsor, market fires, susu groups, funerals that turn into parties, witch doctor recommendations, celebrity sightings.

**Career Events**: Fire only when in a specific career path. Work-specific dilemmas and opportunities.

**Relationship Events**: Fire based on relationship status. Dating, marriage, cheating, and family dynamics.

**Doing Events**: Fire when owning businesses or in specific housing situations.

**Health Events**: Fire when health is low or when specific illnesses are active.

**Consequence Events**: Fire based on flags set by previous choices. Long-term consequence chains.

**Rare Events**: Low base weight events — lightning strike, viral fame, bank errors, scholarship letters.

### What Choices Look Like
Each choice shows only descriptive text (e.g., "Return it immediately," "Take it and walk fast," "Take half and return half"). The player does not see stat changes before choosing — they only see the outcome after.

### What Consequences Can Happen
- Stat changes (any of the 9 core stats, relationship score, number of children)
- Cash gains or losses
- Debt accumulation
- Illness added or removed
- Career entry (can trigger a new career path)
- Relationship status changes
- Housing status changes
- Flag added or removed (flags control future event eligibility)
- Combinations of the above

### How Repeated Choices Shape the Future
Flags are the key mechanism. Examples:
- `church_favorite` flag → unlocks specific church-related events
- `party_animal` flag → may unlock certain social events or block reputation-based ones
- `risky_hustle_trouble` flag → may trigger consequence events
- `known_cheater` flag → affects reputation and future relationship events
- `family_helper` flag → affects family events and legacy ribbon
- `family_disappointed` flag → may trigger specific family events
- `distant_parent` flag → affects child-related events
- `in_debt` / `low_cash` flags → auto-managed, affect money-related event weighting

## 16. Core Stats And What They Affect

| Stat | What It Represents | How It Changes | What It Affects |
|------|-------------------|---------------|-----------------|
| **Health** (0–100) | Physical wellbeing | Decays with age (40+); increased by exercise, rest, doctor; decreased by events, illness | Death at 0; healthcare career entry; stamina for certain events |
| **Happiness** (0–100) | Contentment and joy | Increased by party, rest, pray, marriage; decreased by breakup, divorce, debt, negative events | Life rating score (×0.20 weight); relationship success; entertainment career |
| **Smarts** (0–100) | Intelligence | Increased by study, education graduation; decreased rarely | Education enrollment gates; tech, healthcare, civil service careers; event eligibility |
| **Looks** (0–100) | Physical appearance | Increased by exercise, party; decreased by aging events | Dating success chance; entertainment, fashion careers; social event options |
| **Money** (0–100) | Financial power stat | Increased by income gains; decreased by expenses, debt | Business qualification; marriage eligibility perception; life rating (×0.15) |
| **Reputation** (0–100) | Social standing in Ghana | Increased by church, helping family, honest choices; decreased by scandal, cheating, bad choices | Career advancement; social events; legacy ribbon; life rating (×0.15) |
| **Discipline** (0–100) | Work ethic and self-control | Increased by study, rest (slight decrease); decreased by party | Civil service career; promotion eligibility; certain event options |
| **Street Sense** (0–100) | Hustle instinct | Increased by risky hustle, gambling; rarely from education | Trade, hustle careers; side gigs; business startups; street event options |
| **Connections** (0–100) | Professional and social network | Increased by church, events, helping family | Career advancement; business opportunities; certain event options |

Additional tracked values:
- **Cash (GHS):** Actual spendable money. Used for all purchases, fees, activities. Shortfalls become debt.
- **Debt (GHS):** Outstanding debt. 8% annual interest. Reduces happiness (-2/year) and money stat (-1/year).
- **Relationship Score (0–100):** Health of current romantic relationship. Affected by partner personality drift, cheating, partner time activity. Divorce at 0.

## 17. Money, Cash, Debt, And Economy Flow

```
Career Income (monthly × 12)
Side Gig Income (total monthly × 12)
Business Income (monthly × 12, scaled by business health)
  ↓
Cash Balance (GHS)
  ↓
Yearly Expenses:
  - School Fees (if enrolled)
  - Rent (GHS 2,400/year if renting)
  - Child Expenses (GHS 1,200/child/year)
  - Debt Interest (8% of outstanding debt/year)
  - Activity Costs (per use)
  ↓
If Cash < Expense: Shortfall becomes Debt
  ↓
Debt Consequences:
  - -2 happiness/year
  - -1 money stat/year
  - in_debt flag set
  - 8% annual interest compounds
```

**Key economic facts:**
- Cash starts at GHS 400–2,500 (randomized)
- Money stat starts at 5–30 (randomized)
- Career income ranges from GHS 800/mo (entry entertainment) to GHS 15,000/mo (senior entertainment/tech)
- Side gigs add GHS 400–1,200/mo each
- Businesses generate GHS 1,800–3,500/mo base income
- University costs GHS 2,500/year for 4 years
- Wedding costs GHS 5,000
- Divorce costs GHS 3,500
- Having a child costs GHS 2,500 upfront + GHS 1,200/year ongoing
- Moving out costs GHS 1,000 deposit + GHS 2,400/year rent
- Buying a home costs GHS 25,000 down payment (eliminates rent)
- Business startup costs: GHS 10,000–25,000

**When the player can't afford something:**
- School fees: Shortfall becomes debt, -4 happiness, -3 money stat
- Rent: Shortfall becomes debt, -4 happiness, -3 money stat
- Child expenses: Shortfall becomes debt, -3 happiness
- Wedding: Shortfall becomes debt
- Divorce legal fees: Shortfall becomes debt
- Having a baby costs: Shortfall becomes debt
- Activities: Simply unavailable ("Not enough cash" shown)

## 18. Education Flow

### Education Levels (in order)
1. **None** (starting state)
2. **Primary** — 6 years, free, age 4+, no prerequisites, smarts 0+
3. **JHS** (Junior High School) — 3 years, free, age 10+, requires Primary, smarts 20+
4. **SHS** (Senior High School) — 3 years, GHS 1,000/year, age 13+, requires JHS, smarts 35+
5. **Vocational** — 2 years, GHS 1,500/year, age 15+, requires JHS, smarts 25+
6. **University** — 4 years, GHS 2,500/year, age 17+, requires SHS, smarts 55+

### How Education Works
- Player navigates to School tab
- Sees available programs that match age, prerequisite education, and smarts
- Taps "Enroll" on a program
- Each age-up: school fees deducted, years left decremented
- When years left reaches 0: graduation! Education level updated, smarts +5, commencement message logged
- Education level gates career access:
  - Hustle, Trade, Entertainment: No education gate
  - Civil Service, Education: Requires SHS or University
  - Tech: Requires Vocational or University
  - Healthcare: Requires University

### What Happens If the Player Cannot Pay
School fee shortfall becomes debt. The player continues in school — there is no dropout mechanic. Education is guaranteed once enrolled, you just pay for it one way or another.

## 19. Career And Side Gig Flow

### Career Paths
7 career paths, each with 3 levels:

| Path | Entry | Mid | Senior |
|------|-------|-----|--------|
| Civil Service | Junior Officer (GHS 1,800) | Senior Officer (GHS 3,200) | Director (GHS 6,000) |
| Healthcare | Nurse/Med Assistant (GHS 2,200) | Doctor/Pharmacist (GHS 5,500) | Senior Consultant (GHS 10,000) |
| Education | Class Teacher (GHS 1,600) | Senior Teacher/HOD (GHS 2,800) | Headmaster/Principal (GHS 5,000) |
| Tech | Junior Dev/IT Support (GHS 2,500) | Software Engineer (GHS 5,000) | Tech Lead/CTO (GHS 12,000) |
| Trade | Shop Attendant/Trader (GHS 1,200) | Established Trader (GHS 3,000) | Wholesale Distributor (GHS 7,000) |
| Entertainment | Upcoming Artist (GHS 800) | Known Act (GHS 4,000) | Star/Celebrity (GHS 15,000) |
| Hustle | Street Hustle (GHS 900) | Connected Operator (GHS 2,500) | Big Man/Oga (GHS 8,000) |

### Promotion System
- 40% chance per year when all stat requirements for next level are met
- Maximum 3 levels per career
- Promotion updates job title, salary, and logs a flavor message

### Side Gigs
12 side gig types. Players can hold unlimited side gigs simultaneously. Side gig income is separate from career income.

### Career Application
- Only visible when unemployed
- Application success chance: 60% base + (highest stat difference × 1%), clamped to 10–95%
- Can fail the application: logs rejection message
- Career entry has flavor message specific to each career path

### Quitting
- Quit job: Resets career path, level, and income to none
- Quit side gig: Removes that gig, recalculates total gig income

## 20. Relationship And Family Flow

### Relationship States
```
Single → Dating → Engaged → Married → (Divorced/Widowed)
                    ↑                      |
                    └─────── can't ────────┘
```

### Dating
- Available from age 16+
- "Meet Someone" generates random partner: Ghanaian name (gender-appropriate), random job title, random personality (Ambitious, Clingy, Funny, Jealous, Calm, Spiritual, Caring)
- "Ask Out" success based on looks and happiness stats
- On success: Relationship status becomes "Dating," relationship score starts at 50
- On failure: The partner is discarded; -0 stats but logged disappointment

### Engagement
- "Propose" available while Dating, age 22+, relationship score 65+
- On success: Status becomes "Engaged"

### Marriage
- "Get Married" available while Engaged
- Costs GHS 5,000 (shortfall becomes debt)
- +15 happiness, -2 money stat
- Unlocks "Have a Child" action

### Children
- "Have a Child" available while Married, age 18–45
- Costs GHS 2,500 (shortfall becomes debt)
- +10 happiness, -2 money stat
- Child gets random Ghanaian name (gender-randomized)
- Starting bond score: 65
- Children age each year, have individual bond scores
- Child expenses: GHS 1,200/child/year deducted each age-up

### Cheating
- "Cheat" available while Dating or Married
- Sets `isCheating = true`, generates side partner name
- 15% annual chance of getting caught
- Getting caught: -20 reputation, -40 relationship score, -10 happiness, cheating reset
- Cheating also applies -5 annual drift to relationship score

### Break Up / Divorce
- Break Up: Available while Dating, -12 happiness, resets partner
- Call Off Engagement: -16 happiness, -8 reputation
- Divorce: Costs GHS 3,500, -20 happiness, -5 reputation, -3 money stat

### Family Members
- Generated at character creation: Mother, Father, 50% chance of sibling
- All family members have: name, relation, age, bond score, alive/deceased flag
- Family ages each year, can die of old age
- Bond scores can be improved via "Help Family" activity (+8 bonds)
- Family relationships tracked and displayed in Social tab

### What Is Missing or Basic
- No friendship system (only family and romantic relationships)
- No dating multiple people at once beyond cheating mechanic
- Partner doesn't have independent life events
- Children never become adults within the same life (they just keep aging)
- No in-law relationships
- No matchmaking or arranged marriage events (culturally relevant for Ghana)
- No co-parenting after divorce

## 21. Housing Flow

### Housing States
```
With Parents → Renting → Homeowner
```

### Move Out
- Available at age 18+
- Requires GHS 1,000 cash deposit
- +10 happiness
- Sets rent at GHS 2,400/year

### Renting
- GHS 2,400 deducted each age-up
- Shortfall becomes debt with -4 happiness, -3 money

### Buy Home
- Available at age 28+
- Requires GHS 25,000 cash down payment
- Must be renting
- +20 happiness, +5 money stat, +10 reputation
- Eliminates rent forever
- Life rating bonus: +5

### Current Limitations
- Fixed rent regardless of "location"
- No mortgage system (full cash purchase only)
- No home value appreciation or property as investment
- No moving between rental properties
- No eviction or landlord conflict events (though there is a "Landlord Drama" event in events.dart)

## 22. Business Flow

### Starting a Business
1. Navigate to Business screen
2. See available business types based on age, stats, and cash
3. Tap "Start This Business"
4. Name the business in a dialog
5. Startup cost deducted from cash
6. Business added with 70 health and base monthly income

### Business Operation
- Each age-up: income applied (health/100 × baseIncome × 12), health drifts -5 to +3
- Health at 0: Business fails, removed, cleanup debt added (baseIncome × 2, GHS 1,000–15,000), -8 reputation
- Invest to boost health: Small (GHS 3,000, +15 health) or Big (GHS 8,000, +30 health)
- Close voluntarily: Get GHS 5,000 refund

### Business Types
| Type | Startup | Income | Age | Key Stat |
|------|---------|--------|-----|----------|
| Provisions Shop | GHS 10,000 | GHS 1,800 | 18 | Street Sense 35 |
| Barbershop/Salon | GHS 12,000 | GHS 2,000 | 18 | Looks 40 |
| Chop Bar | GHS 15,000 | GHS 2,500 | 20 | Street Sense 40 |
| Clothing/Fashion | GHS 18,000 | GHS 2,200 | 20 | Looks 50 |
| Poultry Farm | GHS 20,000 | GHS 3,000 | 22 | Discipline 45 |
| Transport | GHS 25,000 | GHS 3,500 | 22 | Street Sense 50, Discipline 40 |

### Current Limitations
- Can own multiple businesses of the same type
- No business-specific events (though events can check if player owns businesses)
- No employee hiring or management
- Health drift is random, not tied to player choices
- No market conditions or competition
- Income is fixed base rate, no growth beyond health scaling

## 23. Health, Illness, And Death Flow

### Health Stat
- Starts at 60–90 (randomized)
- No decay under age 40
- Decay begins at 40: -1/year (40–49), -2/year (50–64), -3/year (65–79), -4/year (80+)
- Random health crises: 5% chance at 50+, 10% at 65+, 20% at 80+
- Can be restored by: Exercise (+5), Rest (+2), Doctor (+10)

### Illnesses
- Can be added by event choices (`illnessToAdd` field)
- Stored in `activeIllnesses` list
- Visit Doctor activity has 65% chance to cure the most recent illness
- Cause of death can reference the active illness if health reaches 0

### Death Conditions
- Health ≤ 0 → die
- Age ≥ 90 → die

### Cause of Death
Generated by HealthService when character dies:
- If age ≥ 85: Peaceful old age messages with Ghanaian flavor
- If health ≤ 0 and has active illnesses: References the illness
- If health ≤ 0 with no illness: Body gave up messages
- Fallback: Old age message

### Death Screen
See section 13 for full death screen details.

### After Death
- Life score calculated
- Rating assigned
- Ribbon determined
- Meta-progress updated: ribbons, achievements, completed goals, lives count all persisted
- Player can view legacy progress or start a new life

## 24. Life Goals, Achievements, And Legacy

### Life Goals (Per-Life)
8 goals, randomly assigned. When completed, a new one is assigned. Goals are specific to the current life:

1. Graduate University
2. Get Married
3. Raise 3 Children
4. Own A Home
5. Start A Business
6. Reach GHS 100,000
7. Die Debt Free
8. Reach Age 80

Goals update progress after each age-up. When a goal is completed, it's added to `completedLifeGoalIds` and a new goal is assigned.

### Achievements (Meta / Cross-Life)
10 achievements tracked across all lives via SharedPreferences:

1. First Life Completed — Finish one full life
2. Family Hero — Be remembered for caring for family
3. Big Person — Major status, money, or business power
4. Hustler — Win through street sense
5. University Graduate — Earn a degree
6. Homeowner — Buy a home
7. Business Owner — Start a business
8. Debt Survivor — Finish life with no debt
9. Church Favorite — Spiritual/community respect
10. Scandal Magnet — Life people gossip about

### Legacy Ribbons (Per-Life, Cross-Life Unlocks)
11 possible ribbons. Each life earns one ribbon based on final state. Ribbons are collected across lives (unlocked once, never lost).

### Replay Incentive
- Different life goal each life (randomized)
- Different ribbon each life (based on play style)
- Achievement collection across lives
- Ribbon collection across lives
- Lives completed counter
- Legacy progress screen shows all accumulated progress
- Different career paths, relationship choices, and event outcomes per life

## 25. What A Complete Life Can Look Like

### Sample Life 1: The Hustler

- Born with high street sense (60+), low smarts (30), low discipline (20)
- Childhood: Enrolls in Primary and JHS (it's free), but doesn't pursue SHS
- Teen years: Takes Hair Braider/Barber gig at 15, Food Vendor at 17. Avoids school after JHS.
- Young adult: Applies for Trade or Hustle career (no education gate). Takes multiple side gigs. Avoids serious relationships.
- Adult: Starts Provisions Shop business. Invests in it. May start second business. Uses "Risky Hustle" activity.
- Middle age: Health begins declining. Uses doctor visits to manage. Business income + career income + side gigs give solid cash flow.
- Senior: Health decline accelerates. May die from health events or reach 90.
- Death ribbon: "The Hustler" (if street sense ≥ 75 or multiple side gigs or hustler flags)
- Life score: Moderate (cash-heavy but potentially low happiness, education, and relationships)

### Sample Life 2: The Scholar

- Born with high smarts (65+), moderate discipline
- Childhood: Primary School at 4, JHS at 10
- Teen: SHS at 13. Studies hard via activity. Maybe picks up Private Tutor side gig at 16.
- Young adult: University at 17–18 (4 years). Graduates at ~22. Applies for Healthcare or Tech career.
- Adult: Career progression through 3 levels. Finds partner at ~25. Marries at ~27. Buys home at 28+. Has 1–3 children.
- Middle age: Senior career level. Homeowner. Family growing. Strong reputation and connections.
- Senior: Well-off. Family bonds high. Health management via doctor. Dies with strong stats.
- Death ribbon: "Campus Legend" (university + high happiness/reputation) or "Local Legend" (score ≥ 75)
- Life score: High (education, marriage, homeowner, children bonuses all apply)

### Sample Life 3: The Chaotic Life

- Born with moderate stats across the board
- Teen: Drops out of education after JHS. Dates and breaks up repeatedly. Parties often.
- Young adult: Tries Hustle or Entertainment career. Cheats while dating. Gets caught. Reputation tanks.
- Adult: Serial relationships. Marriage, divorce, marriage again. High debt from legal fees and child expenses. Tries risky business that fails.
- Middle age: Multiple flags set (known_cheater, risky_hustle_trouble, family_disappointed). Debt accumulating with 8% interest. Reputation low.
- Senior: Low health from years of neglect. May die earlier from health events.
- Death ribbon: "Scandal Magnet" (if cheated/disappointed family/distant parent flags) or "Tough Life" (lowest tier)
- Life score: Low (debt penalty, low happiness, negative flags)

## 26. MVP Flow Strengths

Based on the current implementation:

1. **Complete life loop works end-to-end.** Birth → aging → progression → events → death → legacy → restart. Nothing is broken or missing in the core loop.

2. **Strong Ghanaian event flavor.** The 11,000+ lines of events include deeply Ghanaian scenarios: jollof competitions, trotro arguments, church prophecies, chieftaincy disputes, dumsor, family meetings, susu groups, market fires, WAEC drama, mobile money scams, ECG power cuts. These are not generic life sim events with Ghanaian names pasted on — they reference real Ghanaian experiences.

3. **Many interconnected systems.** Education gates careers, careers produce income, income enables housing and businesses, relationships affect happiness and reputation, health affects survival, debt affects everything. Systems talk to each other.

4. **Death and legacy system is complete.** Life scoring is multi-factor (10+ inputs). 11 legacy ribbons with unique flavor text. 10 cross-life achievements. 8 per-life goals. Lives completed counter. All persisted.

5. **Cash/debt economy creates real tradeoffs.** Every major life decision costs money. Shortfalls become debt. Debt compounds at 8% annually. This creates meaningful friction — the player can't just do everything.

6. **Activities between age-ups work.** 11 activities with age gates, stat requirements, cash costs, and real effects. Action energy system creates scarcity and choice.

7. **Achievements and replay system incentivize multiple lives.** Ribbon collection, achievement hunting, and different life goals per life encourage restarting.

8. **Saving and loading works.** Hive-based persistence. Game auto-saves after every meaningful action. Returning players resume exactly where they left off.

## 27. MVP Flow Weaknesses

Based on the current implementation:

1. **Early childhood (ages 0–5) is nearly empty.** Only 2 activities available. No school. No relationships. No jobs. Events fire but the player has almost no agency. This is typical for life sims but the player taps "Age Up" rapidly for 5+ years with minimal interaction.

2. **Childhood (ages 6–12) is thin.** School starts but there's no variability in school performance. The player just enrolls and waits. Only 3–4 activities available.

3. **Family members don't have independent lives.** They age and can die, but that's it. No events where the father gets a promotion, the mother starts a business, the sibling gets married. They're essentially stat blocks in the family panel.

4. **Children don't become independent adults.** They age each year but never leave home, get jobs, marry, or have their own children within the player's lifetime.

5. **No friendship system.** Only family and romantic relationships exist. No friends, best friends, enemies, rivals, coworkers, or neighbors.

6. **Education is deterministic.** Once enrolled, graduation is guaranteed. There's no failing, no grades, no distinction between barely passing and excelling. Just a countdown.

7. **Career is linear.** 3 levels per career. Promotions are a 40% random roll with stat gates. No lateral moves, no career switching within the same path, no unemployment events, no layoffs, no office dynamics.

8. **Businesses lack depth.** Health drift is random. Income is flat. No customers, employees, suppliers, competition, or market conditions. The main interaction is investing cash to boost health.

9. **No asset system.** Players can't own cars, land, investments, or property beyond their primary home. No generational wealth transfer.

10. **No travel, migration, or location system.** The player is always in Ghana with no ability to move between regions, travel abroad, or migrate. Events reference "going abroad" narratively but there's no system for it.

11. **Limited crime, risk, and consequence systems.** The "Risky Hustle" activity and a few events touch on risk, but there's no crime path, no jail, no legal system beyond divorce costs.

12. **Some screens feel empty at young ages.** The Job tab shows "Unemployed" with no listings from ages 0–17. The Social tab has no actions from 0–15. This is mechanically correct but visually thin.

13. **No visual character progression.** The avatar changes emoji at each life stage, but there's no visual representation of looks, health, wealth, or status beyond stats.

14. **Sound and animation are absent.** The UI is static cards and text. No sound effects, no animations for life events, no music.

## 28. What Should Be Improved Before Store Release

High-priority issues that affect MVP release quality:

1. **First 5 minutes are the weakest.** Ages 0–12 have very limited interaction. Consider adding more toddler/childhood activities, or allowing the player to start at age 13 or 18 as an option. Alternatively, add more frequent childhood events to keep the player engaged during fast age-up spam.

2. **Empty state communication.** When screens are empty (no jobs, no school programs, no relationship actions), the current messaging is good but could explain WHEN things unlock. Example: "You're too young for a job. Jobs open up around age 18."

3. **The SIM LIFE button should be removed or hidden before release.** It's a debug tool that instantly maxes life and jumps to death. Should not be visible to real players.

4. **No tutorial or guidance after onboarding.** The onboarding introduces concepts but the player is left to explore. A tooltip or first-year guided flow ("Tap Age Up to grow older") would help new players understand what to do.

5. **Stat descriptions exist but are hidden behind taps.** The bottom sheet with stat descriptions is useful but most players won't discover it. More visible stat guidance would help.

6. **Cash and Money stat confusion.** "Money" is a 0–100 stat representing financial power. "Cash" is actual GHS spendable money. This distinction is not explained anywhere and will confuse players.

7. **The life stage transition modals only fire on the boundary.** Players who skip past a stage rapidly (e.g., aging from 5 to 6 by tapping fast) see the modal but it may feel out of place. Consider when to show these.

8. **Test coverage is minimal.** There's a single `widget_test.dart` file. Core services (save, school, career, health, relationship) have no automated tests. This is risky for a store release.

9. **UI has no dark mode and uses hardcoded colors.** The theme says `Brightness.dark` in `main.dart` but all screens use light-colored backgrounds. This inconsistency should be resolved.

## 29. What Should Be Improved After Store Release

Future expansion ideas for deeper BitLife-like gameplay:

### Deeper Character Identity
- Personality traits (ambitious, lazy, charismatic, introverted) that affect event options and stat drift
- Talent/special ability selection at character creation
- Religion, ethnicity, and hometown selection
- Family wealth class affecting starting conditions
- More starting stats visibility and optional manual allocation

### Richer Relationships
- Friendship system with multiple friend slots, bond scores, and friend events
- Enemies, rivals, and social conflict
- Partner has independent career, events, and personality-driven behavior
- Children grow into adults with their own lives, careers, and families
- Extended family (cousins, aunties, uncles, grandparents) with events
- Marriage across ethnic/religious lines with family drama events
- Polygamy option (culturally relevant for parts of Ghana)

### Deeper Career System
- More career levels (5+ per path instead of 3)
- Lateral career moves and career changes
- Coworker relationships and office politics events
- Unemployment, layoffs, and job hunting difficulty
- Performance-based promotion (not just random + stat check)
- More career paths (law, engineering, agriculture, media, sports, military, politics)

### Asset and Wealth System
- Cars, land, rental properties, investments, savings accounts
- Net worth tracking beyond cash/debt
- Generational wealth (inheritance to children after death)
- Insurance (health, life, property)
- Ghana-specific assets (land in the village, cocoa farm, rental compound house)

### Expanded Life Systems
- Crime path: petty theft, fraud, sakawa, arrest, trial, prison
- Migration: move between Ghanaian regions, travel abroad, emigrate, get deported
- Health: more illnesses, hospital visits, chronic conditions, health insurance
- Education: grades, scholarships, private schools, studying abroad, postgraduate degrees
- Politics: run for local office, get involved in chieftaincy, community leadership
- Religion: church leadership, tithing, religious events, spiritual warfare events
- Social clubs: football supporters, keep fit clubs, rotating savings groups

### More Activities
- Social media (build following, get verified, get cancelled)
- Sports (play for local team, go professional)
- Creative arts (music, film, writing, painting)
- Volunteer/charity work
- Continuing education

### Event Depth
- Multi-year event chains (feuds, court cases, business sagas)
- Branching event trees based on flags
- More rare/special events
- Seasonal events (Easter, Christmas, Eid, Homowo, etc.)

### Visual and UX Polish
- Character portrait that changes with age, health, and wealth
- Animated transitions between screens
- Sound effects for key moments (age up, marriage, death)
- Background music
- Dark mode support
- Accessibility improvements

## 30. Final Summary

### What the Current Player Experience Is

Ghana Life Sim is a text-driven life simulator with a complete birth-to-death loop. The player creates a character, ages year by year, makes choices during random events, manages stats and money across multiple interconnected systems (education, career, relationships, housing, business, health), and ultimately dies with a scored legacy. The game is distinctly Ghanaian in its cultural references, event flavor, and economic framing.

### Whether the Game Has a Complete MVP Loop

**Yes.** The end-to-end loop works: create character → age up through life stages → experience events → progress through systems → die → receive score/rating/ribbon → restart. All screens are functional. All services are connected. Save/load works. Legacy tracking works across lives.

### What the First-Time Player Can Do

- Go through a 4-page onboarding
- Create a character (name + gender)
- See their randomized stats and starting family
- Age up (the core mechanic)
- From age 0: Rest activity, view family
- From age 4: Enroll in Primary School
- From age 5: Study activity
- From age 6: Pray activity
- From age 12: Exercise activity
- From age 13: Enroll in SHS (if JHS completed)
- From age 16: Meet someone, party, side gigs, risky hustle

### What Becomes Available Later

Full career system, university, marriage, children, home ownership, businesses, and the complete activity set all unlock between ages 16–28. The game expands significantly in young adulthood.

### What the Biggest Missing Depth Is

The early game (ages 0–12) is thin. Family members, children, and partners don't have independent lives. The career system is basic (3 levels per path). There are no friendships, no assets beyond the primary home, no crime system, and no travel/migration. The game has solid bones but many systems would benefit from the depth described in Section 29.

### Whether This Is Ready for Screenshot Planning and Manual Testing

**Yes.** The game has enough UI, enough content, and enough working systems to generate meaningful screenshots and conduct a full manual playthrough. The death screen is visually polished. The life dashboard shows rich character state. Events have strong narrative flavor. A tester can experience a complete life from birth to death with meaningful choices along the way. The areas that need attention before store release are outlined in Section 28.
