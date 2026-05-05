<div align="center">

# minecraft-launcher

<br>

<a href="https://github.com/s8n-ru/minecraft-launcher/releases/latest">
  <img src="https://img.shields.io/badge/Download_latest-black?style=for-the-badge&logoColor=white&labelColor=black&color=white" height="60" alt="Download latest">
</a>

<br><br>

[![Linux](https://img.shields.io/badge/Linux-x64-black?style=flat-square&logo=linux&logoColor=white)](https://github.com/s8n-ru/minecraft-launcher/releases/latest)
[![Windows](https://img.shields.io/badge/Windows-x64-black?style=flat-square&logo=windows&logoColor=white)](https://github.com/s8n-ru/minecraft-launcher/releases/latest)
[![macOS](https://img.shields.io/badge/macOS-arm64-black?style=flat-square&logo=apple&logoColor=white)](https://github.com/s8n-ru/minecraft-launcher/releases/latest)

[Changelog](CHANGELOG.md) · [Audits](docs/)

<img alt="racked.ru launcher" src="docs/screenshots/launcher.png" width="55%">

</div>

---

an opinionated launcher  -  ***my based opinions***

built for myself, If your its to your taste, help yourself.

---

## What I changed vs upstream

| | Stock launcher | This fork |
|---|---|---|
| Telemetry | Yes | none |
| News fetch on launch | Yes | none |
| UI | Ugly | Clean |
| Weak hardware support | lmao | optimized |

Full diff in [CHANGELOG.md](CHANGELOG.md). Per-endpoint network audit
in [docs/NETWORK_AUDIT.md](docs/NETWORK_AUDIT.md).

---

## What it does

- Modrinth, CurseForge, FTB, ATLauncher, Technic instance imports
- Fetches Java, no system install needed (hassle)
- Portable: can launch from a usb stick for example
- Offline mode: pick a username, play.
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
