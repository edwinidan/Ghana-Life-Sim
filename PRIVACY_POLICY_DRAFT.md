# Ghana Life Sim Privacy Policy Draft

Last updated: 2026-07-09

Contact: wesleyconsults@gmail.com

## Overview

Ghana Life Sim is a mobile life simulation game. Players create a fictional character, make choices, progress through life events, and view local game progress such as saves, achievements, and life summaries.

This draft reflects the current MVP 1 codebase reviewed on 2026-07-09.

## Data Stored On Your Device

Ghana Life Sim stores gameplay data locally on your device so the game can save and resume your progress. This may include:

- Fictional character name and gender entered by the player
- Character age, stats, cash, debt, relationships, family, education, career, business, health, goals, and life log
- Save-game data stored with Hive local storage
- Onboarding and meta-progress data stored with SharedPreferences
- Achievements, completed goals, legacy ribbons, and completed-life counts

This data is used only to run the game and restore your local progress.

## Data Collection

Based on the current MVP 1 codebase, Ghana Life Sim does not include:

- Account registration or login
- Cloud sync
- Backend server communication
- Analytics SDKs
- Crash reporting SDKs
- Advertising SDKs
- In-app purchase SDKs
- Push notifications
- Location access
- Camera or photo library access
- Contacts access
- Microphone access

The production Android manifest does not request Internet permission. Android debug/profile manifests include Internet permission for Flutter development tooling only.

## Data Sharing

Based on the current MVP 1 codebase, Ghana Life Sim does not transmit player gameplay data to Wesley Consults or third parties.

If future versions add analytics, crash reporting, ads, cloud saves, accounts, or purchases, this policy should be updated before release.

## Children's Privacy

Ghana Life Sim is not designed to knowingly collect personal information from children. The app stores fictional gameplay progress locally on the user's device. If future versions introduce online services or data collection, additional child privacy review may be required before release.

## Ads, Analytics, And Purchases

The current MVP 1 codebase does not include ads, analytics, crash reporting, or in-app purchases.

## Data Deletion

Players can delete local gameplay progress by deleting the saved game in the app, clearing app storage, or uninstalling the app. Because the current MVP stores data locally only, uninstalling or clearing app data may permanently remove saves and meta-progress.

## Contact

For privacy questions, contact:

wesleyconsults@gmail.com
