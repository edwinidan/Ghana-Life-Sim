# Ghana Life Sim Store Release Checklist

Created: 2026-07-09

## Current Release Status

MVP 1 is close to closed/internal testing readiness. Automated tests, analyzer, Android release APK, Android App Bundle, iOS release device build, and a wireless iPhone release launch pass. Android physical-device testing, full manual gameplay smoke testing, final screenshots, live privacy/support URLs, Android upload signing, and iOS archive/TestFlight upload still need completion.

## Android Checklist

| Item | Status | Notes |
|---|---|---|
| App name finalized | Ready | Android display label is `Ghana Life Sim`. |
| Package name checked | Ready | `applicationId` and namespace are `com.wesleyconsults.ghanalifesim`. |
| Launcher icon set | Partial | `pubspec.yaml` points to `ghanalife.png`; regenerate and inspect icons before release. |
| Version name/build number ready | Partial | Current version is `1.0.0+1`. Confirm before first upload. |
| App runs in debug mode | Needs Android device check | No Android phone/emulator was connected. |
| App runs in release mode | Partial | Release APK and AAB build pass; real Android install/run still needed. |
| No debug banners | Ready in code | `debugShowCheckedModeBanner: false`; verify visually on device. |
| Privacy policy URL planned | Drafted | See `PRIVACY_POLICY_DRAFT.md`; publish a real URL before upload. |
| Store listing text drafted | Drafted | See `STORE_METADATA_DRAFT.md`. |
| Screenshots planned | Drafted | See `SCREENSHOT_PLAN.md`; screenshots not captured yet. |
| Closed testing readiness | Needed | Prepare testers, release notes, and feedback channel. |
| Production access readiness | Needed | Complete Play Console declarations and production access requirements. |
| Upload signing | Needed | Current Gradle release config still uses debug signing; configure upload key before Play upload. |

## iOS Checklist

| Item | Status | Notes |
|---|---|---|
| Bundle ID planned | Ready | Bundle ID is `com.wesleyconsults.ghanalifesim`. |
| App name finalized | Ready | iOS display name is `Ghana Life Sim`. |
| Launcher icon set | Partial | `pubspec.yaml` points to `ghanalife.png`; inspect generated iOS icon assets. |
| Version/build number ready | Partial | Current version is `1.0.0+1`. Confirm before TestFlight. |
| App runs on iPhone | Partial | Release launch succeeded on detected wireless iPhone; full manual gameplay test still needed. |
| App runs in release/archive mode | Partial | `flutter build ios --release` passes; archive/TestFlight signing still needs Xcode validation. |
| Privacy policy URL planned | Drafted | See `PRIVACY_POLICY_DRAFT.md`; publish a real URL before upload. |
| App Store metadata drafted | Drafted | See `STORE_METADATA_DRAFT.md`. |
| Screenshots planned | Drafted | See `SCREENSHOT_PLAN.md`; screenshots not captured yet. |
| TestFlight readiness | Needed | Prepare internal and external test notes. |
| App Review readiness | Needed | Verify no crashes, no placeholder metadata, and correct privacy disclosures. |

## Store Listing Draft

Short description:

Ghana Life Sim is a Ghanaian life simulation game where every year brings choices, drama, money pressure, family expectations, love, school, hustle, and legacy.

Full description draft:

Create a character and live a full Ghanaian life, one year at a time. Go through school, find work, build relationships, start a family, chase money, manage debt, try side hustles, open businesses, and face events inspired by Ghanaian culture. Every choice can change your stats, cash, reputation, health, and future opportunities.

Play until the end of life, earn a legacy ribbon, unlock achievements, and start again to see a different story.

## Screenshot Plan

- Character creation
- Main life dashboard with stats, cash, goal, and life log
- Ghanaian event choice dialog
- Activities/action energy view
- Education or career screen
- Relationship/family screen
- Business or housing screen
- Death summary with score and ribbon

## Pre-Submission Must-Do

- Confirm the new package/bundle IDs are not already reserved elsewhere.
- Configure Android upload signing.
- Generate and inspect launcher icons.
- Install and run the release AAB/APK on Android hardware or emulator.
- Archive in Xcode and upload to TestFlight.
- Complete one manual full-life playthrough.
- Publish privacy policy and support pages.
- Capture store screenshots.
- Confirm save/load and restart work after app kill/reopen.
