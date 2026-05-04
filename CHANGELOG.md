# Changelog

All notable changes to the racked.ru launcher (PrismLauncher fork).

## [Unreleased] — 2026-04-30

### News feed
- `Launcher_NEWS_RSS_URL` → `https://racked.ru/feed.xml` (was `prismlauncher.org/feed/feed.xml`)
- `Launcher_NEWS_OPEN_URL` → `https://racked.ru/news`
- News toolbar **hidden by default** (`Application.cpp` post-restoreState `findChild<QToolBar*>("newsToolBar")->hide()`). Re-enable via View menu

### Default settings (ported runtime cfg → source defaults)
| Setting | Old | New |
|---|---|---|
| `MinMemAlloc` | 512 | 384 |
| `MaxMemAlloc` | `SysInfo::defaultMaxJvmMem()` | 4096 |
| `MenuBarInsteadOfToolBar` | false | true |

### Window geometry baked defaults
First-run windows open at user-tested sizes:
- Main: 346×265
- New Instance dialog: 1112×507
- News dialog: 799×499
- Console: 782×705
- Paged settings: 871×649

(`Application.cpp` registerSetting blobs replace empty-string defaults.)

### Status bar redesign
**Per-instance (left) — `MinecraftInstance::getStatusbarDescription()`:**
- Dropped `Minecraft <version>` prefix (already shown on instance card)
- Dropped redundant per-instance "total played for X" (global widget covers it)
- Absolute timestamp `28/04/2026 14:15` → relative `2d ago`
- Comma separator → em dash `—`
- Duration: `3h 24min` → minutes only `204 min` (server parity)

**Global (center):**
- `Total playtime: 16h 26min` → `Total: 986 min` (minutes only)

**Result:**
```
Before: Minecraft 1.21.10, last played on 28/04/2026 14:15 for 3h 24min, total played for 16h 26min  Total playtime: 16h 26min
After:  last played 2d ago — 204 min                                                                  Total: 986 min
```

**New helper:** `Time::relativePast(QDateTime)` in `MMCTime.{h,cpp}` — buckets `just now`, `Nm/h/d/w/mo/y ago`.

`Time::prettifyDuration` "min"/"m" suffix shortened to `m` (only call site is status bar).

### Help menu cleanup
Reddit + Discord + Matrix entries → single **Website** entry pointing at `https://racked.ru`.
- `MainWindow.ui`, `MainWindow.h`, `MainWindow.cpp` — actions/slots/handlers consolidated

### First-launch UX
If `accounts->count() == 0` on startup, show offline-username dialog (skip-able). Hooked at end of `MainWindow` ctor via `QTimer::singleShot(0, ...)`.

### ChooseOfflineNameDialog cleanup
- Window title: `Choose Offline Name` → `Pick a username`
- Removed `Allow invalid usernames` checkbox + slot
- Removed `Message label placeholder` body label
- Constructor still takes `message` arg for ABI compat (now unused via `Q_UNUSED`)
- Validator unchanged: `[A-Za-z0-9_]{3,16}`

### Bloat strips
**Source-side (~4M removed, ~2M off compiled binary):**
- `.github/` (136K)
- `tests/` + `BUILD_TESTING` block in root `CMakeLists.txt` (928K)
- `nix/`, `flake.nix`, `flake.lock` (28K)
- `launcher/resources/multimc/` icon theme (3M)

**multimc → racked_ru migration:**
- 71 instance icons (32x32, 50x50, 128x128, scalable) copied into `launcher/resources/racked_ru/`
- `racked_ru.qrc` extended with `prefix="/icons/racked_ru"` resource block
- `Application.cpp:950` instance icon paths repointed `multimc` → `racked_ru`
- `ThemeManager.h:94` `builtinIcons{"flat_white", "multimc"}` → `{"flat_white", "racked_ru"}`
- `launcher/CMakeLists.txt:1284` dropped `resources/multimc/multimc.qrc` from `qt_add_resources()`
- `launcher/main.cpp:56` dropped `Q_INIT_RESOURCE(multimc);`

**Runtime-side (`/home/admin/ai-lab/_projects/_minecraft/launcher/`, ~200M removed):**
- `java/java21.tar.gz` (extracted leftover): 198M
- Syncthing `*sync-conflict*` files: ~340K
- `cache/*` wipe: 5.5M

### Project relocation
Moved source from `_projects/_minecraft/source/` → `_github/minecraft-launcher/` (sibling pattern to `_github/minecraft-server`). Runtime build target stays at `_projects/_minecraft/launcher/` for daily-driver testing. Existing `.gitignore` excludes `build-*`, `install-*`, `release/`.

### Documentation
New docs in `docs/`:
- `SETTINGS_AUDIT.md` — runtime cfg vs source defaults diff
- `NETWORK_AUDIT.md` — full endpoint inventory; zero telemetry confirmed
- `BLOAT_AUDIT.md` — strippability tiers
- `CHANGES_2026-04-30.md` — pre-changelog session notes (superseded by this file)

---

## Pending
- Replace placeholder `s8n-ru/minecraft-launcher` repo URL with real GitHub slug
- Stand up `https://racked.ru/feed.xml` (RSS feed) so news pane populates
- Decide: ship `accounts.json`-free portable release (already clean in `release/`)
