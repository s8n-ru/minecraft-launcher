# Network & Telemetry Audit — racked.ru launcher (PrismLauncher fork)

**Date:** 2026-04-30
**Scope:** `source/` tree — what the launcher contacts over the network, and whether anything phones home.

## Verdict: No telemetry, no analytics, no crash reporting.

Grep for `sentry|analytics|telemetry|tracking|google-analytics|mixpanel|amplitude|posthog|crashreport` across `*.cpp/*.h/CMakeLists` returns **zero hits**. (One false positive: a contributor's email `sentrycraft123@gmail.com` in copyright headers — unrelated to Sentry SDK.)

PrismLauncher upstream has never shipped telemetry. This fork preserves that.

---

## News feed — does it pull from online?

**Yes.** It is an RSS feed download.

- Code: `source/launcher/news/NewsChecker.cpp` constructs a `NetJob` and downloads the feed configured at build time.
- Caller: `source/launcher/ui/MainWindow.cpp:279`
  ```cpp
  m_newsChecker.reset(new NewsChecker(APPLICATION->network(), BuildConfig.NEWS_RSS_URL));
  ```
- URL is set in `source/CMakeLists.txt`:
  ```cmake
  set(Launcher_NEWS_RSS_URL  "https://prismlauncher.org/feed/feed.xml" ...)
  set(Launcher_NEWS_OPEN_URL "https://prismlauncher.org/news"          ...)
  ```
- Trigger: fires on launcher startup (constructor of MainWindow).

**Implication for racked.ru fork:**
- Currently still hitting `prismlauncher.org` for news. If you want zero outbound to upstream, override at CMake configure time:
  ```bash
  -DLauncher_NEWS_RSS_URL=https://racked.ru/feed.xml \
  -DLauncher_NEWS_OPEN_URL=https://racked.ru/news
  ```
  Or set both to empty string to disable. (Empty URL → `NetJob` fails silently.)

---

## All network endpoints in source

Grouped by purpose. None are telemetry.

### Auth / account (Microsoft / Mojang) — required to play
- `https://login.microsoftonline.com/consumers/oauth2/v2.0/{authorize,devicecode,token}`
- `https://login.live.com/login.srf`
- `http://auth.xboxlive.com`
- `https://api.minecraftservices.com/...` (profile, skins, capes, entitlements, MSA migration)
- `https://account.microsoft.com/family/`
- `https://help.minecraft.net/...`

### Game assets
- `https://libraries.minecraft.net/`

### Mod platforms (user-driven)
- `https://api.modrinth.com/v2`, `https://modrinth.com/mod/`, `https://docs.modrinth.com/...`
- `https://api.curseforge.com/v1`, `https://docs.curseforge.com/`
- `https://api.atlauncher.com/v1/`, `http://api.technicpack.net/modpack/`
- `https://api.feed-the-beast.com/v1/modpacks/public`, `https://dist.creeper.host/FTB2/`

### Pastebins (user-driven, log upload)
- `https://api.mclo.gs`, `https://api.paste.gg/v1/pastes`, `https://hst.sh`, `https://0x0.st`
- `https://api.imgur.com/3/`, `https://imgur.com/a/`

### Updater / news / help (Prism)
- `https://api.github.com/repos/...` — version checks
- `https://prismlauncher.org/feed/feed.xml` — news RSS (see above)
- `https://prismlauncher.org/news` — "More news" button
- Help URL template in CMake: `https://prismlauncher.org/wiki/help-pages/%1`
- Bug tracker: `https://github.com/Diegiwg/PrismLauncher-Cracked/issues` ← **upstream-fork URL, points at the original "Cracked" project**
- Translations: `https://hosted.weblate.org/projects/prismlauncher/launcher/`
- Matrix/Discord/Subreddit: all `prismlauncher.org` redirects

### Documentation links (opened in browser only when user clicks)
- `minecraft.wiki`, `fabricmc.net/wiki`, `docs.microsoft.com`, etc.

---

## Risk summary

| Vector | Risk | Mitigation |
|---|---|---|
| Telemetry | None | n/a |
| Crash reporting | None | n/a |
| News RSS leaks IP to prismlauncher.org on startup | Low (single GET, no UA fingerprint beyond `Launcher_UserAgent` = `PrismLauncher/<version>`) | Override `Launcher_NEWS_RSS_URL` to racked.ru or empty |
| Update check via api.github.com | Low (anonymous, rate-limited) | Override `BUG_TRACKER_URL` and consider disabling updater path |
| User-Agent identifies fork by name + version | Low | Override `Launcher_UserAgent` if anonymity desired |

---

## Recommended CMake overrides for racked.ru build

```cmake
-DLauncher_NEWS_RSS_URL=https://racked.ru/feed.xml
-DLauncher_NEWS_OPEN_URL=https://racked.ru/news
-DLauncher_HELP_URL=https://racked.ru/help/%1
-DLauncher_BUG_TRACKER_URL=https://racked.ru/bugs
-DLauncher_MATRIX_URL=https://racked.ru/matrix
-DLauncher_DISCORD_URL=https://racked.ru/discord
-DLauncher_SUBREDDIT_URL=https://racked.ru
-DLauncher_TRANSLATIONS_URL=https://racked.ru/translate
```

Or set them blank to disable the menu items entirely.
