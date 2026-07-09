# Ghana Life Sim MVP 1 Scope

Created: 2026-07-09

## MVP 1 Goal

Prepare Ghana Life Sim as a complete, polished, playable vertical slice for Google Play Store closed testing, TestFlight, and production-release preparation.

MVP 1 should feel like a real mobile game with a clear loop, meaningful choices, Ghanaian cultural tone, local saving, death summary, and restart. It should not try to become the final BitLife-depth version before release.

## Core Player Loop

1. Player creates a character.
2. Player sees the life dashboard.
3. Player ages up year by year.
4. Player receives culturally authentic Ghanaian events.
5. Player makes choices with visible consequences.
6. Player spends action energy on activities between age-ups.
7. Player progresses through school, work, money, relationships, family, housing, business, goals, and achievements.
8. Player eventually dies.
9. Player receives a death summary with score, ribbon, legacy, and unlocks.
10. Player restarts and plays another life.

## Included In MVP 1

- Character creation with name and gender
- Onboarding or intro flow
- Main life dashboard
- Age-up loop
- Weighted event system
- Event choices with stat, cash, debt, flag, career, health, relationship, and housing consequences
- GHS cash and debt economy
- Education progression
- Career paths and promotions
- Side gigs
- Relationships
- Marriage, breakup, divorce, and widowhood states
- Children and basic family tracking
- Housing progression
- Business ownership and yearly business progression
- Activities and action energy
- Life goals
- Achievements and cross-life meta-progress
- Death screen
- Legacy ribbons
- Local save/load
- Restart life

## Postponed Until After MVP 1

- Deep crime system
- Deep friends/enemies system
- Children having full independent lives
- Parents and siblings full life simulation
- Cars, land, investments, and broader asset ownership
- Abroad/travel system
- Chieftaincy and politics system
- Deep monetization
- Cloud save
- Account system
- Leaderboards
- Multiplayer or social accounts

## MVP Quality Bar

- First five minutes are understandable and lively.
- Age-up is obvious and satisfying.
- Dashboard clearly shows age, stats, cash, debt, current goal, action energy, and recent life log.
- Events should not feel placeholder, broken, or confusing.
- Activities should give the player useful agency between age-ups.
- Death and restart should feel rewarding enough to encourage another run.
- Local saves must work reliably.
- Analyzer must be clean.
- Core tests must pass before store testing.

## Known MVP Limitations

- Family and children are tracked, but they do not yet run full independent simulations.
- Activities are intentionally limited to a small high-impact set.
- Some long-term systems are simple rather than deep.
- Save data is local only.
- Meta-progress uses SharedPreferences and may reset if app data is cleared.
- Store release preparation is in progress: metadata, privacy policy, and screenshot plan are drafted, but screenshots, live URLs, Android upload signing, and TestFlight archive/upload are not complete yet.

## After Store Release

The next phase should deepen replayability through event chains, richer family/friend simulation, more activities, assets, travel/abroad paths, crime/risk depth, and broader Ghana-specific systems.
