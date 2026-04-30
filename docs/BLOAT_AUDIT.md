# Bloat Audit — racked.ru launcher

**Date:** 2026-04-30
**Total runtime size:** ~1.3 GB (`launcher/`)
**Goal:** identify what's strippable without breaking "load Minecraft reliably"

---

## TL;DR

| Category | Size | Strippable? |
|---|---|---|
| Mojang game assets (`assets/`) | 552M | **No** — needed by MC |
| Bundled Java 21 (`java/jdk-21.0.9+10/`) | 346M | No, but see below |
| Java tar.gz leftover (`java/java21.tar.gz`) | **198M** | **YES — instant win** |
| MC libraries (`libraries/`) | 99M | No |
| User instance (`instances/Fabulously Optimized/`) | 88M | No (user data) |
| Launcher binary (`bin/prismlauncher`) | 15M | Partial (strip + LTO) |
| Cache (`cache/`) | 5.5M | Yes (regenerated) |
| Translations | 692K | Mostly (see below) |
| Misc state (logs, metacache, sync-conflicts) | ~1M | Yes |

**Quick wins:** **~200 MB instantly** (java tar.gz + sync conflicts + cache).

---

## Runtime layout (`launcher/`)

```
552M  assets/         Mojang resources — textures, sounds. Lookup by hash. KEEP.
543M  java/
       198M  java21.tar.gz       ← extracted already, DELETE
       346M  jdk-21.0.9+10/      runtime, KEEP (or move outside launcher)
 99M  libraries/      MC + Fabric + Forge libs, on-demand cache. KEEP.
 88M  instances/      user world + modpack. SACRED.
 15M  bin/prismlauncher           main binary
 5.5M cache/          HTTP/asset cache, REGENERATES. delete-safe.
 692K translations/
       319K mmc_en_GB.qm                   keep
       316K mmc_en_GB.sync-conflict...qm   ← Syncthing leftover, DELETE
        26K index_v2.json                   keep
        26K index_v2.sync-conflict...json   ← DELETE
 196K images/         backgrounds (cat). Strip if no cat wanted.
  56K share/
  40K metacache/
  12K icons/
   0  themes/ iconthemes/ catpacks/        empty
```

### Immediate deletes (safe, ~200M):
```bash
cd launcher/
rm java/java21.tar.gz                                     # 198M
rm translations/*.sync-conflict-*                         # 316K + 26K
rm prismlauncher.sync-conflict-*.cfg metacache.sync-conflict-* 2>/dev/null
rm -rf cache/*                                            # 5.5M (regens)
```

### Optional moves:
- **Java outside launcher folder** — if portability not strictly USB-required, point `JavaPath` at a system Java 21 install. Saves 346M from the launcher tree. Already configured in `prismlauncher.cfg:JavaPath`.

---

## Source bloat (`source/`, ~13M)

Compile-time only. Trimming reduces binary size + build time.

### Icon themes — biggest source bloat (~5.5M)

`source/launcher/resources/` contains **17 icon theme dirs**:

| Theme | Size | Used? |
|---|---|---|
| `multimc/` | 3.0M | No (legacy) |
| `backgrounds/` | 1.4M | Cat backgrounds |
| `sources/` | 400K | SVG masters |
| `flat_white/` | 208K | **YES (default)** |
| `flat/` | 208K | No |
| `breeze_light/` `breeze_dark/` | 408K | No |
| `pe_light/dark/colored/blue/` | 752K | No |
| `iOS/` `OSX/` | 324K | No |
| `racked_ru/` | 12K | YES (custom) |
| `shaders/` `assets/` `documents/` | 36K | Various |

**Strippable:** all except `flat_white/`, `racked_ru/`, `sources/`, `assets/`, `shaders/`. Saves ~5M from binary qrc.

### Mod platforms (`source/launcher/modplatform/`, 564K)

| Platform | Size | Modern? |
|---|---|---|
| `flame/` (CurseForge) | 124K | Yes |
| `modrinth/` | 92K | Yes |
| `atlauncher/` | 80K | Niche |
| `technic/` | 52K | Dying |
| `legacy_ftb/` | 36K | Dead |
| `ftb/` | 32K | Use modrinth instead |
| `import_ftb/` | 24K | Pair w/ ftb |
| `packwiz/` | 20K | Niche |

**Recommended keep:** `flame/`, `modrinth/`, helpers, generic. **Strippable:** atlauncher + technic + legacy_ftb + ftb + import_ftb + packwiz = ~244K source, ~1-2M off binary after compile.

### News system

Already audited (`NETWORK_AUDIT.md`). News fetches RSS from prismlauncher.org on every startup. Strippable:
- `source/launcher/news/` — `NewsChecker.cpp/h`, `NewsEntry.cpp/h`
- `source/launcher/ui/dialogs/NewsDialog.{cpp,h,ui}`
- News toolbar button in `MainWindow.ui`
- `news.svg` icons across themes

Saves: ~30K source, removes 1 outbound network call on startup, removes "News" toolbar button.

### Other strip candidates

| Component | Source size | Worth stripping? |
|---|---|---|
| `tests/` | 928K | **Already excluded from runtime build** — leave for dev, or `rm -rf` if no tests run |
| `nix/` + `flake.*` | 28K | If not building via Nix, delete |
| `.github/` | 136K | Workflows for upstream CI, drop in fork |
| `program_info/` translations of metainfo | 888K | Bulk is icons (.icns/.ico/.png), required for OS integration |
| `libraries/` (vendored quazip, tomlplusplus, etc.) | 648K | Required, system libs an option but fragile |
| Setup wizard (`launcher/ui/setupwizard/`) | 68K | First-run only — keep |
| Screenshots gallery (`launcher/ui/screenshots`?) | 24K | Niche |

---

## Stripped binary

`bin/prismlauncher` 15M. Likely already release-built. Confirm:
```bash
file bin/prismlauncher        # should say "stripped"
strip --strip-all bin/prismlauncher 2>/dev/null   # idempotent
```
If unstripped, can drop several MB.

LTO + `-Os` at CMake configure: `-DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON` — typically 10–20% binary shrink.

---

## Reliability cost of each strip

| Strip | Reliability impact |
|---|---|
| Delete java tar.gz | Zero — already extracted |
| Delete sync-conflicts | Zero |
| Delete cache/ | Zero — regenerates on first launch |
| Drop unused icon themes | Zero — user can't pick them anyway |
| Drop FTB/Technic/ATLauncher modplatforms | Zero **if** user only uses CurseForge/Modrinth |
| Disable news | Zero — purely informational, also removes online startup hit |
| Move bundled Java to system Java | Low — if system Java 21 missing, breaks. Keep bundled for portability |
| Strip backgrounds | Zero — cat purely cosmetic |
| Drop multimc/ icon theme | Zero — legacy default replaced by flat_white |

None of the proposed strips touch MC launching, auth, asset download, mod loading, or world saves.

---

## Recommended action plan (ordered by ROI)

1. **Now (~200M, zero risk):** delete `java/java21.tar.gz`, sync-conflict files, `cache/*`
2. **Source trim, next rebuild:** drop 12 unused icon themes, FTB/Technic/ATLauncher modplatforms, news system
3. **Build flags:** `MinSizeRel` + LTO + `strip --strip-all`
4. **Optional:** move Java out of `launcher/` if portability not required

Estimated final size after all: **~700 MB** (down from 1.3 GB). Most remaining is non-strippable (Mojang assets, MC libs, user instance, Java).
