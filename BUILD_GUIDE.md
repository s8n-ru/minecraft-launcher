# Racked.ru PrismLauncher - Build Guide

Minimal, custom-themed PrismLauncher build with racked.ru branding and portable mode support.

## Features

- **Minimal theme**: Black and red racked.ru theme
- **Portable mode**: USB-friendly, no installation required
- **Stripped resources**: Removed unused themes to reduce size
- **Cross-platform**: Windows, macOS, and Linux support
- **Custom background**: racked_ru catpack background

## Prerequisites

### Windows
- Visual Studio 2022 (Community Edition or higher)
- Qt 6.5.3 or later (MSVC 2019 64-bit)
- CMake 3.25 or later
- Git

Install Qt using the online installer:
```
1. Download Qt Online Installer from qt.io
2. Install Qt 6.5.3 -> MSVC 2019 64-bit
3. Make sure to include Qt Network Authentication and Qt SVG modules
```

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install build-essential cmake qt6-base-dev qt6-tools-dev \
    qt6-image-formats-plugins qt6-networkauth-dev zlib1g-dev libgl1-mesa-dev
```

### Linux (Fedora)
```bash
sudo dnf install gcc-c++ cmake qt6-qtbase-devel qt6-qttools-devel \
    qt6-qtimageformats qt6-qtnetworkauth-devel zlib-devel mesa-libGL-devel
```

### macOS
```bash
# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install cmake qt6
```

## Building

### Quick Build (Current Platform)

```bash
# Clone the repository
git clone <your-repo-url>
cd prismlauncher-racked

# Run the build script
bash scripts/build-all-platforms.sh
```

### Platform-Specific Builds

#### Windows (Run in Developer Command Prompt or PowerShell)
```batch
scripts\build-windows-portable.bat
```

#### Linux/macOS
```bash
chmod +x scripts/build-linux-portable.sh  # Linux only
chmod +x scripts/build-macos-portable.sh  # macOS only
bash scripts/build-linux-portable.sh      # Linux
bash scripts/build-macos-portable.sh      # macOS
```

## Output

Builds are placed in the `release/` directory:
- `release/Racked.ru-PrismLauncher-Windows-Portable/` - Windows portable
- `release/Racked.ru-PrismLauncher-Linux-Portable/` - Linux portable
- `release/Racked.ru-PrismLauncher-macOS-Portable/` - macOS portable

### Creating Distribution Archives

**Windows (PowerShell):**
```powershell
cd release\Racked.ru-PrismLauncher-Windows-Portable
Compress-Archive -Path * -DestinationPath ..\racked-prismlauncher-windows-portable.zip
```

**Linux:**
```bash
cd release/Racked.ru-PrismLauncher-Linux-Portable
tar czf ../racked-prismlauncher-linux-portable.tar.gz .
```

**macOS:**
```bash
cd release/Racked.ru-PrismLauncher-macOS-Portable
tar czf ../racked-prismlauncher-macos-portable.tar.gz PrismLauncher.app run.sh
```

## Portable Mode

The launcher includes `portable.txt` which enables portable mode. This makes the launcher store all data (instances, settings, etc.) in the same directory as the executable, making it perfect for USB drives.

To disable portable mode, simply delete `portable.txt` from the installation directory.

## Custom Theme

The launcher uses a custom `racked.ru` theme with:
- Black background (#000000)
- White text (#ffffff)
- Red accents (#ff0000, #CD001F)
- Minimal UI elements
- Custom catpack background (racked_ru.png)

## Stripped Components

To minimize size, the following have been removed:
- All default icon themes (except flat_white)
- All default application themes (except Fusion/system defaults)
- Unnecessary Qt plugins

## Troubleshooting

### Windows: "Qt6Core.dll not found"
Ensure Qt6 bin directory is in your PATH or copy all required Qt DLLs to the output directory (the build script does this automatically).

### Linux: "Qt6 not found"
Install Qt6 development packages via your package manager. Ensure `qmake6` or `qt6-cmake` is in your PATH.

### macOS: "App cannot be opened because the developer cannot be verified"
Right-click the app, select "Open", then click "Open" again in the security dialog. Or codesign the app:
```bash
codesign --deep --force --sign "-" release/Racked.ru-PrismLauncher-macOS-Portable/PrismLauncher.app
```

### Build fails with "CMake error"
Ensure CMake version is 3.25 or higher:
```bash
cmake --version
```

## License

This project is based on PrismLauncher and follows the same licensing terms (GPL-3.0-only).

## Credits

- **Original Project**: PrismLauncher
- **Upstream fork**: Diegiwg
- **Custom Theme**: racked.ru
- **Build System**: Custom portable build scripts
