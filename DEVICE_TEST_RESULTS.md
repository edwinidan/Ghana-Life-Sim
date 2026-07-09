# Ghana Life Sim Device Test Results

Created: 2026-07-09

## Device Availability

`flutter devices` found:

- macOS desktop
- Chrome web
- Wireless iPhone running iOS 26.4.2

No Android phone or Android emulator was connected during this sprint.

## Android

| Check | Result | Notes |
|---|---|---|
| Android debug build | Pass | `flutter build apk --debug` previously passed. |
| Android release APK build | Pass | Release APK build passed. |
| Android App Bundle build | Pass | Built `build/app/outputs/bundle/release/app-release.aab` at 43.7MB. |
| Real Android phone run | Not completed | No Android phone connected. |
| Android emulator run | Not completed | No emulator was running. |
| UI overflow check | Not completed | Needs real phone/emulator visual pass. |
| Save/load on device | Not completed | Needs app kill/reopen test. |
| Navigation/death/restart | Not completed | Needs manual playthrough. |

## iOS

| Check | Result | Notes |
|---|---|---|
| iOS simulator debug build | Pass | Previously built `build/ios/iphonesimulator/Runner.app`. |
| iOS release build | Pass | Built `build/ios/iphoneos/Runner.app` at 20.3MB. |
| Physical iPhone run | Partial pass | `flutter run -d 00008030-000E791A1EB9802E --release --no-resident` installed and launched successfully over wireless. |
| Xcode archive/signing | Not completed | Must be completed in Xcode before TestFlight. |
| UI overflow check | Not completed | Needs simulator/device visual pass. |
| Save/load on device | Not completed | Needs app kill/reopen test. |
| Navigation/death/restart | Not completed | Needs manual playthrough. |

## Notes

- Do not claim App Store/TestFlight readiness until iOS archive and signing are verified.
- Do not claim Play Store closed-testing readiness until Android upload signing is configured and an Android device/emulator smoke test passes.
