<div align="center">

# minecraft-launcher

[![Linux](https://img.shields.io/badge/Linux-x64-black?style=flat-square&logo=linux&logoColor=white)](https://github.com/s8n-ru/minecraft-launcher/releases/latest)
[![Windows](https://img.shields.io/badge/Windows-x64-black?style=flat-square&logo=windows&logoColor=white)](https://github.com/s8n-ru/minecraft-launcher/releases/latest)
[![macOS](https://img.shields.io/badge/macOS-arm64-black?style=flat-square&logo=apple&logoColor=white)](https://github.com/s8n-ru/minecraft-launcher/releases/latest)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL_3.0-black?style=flat-square)](LICENSE)

[**Download**](https://github.com/s8n-ru/minecraft-launcher/releases/latest) · [Changelog](CHANGELOG.md) · [Audits](docs/)

<img alt="racked.ru launcher" src="docs/screenshots/launcher.png" width="55%">

</div>

---

I wanted a launcher that just played Minecraft. No telemetry, no
forced Microsoft account, no news feed phoning home before the window
even renders, no UI clutter from features I'd never touch.

Prism Launcher came closest. Still wasn't quite there. So this is a
fork: same core, with the bloat I didn't want stripped out and an
AMOLED theme because I like that.

Opinionated. Built for me. If your taste lines up, help yourself.

---

## What I changed vs upstream

| | Stock launcher | Prism | This fork |
|---|---|---|---|
| Telemetry | Yes | None | None |
| Microsoft account | Required | Optional | Optional, never nagged |
| News fetch on launch | Yes | Yes | Hidden, no startup call |
| Theme | Mojang | Default | Pure AMOLED, monochrome |
| Branding | Mojang | Prism | `racked.ru launcher` |
| Plays on weak hardware | Often won't | Yes | Yes (Java 21 bundled) |

Full diff in [CHANGELOG.md](CHANGELOG.md). Per-endpoint network audit
in [docs/NETWORK_AUDIT.md](docs/NETWORK_AUDIT.md).

---

## What it does

- Modrinth, CurseForge, FTB, ATLauncher, Technic instance imports
- Bundled Java 21, no system install needed
- Portable: one folder, USB-friendly
- Offline mode: pick a username, play. Microsoft sign-in only if you
  actually need premium features
- Pure black/white theme, no chrome accents

That's it. Same scope as Prism, just narrower defaults.

---

## Download

Pre-built binaries for Linux, Windows, macOS:

→ [**Latest release**](https://github.com/s8n-ru/minecraft-launcher/releases/latest)

Linux:
```bash
tar xzf minecraft-launcher-linux-x64.tar.gz
cd minecraft-launcher
./bin/prismlauncher
```

Windows:
```
unzip minecraft-launcher-windows-x64.zip
cd minecraft-launcher
prismlauncher.exe
```

macOS (unsigned — right-click → Open → Open anyway):
```bash
unzip minecraft-launcher-macos-arm64.zip
cd minecraft-launcher
./prismlauncher.app/Contents/MacOS/prismlauncher
```

First launch: pick a username, done.

---

## Build from source

```bash
git clone https://github.com/s8n-ru/minecraft-launcher.git
cd minecraft-launcher

# Fedora 43
sudo dnf install cmake gcc-c++ ninja-build extra-cmake-modules \
    qt6-qtbase-devel qt6-qttools-devel qt6-qtsvg-devel qt6-qtnetworkauth-devel \
    libarchive-devel cmark-devel qrencode-devel tomlplusplus

# Ubuntu / Debian
sudo apt install cmake g++ ninja-build extra-cmake-modules \
    qt6-base-dev qt6-tools-dev qt6-svg-dev libqt6networkauth6-dev \
    libarchive-dev libcmark-dev libqrencode-dev libtomlplusplus-dev gamemode-dev libvulkan-dev

JAVA_HOME=/path/to/jdk-21 cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build -j$(nproc)
./build/prismlauncher
```

CI builds via [GitHub Actions](.github/workflows/build.yml) for all 3
platforms on every tag.

---

## Trust

Don't take my word on the privacy stuff. Read the audits:

- [docs/NETWORK_AUDIT.md](docs/NETWORK_AUDIT.md) — every endpoint
  listed, telemetry verdict per call
- [docs/SETTINGS_AUDIT.md](docs/SETTINGS_AUDIT.md) — default-value
  diffs vs upstream
- [docs/BLOAT_AUDIT.md](docs/BLOAT_AUDIT.md) — what got stripped, why

It's GPL-3.0. Source is right there.

---

## Status

Personal project. I use it daily, that's the only QA. No support
guarantees. Bugs happen. Use at your own risk.

PRs welcome but not promised to merge — this is opinionated by
design.

---

## License

GPL-3.0-only. Per-file copyright headers preserved.

Based on [PrismLauncher](https://github.com/PrismLauncher/PrismLauncher)
(GPL-3.0), itself a fork of [PolyMC](https://github.com/PolyMC/PolyMC)
and [MultiMC](https://github.com/MultiMC/Launcher).
