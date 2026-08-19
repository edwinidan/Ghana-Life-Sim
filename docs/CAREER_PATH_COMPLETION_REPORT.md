# Career Path Completion Report

Date: 19 August 2026

## Outcome

The life-path completion milestone is implemented and locally validated. Ghana Life Sim now has nine viable career paths, field-specific education, selectable NSS placements, explainable job gates, an active employment lifecycle, retirement pensions, and save-schema-v4 migration.

## Player-facing changes

- Education now records a field of study rather than only a broad level.
- Nursing and Allied Health College and Teacher Training College are separate paths.
- University offers Health Sciences, Engineering and Technology, Business and Administration, Education, and Arts, Media and Sport.
- TVET and apprenticeships grant Technical Trade specialization.
- NSS offers Public Administration, Health Service, Education Service, Digital and Engineering, Private Enterprise, and Media and Sports Development placements.
- Completing NSS builds connections and reputation and grants a retention advantage in the matching career.
- Commerce and Sports & Media join the original seven careers.
- Locked jobs remain visible and explain every missing requirement.
- Employed characters have performance, tenure, work-hard and career-review actions, raises, promotions, dismissal/redundancy risk, and retirement pensions.
- Commerce and Sports & Media each have five dedicated career events.
- Merit aid reduces fees for strong students while retaining a real education cost.

## Compatibility and defects fixed

- Save schema advanced from version 3 to version 4 with defaults for all new fields.
- Existing employed characters retain their career and receive an inferred matching specialization.
- Existing unemployed tertiary graduates receive a legacy broad-degree compatibility flag.
- Existing generic University and combined Nursing / Teacher Training enrollment records remain completable.
- Fixed a pre-existing progression defect where graduates could re-enrol in Primary School, overwrite their qualification, and repeat the school ladder indefinitely.

## Validation

- `flutter analyze`: no issues.
- `flutter test`: 39 tests passed.
- Headless balance run: 10,000 lives and 718,613 simulated years.
- Ever employed: 82.6%.
- NSS completed: 60.2%.
- Stuck progression: 0.0%.
- Repeated events: 0.
- Debt at death: 24.4%.
- Recovered from debt at least once: 50.6%.

Every path was entered in autonomous lives:

| Career | Lives that entered path |
| --- | ---: |
| Hustle | 2,816 |
| Trade | 2,811 |
| Civil Service | 1,464 |
| Tech | 1,318 |
| Entertainment | 1,195 |
| Healthcare | 432 |
| Education | 408 |
| Commerce | 295 |
| Sports & Media | 269 |

Full repeatable output:

- `build/reports/career_path_milestone/balance_simulation.json`
- `build/reports/career_path_milestone/balance_simulation.md`

## Recommended next work

Run physical Android and iOS gameplay QA across at least these journeys:

1. SHS → Health Sciences → Health Service NSS → Healthcare → retirement.
2. SHS → Business → Private Enterprise NSS → Commerce → dismissal and re-employment.
3. SHS → Arts, Media and Sport → Media and Sports NSS → Sports & Media.
4. JHS → TVET or apprenticeship → Trade or Tech.
5. Legacy schema-v3 graduate → migration → continued education or employment.

Monetization should remain deferred until these journeys feel good on physical devices and accessibility services.
