# Settings Audit — runtime cfg vs source defaults

**Date:** 2026-04-30
**Source:** `source/launcher/Application.cpp` (registerSetting block lines ~644–900)
**Runtime:** `launcher/prismlauncher.cfg`

## Diffs found

| Setting | Source default | Runtime value | Action |
|---|---|---|---|
| `MinMemAlloc` | `512` | `384` | **Ported** → source now defaults `384` |
| `MaxMemAlloc` | `SysInfo::defaultMaxJvmMem()` (system-detected, often 8G+) | `4096` | **Ported** → source now defaults `4096` |
| `MenuBarInsteadOfToolBar` | `false` | `true` | **Ported** → source now defaults `true` |
| `FallbackMRBlockedMods` | `true` (bool) | `2` (Qt::CheckState::Checked) | **Not changed** — already truthy. Stored as enum because UI uses tri-state checkbox; behaviorally identical |
| `ApplicationTheme` | `"racked.ru"` | `"system"` | Runtime override only. Default already correct |
| `BackgroundCat` | `"racked_ru"` | (not set in cfg, irrelevant) | Default correct |
| `IconTheme` | `"flat_white"` | `"flat_white"` | Match |
| `AutomaticJavaDownload` | dynamic (`JavaPath` empty) | `false` | User-toggled, leave dynamic |
| `AutomaticJavaSwitch` | dynamic | `true` | Same |
| `NumberOfConcurrentTasks` | `10` | `10` | Match |
| `NumberOfConcurrentDownloads` | `6` | `6` | Match |

## Files changed

- `source/launcher/Application.cpp` — three default values updated (Min/MaxMemAlloc, MenuBarInsteadOfToolBar)

## Notes

- `JavaPath`, `LastHostname`, geometry blobs, `SelectedInstance`, `Language` are user/host-specific. Not ported.
- `OnlineFixes=false`, `EnableFeralGamemode=false`, `EnableMangoHud=false`, `UseDiscreteGpu=false`, `UseZink=false` — match defaults.
