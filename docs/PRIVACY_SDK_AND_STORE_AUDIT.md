# Privacy, SDK, and Store Audit

Date: 26 July 2026

## Factual privacy draft

- Account required: no.
- Advertising: none.
- In-app purchases: none.
- Analytics: none.
- Crash-reporting SDK: none.
- Tracking: none.
- Network API used by release application code: none.
- Player data uploaded: none.
- Local data: save state, backup state, settings, achievements, and life progress.
- Data linked to an identity: none; the app has no account or identifier system.
- Android dangerous permissions: none.
- iOS privacy usage descriptions: none, because no protected hardware/data API is used.

Android debug/profile manifests include Internet access for Flutter tooling; the main release manifest does not request Internet access. Android packaging adds only the app-scoped dynamic-receiver permission.

## Direct runtime packages

| Package | Purpose | Network/data implication |
|---|---|---|
| Flutter | UI/runtime | None by itself |
| flutter_riverpod | State management | None |
| Hive / hive_flutter | Local save and backup | Device-local data |
| shared_preferences | Local settings/meta progress | Device-local data |
| cupertino_icons | Icons | None |

Build/test-only packages are not runtime data-collection SDKs: build_runner, hive_generator, flutter_launcher_icons, flutter_lints, and flutter_test. The journey suite uses the standard test binding, so no native integration-test plugin is present in release artifacts.

## Store declarations

Subject to final store-console wording and confirmation on the submitted binary:

- Google Play Data safety: no collected or shared user data.
- Apple App Privacy: data not collected.
- Ads declaration: app contains no ads.
- Tracking permission: not used.
- Purchases: none.
- Export compliance: review the standard Flutter cryptography/network-runtime declaration in App Store Connect; no custom encryption feature is implemented.

## Unresolved publication inputs

- A public privacy-policy URL has not been supplied.
- A support URL and support email have not been supplied.
- The in-app privacy row is factual copy, not a tappable public policy link.
- Final age/content-rating answers and review contact are owner/store-console decisions.

These missing public contact/policy inputs block store submission even though the binary itself has no known collection SDK.
