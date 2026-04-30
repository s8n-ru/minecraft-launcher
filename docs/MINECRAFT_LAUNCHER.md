# Minecraft Launcher Project - Complete Documentation

**Location:** `/home/admin/ai-lab/_projects/_minecraft/`

**Last Updated:** 2026-04-13

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Current Setup](#current-setup)
3. [Build System](#build-system)
4. [Custom Theme](#custom-theme)
5. [Development History](#development-history)
6. [File Structure](#file-structure)
7. [Configuration](#configuration)
8. [Deployment](#deployment)
9. [Troubleshooting](#troubleshooting)
10. [Future Work](#future-work)

---

## Project Overview

This project contains a **custom-branded PrismLauncher** for Minecraft, themed as "racked.ru" with a minimalist black and red design. The launcher is built from PrismLauncher-Cracked and customized for portable operation (USB-friendly, no installation required).

### Key Features
- **Minimalist Design**: Black background with red accents
- **Portable Mode**: All data stored locally, perfect for USB drives
- **Cross-Platform**: Builds available for Windows, Linux, and macOS
- **Stripped Resources**: Removed unused themes to minimize size
- **Custom Branding**: racked.ru theme and catpack background

---

## Current Setup

### Launcher Location
```
/home/admin/ai-lab/_projects/_minecraft/racked.ru - minecraft/
```

### Current Launcher Contents (as of 2026-04-13)
- `prismlauncher.exe` - Main launcher executable (Windows)
- `prismlauncher.cfg` - Configuration file with custom theme settings
- `portable.txt` - Enables portable mode
- `Qt6*.dll` - Qt framework libraries
- `platforms/` - Qt platform plugins
- `iconengines/` - Icon rendering plugins
- `imageformats/` - Image format support
- `themes/racked.ru/` - Custom theme files
- `catpacks/racked_ru.png` - Background cat image
- `instances/racked.ru/` - Minecraft instance with mods

### Configuration (prismlauncher.cfg)
```ini
[General]
ConfigVersion=1.2
ApplicationTheme=racked.ru
IconTheme=flat_white
BackgroundCat=racked_ru
Language=en_US
MenuBarInsteadOfToolBar=true
StatusBarVisible=false
TheCat=true
```

---

## Build System

### Build Repository
The build system and source code are maintained in:
```
/home/admin/ai-lab/_projects/_minecraft/source/
```

### Build Scripts Available

#### Linux Scripts
| Script | Purpose |
|--------|---------|
| `setup-and-build.sh` | One-command setup and build |
| `scripts/build-linux-portable.sh` | Build for Linux |
| `scripts/deploy-to-minecraft-folder.sh` | Build and deploy automatically |
| `scripts/build-windows-from-linux.sh` | Cross-compile for Windows |
| `scripts/build-all-platforms-linux.sh` | Multi-platform build |
| `scripts/create-release.sh` | Create versioned release packages |

#### Windows Scripts (Legacy)
| Script | Purpose |
|--------|---------|
| `scripts/build-windows-portable.bat` | Build for Windows |
| `scripts/deploy-to-minecraft-folder.bat` | Deploy to Windows folder |

### Build Process (Linux)

**Quick Build:**
```bash
cd /home/admin/ai-lab/_projects/_minecraft/source
bash setup-and-build.sh
```

This:
1. Installs dependencies (Fedora packages)
2. Builds the launcher
3. Creates portable release in `release/`

**Deploy Build:**
```bash
bash scripts/deploy-to-minecraft-folder.sh
```

This:
1. Builds the launcher
2. Backs up current installation
3. Deploys new version to `racked.ru - minecraft/`

### Build Dependencies (Fedora)
```bash
sudo dnf install -y \
    cmake gcc-c++ make \
    qt6-qtbase-devel qt6-qttools-devel qt6-qtsvg-devel \
    qt6-qtnetworkauth-devel qt6-qtimageformats \
    zlib-devel mesa-libGL-devel
```

---

## Custom Theme

### Theme Location
```
source/launcher/resources/racked_ru/
```

### Theme Files

#### theme.json
```json
{
    "colors": {
        "AlternateBase": "#000000",
        "Base": "#000000",
        "BrightText": "#ff0000",
        "Button": "#000000",
        "ButtonText": "#ffffff",
        "Highlight": "#4C4C4C",
        "HighlightedText": "#CCCCCC",
        "Link": "#CD001F",
        "Text": "#ffffff",
        "ToolTipBase": "#ffffff",
        "ToolTipText": "#ffffff",
        "Window": "#000000",
        "WindowText": "#ffffff",
        "fadeAmount": 0.5,
        "fadeColor": "#000000"
    },
    "name": "racked.ru",
    "widgets": "Fusion"
}
```

#### themeStyle.css
```css
QToolTip { color: #ffffff; background-color: #2a82da; border: 1px solid white; }
```

### Background
- File: `catpacks/racked_ru.png`
- Custom cat image displayed in launcher background
- Configured via `BackgroundCat=racked_ru` in config

### Theme Changes Made
1. Removed all default themes (pe_dark, pe_light, pe_blue, etc.)
2. Kept only flat_white icon theme for minimalism
3. Added custom racked.ru theme with black/red colors
4. Set racked.ru as default application theme
5. Set flat_white as default icon theme

---

## Development History

### Timeline

#### 2026-04-13 - Project Creation
- Cloned upstream PrismLauncher-Cracked repository
- Created custom racked.ru theme integration
- Stripped unused themes and resources
- Implemented cross-platform build system for Linux
- Created automated deployment scripts
- Configured portable mode support

#### Changes Made
1. **Theme Integration**
   - Added racked.ru theme with custom colors
   - Set as default theme in Application.cpp
   - Updated main.cpp to load only required resources
   - Modified ThemeManager to remove unused themes

2. **Resource Optimization**
   - Removed 10+ unused icon themes
   - Removed unused application themes
   - Reduced build size significantly
   - Kept only flat_white and racked.ru themes

3. **Portable Mode**
   - Added portable.txt to launcher root
   - Configured builds to be USB-friendly
   - All data stored locally in launcher directory

4. **Build System**
   - Created Linux-first build scripts
   - Added cross-compilation support for Windows
   - Automated deployment to minecraft folder
   - Created release packaging scripts

### Upstream Base
- **Project**: PrismLauncher-Cracked
- **Repository**: https://github.com/Diegiwg/PrismLauncher-Cracked
- **License**: GPL-3.0-only
- **Qt Version**: 6.5.3+

---

## File Structure

### Current Launcher (Production)
```
racked.ru - minecraft/
├── prismlauncher.exe           # Main executable
├── prismlauncher.cfg           # Configuration
├── portable.txt                # Enables portable mode
├── Qt6Core.dll                 # Qt libraries
├── Qt6Gui.dll
├── Qt6Widgets.dll
├── Qt6Network.dll
├── ... (other Qt DLLs)
├── platforms/                  # Qt platform plugins
│   └── qwindows.dll
├── iconengines/               # Icon rendering
├── imageformats/              # Image support
├── themes/
│   └── racked.ru/
│       ├── theme.json
│       └── themeStyle.css
├── catpacks/
│   └── racked_ru.png
├── instances/
│   └── racked.ru/            # Minecraft instance
│       └── minecraft/
│           └── config/       # Mod configurations
├── cache/                     # Download cache
├── meta/                      # Metadata
├── translations/             # Language files
└── logs/                      # Log files
```

### Build System (Development)
```
source/
├── launcher/                  # Source code
│   ├── resources/
│   │   └── racked_ru/        # Custom theme
│   ├── Application.cpp       # Modified defaults
│   └── main.cpp              # Resource loading
├── scripts/
│   ├── setup-and-build.sh
│   ├── build-linux-portable.sh
│   ├── deploy-to-minecraft-folder.sh
│   ├── build-windows-from-linux.sh
│   ├── build-all-platforms-linux.sh
│   └── create-release.sh
├── README_LINUX.md
├── LINUX_SETUP.md
├── LINUX_QUICKSTART.md
├── BUILD_GUIDE.md
├── PROJECT_SUMMARY.md
└── RELEASE_CHECKLIST.md
```

---

## Configuration

### Default Settings
These are the default settings configured in the build:

```ini
ApplicationTheme=racked.ru      # Custom black/red theme
IconTheme=flat_white            # Minimal white icons
BackgroundCat=racked_ru         # Custom background image
MenuBarInsteadOfToolBar=true    # Menu bar layout
StatusBarVisible=false          # Minimal UI
TheCat=true                     # Enable background cat
```

### User Configuration
User-specific settings are stored in `prismlauncher.cfg` in the launcher directory (portable mode) or in system config directory (if portable.txt is removed).

### Java Configuration
The launcher auto-detects Java installations. Current settings:
```ini
AutomaticJavaDownload=true
AutomaticJavaSwitch=true
JavaVersion=21.0.7
JavaArchitecture=64
```

---

## Deployment

### Deploy to Current Location

**Linux (Recommended):**
```bash
cd /home/admin/ai-lab/_projects/_minecraft/source
bash scripts/deploy-to-minecraft-folder.sh
```

**Manual Deployment:**
```bash
# Build first
bash scripts/build-linux-portable.sh

# Backup current launcher
mv "racked.ru - minecraft" "racked.ru - minecraft-backup-$(date +%Y%m%d)"

# Copy new build
cp -r release/Racked.ru-PrismLauncher-Linux-Portable/* "racked.ru - minecraft/"
```

### Deployment Locations

**Current Production:**
```
/home/admin/ai-lab/_projects/_minecraft/racked.ru - minecraft/
```

**Backup Location (after deploy):**
```
/home/admin/ai-lab/_projects/_minecraft/racked.ru - minecraft-backup-YYYYMMDD/
```

### Release Packages

Release packages are created in:
```
source/release/
├── racked-prismlauncher-<version>-linux-portable.tar.gz
├── racked-prismlauncher-<version>-windows-portable.zip
└── racked-prismlauncher-<version>-macos-portable.tar.gz
```

To create a release:
```bash
bash scripts/create-release.sh 1.0.0
```

---

## Troubleshooting

### Java Requirements for Minecraft 1.21.10

**Minecraft 1.21.10 requires Java 21.** Your system has Java 25 which is too new.

**Solution:** Install Java 21 locally (no root needed)
- See `ADD_JAVA_GUIDE.md` for complete instructions
- Quick fix: Download from https://github.com/adoptium/temurin21-binaries
- Place Java in: `launcher/java/`
- Configure launcher to use: `java/jdk-21.0.5+11/bin/java`

**Quick Install Script:**
```bash
cd launcher/
mkdir -p java && cd java
wget https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz
tar xzf OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz
```

### Common Issues

#### Launcher Won't Start
**Linux:**
```bash
# Check missing dependencies
ldd release/Racked.ru-PrismLauncher-Linux-Portable/bin/prismlauncher

# Install Qt6 if missing
sudo dnf install qt6-qtbase
```

**Windows:**
```bash
# Ensure all DLLs are present
# Rebuild with: scripts\build-windows-portable.bat
```

#### Theme Not Loading
1. Check `prismlauncher.cfg` for correct theme settings
2. Verify theme files exist in `themes/racked.ru/`
3. Rebuild launcher if files are missing

#### Portable Mode Not Working
1. Ensure `portable.txt` exists in launcher root
2. Check file permissions (must be readable)
3. Delete and recreate if necessary

#### Build Fails on Linux
```bash
# Install dependencies
sudo dnf install cmake gcc-c++ make qt6-qtbase-devel

# Clean build
rm -rf build-linux-portable/ install-linux-portable/
bash scripts/build-linux-portable.sh
```

#### Cross-Compilation for Windows Fails
```bash
# Install MinGW
sudo dnf install mingw64-gcc-c++ mingw64-qt6-qtbase

# Verify
x86_64-w64-mingw32-g++ --version
```

### Backup and Recovery

**Backup Current Launcher:**
```bash
cp -r "racked.ru - minecraft" "racked.ru - minecraft-backup-$(date +%Y%m%d)"
```

**Restore from Backup:**
```bash
rm -rf "racked.ru - minecraft"
mv "racked.ru - minecraft-backup-YYYYMMDD" "racked.ru - minecraft"
```

**Preserve Data:**
Before any deployment, backup:
- `instances/` folder (your Minecraft instances)
- `prismlauncher.cfg` (your settings)
- Any custom mods or resource packs

---

## Future Work

### Planned Improvements

#### 1. Automatic Updates
- [ ] Implement update checker
- [ ] Create update script
- [ ] Add update notifications

#### 2. Custom Branding
- [ ] Custom launcher icon
- [ ] Custom splash screen
- [ ] Custom about dialog
- [ ] Branded installer (optional)

#### 3. Performance Optimization
- [ ] Further reduce binary size
- [ ] Optimize startup time
- [ ] Reduce memory footprint

#### 4. Distribution
- [ ] Upload to racked.ru website
- [ ] Create GitHub releases
- [ ] Set up auto-update server
- [ ] Package for Linux distros (Flatpak, AppImage)

#### 5. Documentation
- [ ] User guide
- [ ] Mod installation guide
- [ ] Server connection guide
- [ ] Video tutorial

### Known Limitations

1. **macOS Builds**: Cannot cross-compile from Linux easily
   - Solution: Build natively on macOS

2. **Windows Builds**: Require MinGW or native Windows
   - Currently supports cross-compilation from Linux

3. **Size**: Still includes full Qt6 framework
   - ~100-150MB minimum due to Qt dependencies

4. **Updates**: Manual update process
   - Must rebuild and redeploy for updates

### Wishlist

- [ ] Custom modpack manager
- [ ] Integrated server browser
- [ ] Custom news feed from racked.ru
- [ ] Integrated voice chat
- [ ] Performance monitoring
- [ ] Shader pack manager

---

## Additional Resources

### Documentation Files
- `README_LINUX.md` - Complete Linux build guide
- `LINUX_SETUP.md` - Detailed setup instructions
- `LINUX_QUICKSTART.md` - Quick reference
- `BUILD_GUIDE.md` - Cross-platform build guide
- `PROJECT_SUMMARY.md` - Technical overview
- `RELEASE_CHECKLIST.md` - Release verification

### External Resources
- **PrismLauncher**: https://prismlauncher.org/
- **PrismLauncher-Cracked**: https://github.com/Diegiwg/PrismLauncher-Cracked
- **Qt Framework**: https://www.qt.io/
- **racked.ru Website**: https://racked.ru/

### Support
- **Issues**: GitHub Issues in source
- **Discord**: (Add your Discord link)
- **Website**: https://racked.ru/

---

## Quick Reference

### Most Common Commands

**Build from scratch:**
```bash
cd /home/admin/ai-lab/_projects/_minecraft/source
bash setup-and-build.sh
```

**Deploy to minecraft folder:**
```bash
bash scripts/deploy-to-minecraft-folder.sh
```

**Create release:**
```bash
bash scripts/create-release.sh 1.0.0
```

**Run built launcher:**
```bash
cd release/Racked.ru-PrismLauncher-Linux-Portable/
./run.sh
```

### Important Locations

```
Project Root:     /home/admin/ai-lab/_projects/_minecraft/
Current Launcher: /home/admin/ai-lab/_projects/_minecraft/racked.ru - minecraft/
Build System:     /home/admin/ai-lab/_projects/_minecraft/source/
Upstream Reference: /home/admin/ai-lab/prismlauncher-cracked-upstream/
```

---

**Version**: 1.0.0 (Initial Release)  
**Build Date**: 2026-04-13  
**Maintained By**: racked.ru team  
**License**: GPL-3.0-only (based on PrismLauncher)
