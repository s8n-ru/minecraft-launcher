# Racked.ru PrismLauncher - Project Summary

## What Was Done

Your custom PrismLauncher has been successfully merged with the upstream PrismLauncher fork and configured for minimal, portable builds across all platforms.

## Project Structure

```
prismlauncher-racked/
├── launcher/                      # Source code
│   ├── resources/
│   │   ├── racked_ru/            # Your custom theme
│   │   │   ├── theme.json        # Black/red color scheme
│   │   │   ├── themeStyle.css    # Qt stylesheet
│   │   │   └── racked_ru.qrc     # Qt resource file
│   │   └── backgrounds/
│   │       └── backgrounds.qrc   # Updated with racked_ru background
│   ├── Application.cpp           # Default theme set to racked.ru
│   └── main.cpp                  # Only loads required resources
├── scripts/
│   ├── build-windows-portable.bat    # Windows build script
│   ├── build-linux-portable.sh      # Linux build script
│   ├── build-macos-portable.sh      # macOS build script
│   ├── build-all-platforms.sh       # Master build script
│   └── create-release.sh            # Release automation
├── BUILD_GUIDE.md               # Comprehensive build instructions
├── README_RELEASE.md            # Quick start guide
└── .gitignore                   # Updated for this project
```

## Key Changes Made

### 1. Theme Integration
- Created `racked_ru` theme resource directory
- Added your custom theme.json with black/red color scheme
- Set racked.ru as default application theme
- Set flat_white as default icon theme
- Added racked_ru background cat image

### 2. Resource Stripping
Removed these themes from the build to reduce size:
- pe_dark, pe_light, pe_blue, pe_colored
- breeze_dark, breeze_light
- OSX, iOS
- flat (kept only flat_white)

### 3. Build Configuration
- Updated CMakeLists.txt to only include racked_ru and flat_white
- Updated main.cpp to only load required Qt resources
- Updated ThemeManager.h to remove unused icon themes from defaults
- Added portable.txt support for USB-friendly operation

### 4. Portable Mode
All builds are configured for portable operation:
- No installation required
- All data stored in launcher directory
- Perfect for USB drives
- No system registry or appdata usage

### 5. Cross-Platform Build Scripts
Created automated build scripts for:
- **Windows**: Batch script with MSVC support
- **Linux**: Bash script with Qt6 detection
- **macOS**: Bash script with .app bundle creation

## How to Build

### Prerequisites

**Windows:**
- Visual Studio 2022
- Qt 6.5.3+ (MSVC 2019 64-bit)
- CMake 3.25+

**Linux:**
```bash
# Ubuntu/Debian
sudo apt install build-essential cmake qt6-base-dev qt6-tools-dev qt6-networkauth-dev

# Fedora
sudo dnf install gcc-c++ cmake qt6-qtbase-devel qt6-qtnetworkauth-devel
```

**macOS:**
```bash
xcode-select --install
brew install cmake qt6
```

### Build Commands

Quick build (auto-detects platform):
```bash
cd prismlauncher-racked
bash scripts/build-all-platforms.sh
```

Platform-specific:
```bash
# Windows (in Developer Command Prompt)
scripts\build-windows-portable.bat

# Linux
bash scripts/build-linux-portable.sh

# macOS
bash scripts/build-macos-portable.sh
```

Create release:
```bash
bash scripts/create-release.sh 1.0.0
```

## Output Structure

After building, you'll have:
```
release/
├── Racked.ru-PrismLauncher-Windows-Portable/
│   ├── prismlauncher.exe
│   ├── portable.txt
│   ├── Qt6*.dll
│   ├── platforms/
│   ├── iconengines/
│   └── imageformats/
├── Racked.ru-PrismLauncher-Linux-Portable/
│   ├── bin/prismlauncher
│   ├── portable.txt
│   └── run.sh
└── Racked.ru-PrismLauncher-macOS-Portable/
    ├── PrismLauncher.app
    ├── portable.txt
    └── run.sh
```

## Distribution Packages

After running create-release.sh:
```
release/
├── racked-prismlauncher-1.0.0-windows-portable.zip
├── racked-prismlauncher-1.0.0-linux-portable.tar.gz
└── racked-prismlauncher-1.0.0-macos-portable.tar.gz
```

## Custom Theme Files

### theme.json
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
        "WindowText": "#ffffff"
    },
    "name": "racked.ru",
    "widgets": "Fusion"
}
```

### themeStyle.css
```css
QToolTip { color: #ffffff; background-color: #2a82da; border: 1px solid white; }
```

## Default Settings

The launcher is pre-configured with:
- Application Theme: racked.ru
- Icon Theme: flat_white
- Background: racked_ru
- Portable Mode: Enabled (via portable.txt)

## File Size Comparison

Your minimal build should be significantly smaller than a full PrismLauncher:
- **Before (full themes)**: ~150MB (Windows)
- **After (minimal)**: ~80-100MB (estimated, depending on Qt version)

## USB Portability Features

1. **No Installation**: Copy and run from any location
2. **Self-Contained**: All data stays in launcher folder
3. **Cross-Machine**: Works on any computer without setup
4. **Preserved Settings**: Your theme and instances travel with you

## Next Steps

1. **Build** the launcher using the provided scripts
2. **Test** on each platform you support
3. **Customize** the theme further if desired (edit theme.json)
4. **Distribute** via https://racked.ru/
5. **Update** periodically by merging upstream changes

## Updating from Upstream

To get new features from upstream:
```bash
cd prismlauncher-racked
git remote add upstream https://github.com/s8n-ru/minecraft-launcher.git
git fetch upstream
git merge upstream/main
# Resolve any conflicts, keeping your theme changes
```

## Troubleshooting

### Build fails on Linux with Qt6 errors
Install complete Qt6 development packages:
```bash
sudo apt install qt6-base-dev qt6-tools-dev qt6-svg-dev qt6-networkauth-dev
```

### Windows build missing DLLs
The build script automatically copies required Qt DLLs. If still missing, ensure Qt bin directory is in PATH.

### Theme not loading
Ensure `portable.txt` exists in the root directory, and check `prismlauncher.cfg` for:
```
ApplicationTheme=racked.ru
IconTheme=flat_white
BackgroundCat=racked_ru
```

### macOS "App is damaged"
Codesign the app:
```bash
codesign --deep --force --sign "-" release/Racked.ru-PrismLauncher-macOS-Portable/PrismLauncher.app
```

## Repository Structure

This project is organized as:
- **prismlauncher-racked/**: Modified upstream repository with your theme
- ** prismlauncher-upstream/**: Clean upstream copy (reference)
- **_project_minecraft/**: Your original launcher (backup)

## License

Based on PrismLauncher - licensed under GPL-3.0-only.
Your modifications maintain the same license.

## Credits

- **PrismLauncher Team**: Original launcher
- **Diegiwg**: Upstream fork base
- **racked.ru**: Custom theme and branding
- **Build System**: Custom portable cross-platform scripts

---

Project created: 2026-04-13
Based on: PrismLauncher upstream fork (latest commit as of date)
Build system: CMake 3.25+, Qt 6.5.3+
