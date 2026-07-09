# Ghana Life Sim Screenshot Plan

Created: 2026-07-09

Sources checked:

- Google Play Console Help, "Add preview assets to showcase your app": https://support.google.com/googleplay/android-developer/answer/9866151
- Apple App Store Connect Help, "Screenshot specifications": https://developer.apple.com/help/app-store-connect/reference/app-information/screenshot-specifications/

## Screenshot Strategy

Use real in-game screens from the MVP 1 build. Keep screenshots honest and focused on the actual play loop. Avoid showing features that are postponed until after MVP 1.

Google Play allows up to 8 screenshots per supported device type and requires at least 2 screenshots across device types. Google highly recommends at least 4 screenshots at 1080px+ resolution, using 9:16 portrait or 16:9 landscape, and screenshots should depict actual app/game experience.

Apple requires 1 to 10 screenshots in JPEG, JPG, or PNG per device screenshot set. Because the app currently supports iPad orientations, iPad screenshot requirements should be planned unless iPad support is intentionally limited before submission.

## Planned Screenshots

| # | Screen | What Player Should See | Suggested Caption | Why It Helps |
|---|---|---|---|---|
| 1 | Character creation | Name field, gender selection, clear begin button | Start Your Ghanaian Life | Shows the beginning of the core loop. |
| 2 | Main life dashboard | Age, stats, cash/debt, life goal, action energy, recent log | Every Year Brings A Choice | Shows the main gameplay hub. |
| 3 | Ghanaian event choice | Event dialog with culturally specific choice options | Choose Carefully, Wahala Is Real | Shows the choice-and-consequence hook. |
| 4 | Activities | Between-age-up activity list and energy | Spend Your Year Wisely | Shows player agency outside events. |
| 5 | School/career or business | Career, school, or business progress screen | Study, Work, Hustle | Shows progression systems. |
| 6 | Relationship/family | Partner/family/children information | Love, Family, Pressure | Shows social and family simulation. |
| 7 | Death/legacy ribbon | Final score, rating, ribbon, restart option | What Legacy Did You Leave? | Shows completion, reward, and replayability. |

## Google Play Phone Screenshots

Plan:

- Capture 7 portrait screenshots.
- Recommended export: 1080 x 1920 PNG or JPEG, no alpha.
- Acceptable limits from Google: minimum 320px, maximum 3840px, with the maximum dimension no more than twice the minimum dimension.
- Keep all captions inside the app screenshot artwork minimal and avoid claims like "best", "#1", "top", or promotional pricing.

## Google Play Tablet Screenshots

If distributing to tablets:

- Add at least 4 tablet screenshots for large screens.
- Use 9:16 portrait or 16:9 landscape.
- Upload screenshots between 1080 and 7680px.
- Avoid extra text outside core app experience because it may be cropped on Play surfaces.

## iPhone Screenshots

Primary plan:

- Capture iPhone 6.9-inch portrait screenshots if possible.
- Accepted 6.9-inch portrait sizes include 1260 x 2736, 1290 x 2796, and 1320 x 2868.
- Include 1 to 10 screenshots.

Fallback/compatibility:

- If 6.9-inch screenshots are not provided, Apple requires 6.5-inch screenshots for apps running on iPhone.
- 6.5-inch accepted portrait sizes include 1284 x 2778 and 1242 x 2688.
- 5.5-inch portrait size is 1242 x 2208.

## iPad Screenshots

Because the current iOS project supports iPad orientations, plan iPad screenshots unless iPad support is intentionally removed before submission.

Primary plan:

- Capture 13-inch iPad portrait screenshots.
- Accepted 13-inch portrait sizes include 2064 x 2752 and 2048 x 2732.
- Apple marks 13-inch screenshots as required if the app runs on iPad.

## Capture Checklist

- Use a clean new life with no debug banner.
- Use readable character names and varied event outcomes.
- Show real UI, not mockups.
- Verify no text overflow before capturing.
- Capture Android and iOS separately if platform chrome/layout differs.
- Keep screenshots aligned with the MVP 1 scope.
