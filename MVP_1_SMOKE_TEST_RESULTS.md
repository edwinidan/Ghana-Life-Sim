# Ghana Life Sim MVP 1 Smoke Test Results

Created: 2026-07-09

## Summary

Automated MVP spine checks pass. The app also installed and launched on a detected wireless iPhone in release mode. A complete manual tap-through of all requested life paths has not yet been completed in this environment. The available environment currently shows macOS, Chrome, and one wireless iPhone; no Android phone/emulator is connected.

This file should be updated during the first real device smoke-test session.

## Automated Smoke Coverage Completed

| Flow | Result | Evidence |
|---|---|---|
| Character creation creates valid character | Pass | `flutter test` |
| Age-up basics do not crash | Pass | `flutter test` |
| Event choices apply stat/cash/debt/flag/status changes | Pass | `flutter test` |
| Activity/action energy behavior | Pass | `flutter test` |
| Life goal detection | Pass | `flutter test` |
| Achievement/meta-progress safety | Pass | `flutter test` |
| Death state and restart/new life basics | Pass | `flutter test` |
| Save/load/delete | Pass | `flutter test` |

## Manual Flow Checklist

| Flow | Status | Notes |
|---|---|---|
| Fresh install/open app | Partial | iPhone release launch succeeded; visual first-screen and cleared-data checks still needed. |
| Onboarding/first screen | Not completed | Needs visual check. |
| Create male character | Not completed | Needs visual check. |
| Create female character | Not completed | Needs visual check. |
| Age from childhood to teen | Not completed | Needs manual playthrough. |
| Age from teen to adult | Not completed | Needs manual playthrough. |
| Education flow | Not completed | Needs manual playthrough. |
| Career flow | Not completed | Needs manual playthrough. |
| Side gig flow | Not completed | Needs manual playthrough. |
| Relationship flow | Not completed | Needs manual playthrough. |
| Marriage/breakup/divorce flow | Not completed | Needs manual playthrough. |
| Children/family display | Not completed | Needs manual playthrough. |
| Housing flow | Not completed | Needs manual playthrough. |
| Business flow | Not completed | Needs manual playthrough. |
| Activities/action energy | Partial | Automated tests pass; visual/manual test still needed. |
| Life goal display/completion | Partial | Automated tests pass; visual/manual test still needed. |
| Achievement/meta-progress screen | Partial | Automated tests pass; visual/manual test still needed. |
| Debt-heavy playthrough | Not completed | Needs manual playthrough. |
| Low-health/death flow | Partial | Automated tests pass; visual/manual test still needed. |
| Restart after death | Partial | Automated tests pass; visual/manual test still needed. |
| Close app and reopen save/load | Partial | Automated Hive save/load passes; real device reopen still needed. |

## Issues Found

No manual gameplay issues have been reproduced yet because the full manual smoke test still needs a device session.

Use this format for each issue:

- Screen:
- Steps to reproduce:
- Expected result:
- Actual result:
- Severity:
- Suggested fix:

## Required Next Manual Session

1. Install release APK on Android phone or emulator.
2. Clear app data.
3. Complete the full flow checklist above.
4. Repeat on iPhone simulator or physical iPhone.
5. Add every issue found to this file.
