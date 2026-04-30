<div align="center">

# minecraft-launcher

**Privacy-first Minecraft launcher.**
No telemetry. No Microsoft account requirement. Runs smooth on hardware that stock Minecraft chokes on.

[![Linux](https://img.shields.io/badge/Linux-x64-black?style=flat-square&logo=linux&logoColor=white)](https://github.com/s8n-ru/minecraft-launcher/releases/latest)
[![Windows](https://img.shields.io/badge/Windows-x64-black?style=flat-square&logo=windows&logoColor=white)](https://github.com/s8n-ru/minecraft-launcher/releases/latest)
[![macOS](https://img.shields.io/badge/macOS-arm64-black?style=flat-square&logo=apple&logoColor=white)](https://github.com/s8n-ru/minecraft-launcher/releases/latest)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL_3.0-black?style=flat-square)](LICENSE)

[**Download**](https://github.com/s8n-ru/minecraft-launcher/releases/latest) · [Changelog](CHANGELOG.md) · [Audits](docs/)

<img alt="racked.ru launcher" src="docs/screenshots/launcher.png" width="55%">

</div>

---

## Why this fork exists

Stock Minecraft phones home. Stock launcher pushes Microsoft accounts. Stock client struggles on low-end machines.

This fork fixes all three.

| | Stock launcher | This fork |
|---|---|---|
| Telemetry | Yes | None |
| Microsoft account | Required | Optional, never enforced |
| News fetch on launch | Yes | Hidden, no startup call |
| Plays on weak hardware | Often won't | Yes |
| Window title | Mojang branding | `racked.ru launcher` |

Full diff: [CHANGELOG.md](CHANGELOG.md).

---

## Features

### Privacy

- **No telemetry, anywhere.** Audited every endpoint — see [docs/NETWORK_AUDIT.md](docs/NETWORK_AUDIT.md)
- **No accounts required.** Pick a username, play offline. Sign in later if you want
- **No analytics, no tracking.** Doesn't matter who you are

### Performance

- Tuned for low-end hardware
- Bundled Java 21 (no system install)
- Portable — all data in one folder, USB-friendly

### Functionality

- Modrinth, CurseForge, FTB, ATLauncher, Technic platforms
- Custom monochrome theme
- Hide news feed by default — no startup network call

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

Pick a username on first launch. Done.

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

CI builds via [GitHub Actions](.github/workflows/build.yml) for all 3 platforms on every tag.

---

## Trust

This is open-source. Verify the privacy claims yourself:

- [docs/NETWORK_AUDIT.md](docs/NETWORK_AUDIT.md) — every network endpoint listed, telemetry verdict
- [docs/SETTINGS_AUDIT.md](docs/SETTINGS_AUDIT.md) — default-value diffs vs upstream
- [docs/BLOAT_AUDIT.md](docs/BLOAT_AUDIT.md) — what was stripped, why

You don't have to trust me. Read the source.

---

## Status

Personal project. No support guarantees. Bugs may bite. Use at own risk.

Pull requests welcome but not promised to merge.

---

## License

GPL-3.0-only. Per-file copyright headers preserved.

Based on [PrismLauncher](https://github.com/PrismLauncher/PrismLauncher) (GPL-3.0), itself a fork of [PolyMC](https://github.com/PolyMC/PolyMC) and [MultiMC](https://github.com/MultiMC/Launcher).
