# Accessibility, Device, and Performance QA

Date: 26 July 2026

## Automated accessibility and layout

Passed:

- Meaningful semantic label for the primary age-up action.
- Semantic timeline headings and combined age-entry descriptions.
- Text scale checks at 160% and 200%.
- Small 320×568 logical-pixel phone layout at 200% text.
- iPad-sized 1024×1366 logical-pixel layout at 160% text.
- Primary destinations, timeline, ledger sheet, and health state render without test exceptions.
- Positive/negative outcomes include signed text and values rather than relying only on colour.
- Persistent haptics preference; all haptic actions also have visible UI feedback.
- Persistent reduced-motion preference and system `disableAnimations` support.
- Portrait-only orientation policy on Android, iPhone, and iPad.

The 200% small-phone test initially found a two-pixel navigation overflow. The navigation height is now text-scale aware and the regression test passes.

## Runtime matrix

| Target | Result |
|---|---|
| macOS 26.5.1 integration host | 12/12 journeys passed |
| iPhone 17e simulator, iOS 26.5 | 12/12 journeys passed |
| iPad mini (A17 Pro) simulator, iOS 26.5 | 12/12 journeys passed |
| Physical iPhone, iOS 26.4.2 | Listed wirelessly, but did not establish the test connection |
| Android phone/emulator | No target available |

The integration suite covers save/relaunch, education, NSS, jobs, relationships, debt, business, illness treatment/death, legacy rewards, migration, and interrupted age-up isolation.

## Performance

- 10,000 deterministic lives completed in 174.576 seconds.
- 721,581 simulated years completed at 4,133.33 headless years/second.
- Timeline uses lazy `SliverList.builder`.
- Event-history lookups are indexed per selection.
- Headless simulation uses no presentation code.

Cold/warm launch time, frame timing during long timeline scrolling, and device memory were not instrumented in this local pass. These remain closed-test measurements, not claimed passes.

## Manual accessibility work still required

- TalkBack on representative Android hardware.
- VoiceOver on physical iPhone.
- Switch Control/external keyboard focus review.
- Manual focus return for every modal.
- Contrast measurement with a dedicated auditing tool.
- Low-memory Android process-death and long-scroll testing.

No automated release-blocking clipping defect remains known, but store release remains blocked until the manual screen-reader and Android device matrix is completed.

