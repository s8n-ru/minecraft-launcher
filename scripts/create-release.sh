#!/bin/bash
# Release creation script for Racked.ru PrismLauncher
# Creates versioned releases for all platforms

set -e

# Check if version is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 1.0.0"
    echo ""
    echo "Version format should be: MAJOR.MINOR.PATCH"
    exit 1
fi

VERSION="$1"
DATE=$(date +%Y%m%d)
BUILD_DIR="release"

echo "=============================================="
echo "Creating Racked.ru PrismLauncher Release v$VERSION"
echo "Date: $DATE"
echo "=============================================="
echo ""

# Verify we're in the right directory
if [ ! -f "launcher/CMakeLists.txt" ]; then
    echo "Error: Please run this script from the project root"
    exit 1
fi

# Check if release directory exists
if [ ! -d "$BUILD_DIR" ]; then
    echo "Error: No release directory found. Please build first using:"
    echo "  bash scripts/build-all-platforms.sh"
    exit 1
fi

# Create archives for each platform
echo "Creating release archives..."

# Windows
if [ -d "$BUILD_DIR/Racked.ru-PrismLauncher-Windows-Portable" ]; then
    cd "$BUILD_DIR/Racked.ru-PrismLauncher-Windows-Portable"
    if command -v zip &> /dev/null; then
        zip -r "../racked-prismlauncher-${VERSION}-windows-portable.zip" .
    else
        # Fallback to tar if zip not available
        tar czf "../racked-prismlauncher-${VERSION}-windows-portable.tar.gz" .
    fi
    cd ../..
    echo "  ✓ Windows package created"
fi

# Linux
if [ -d "$BUILD_DIR/Racked.ru-PrismLauncher-Linux-Portable" ]; then
    cd "$BUILD_DIR/Racked.ru-PrismLauncher-Linux-Portable"
    tar czf "../racked-prismlauncher-${VERSION}-linux-portable.tar.gz" .
    cd ../..
    echo "  ✓ Linux package created"
fi

# macOS
if [ -d "$BUILD_DIR/Racked.ru-PrismLauncher-macOS-Portable" ]; then
    cd "$BUILD_DIR/Racked.ru-PrismLauncher-macOS-Portable"
    tar czf "../racked-prismlauncher-${VERSION}-macos-portable.tar.gz" PrismLauncher.app run.sh
    cd ../..
    echo "  ✓ macOS package created"
fi

echo ""
echo "=============================================="
echo "Release packages created in $BUILD_DIR/:"
echo "=============================================="
ls -lh "$BUILD_DIR"/*.tar.gz "$BUILD_DIR"/*.zip 2>/dev/null || echo "No archives found"
echo ""
echo "Next steps:"
echo "1. Test the packages on each platform"
echo "2. Create a GitHub release: https://github.com/YOUR_USERNAME/racked-prismlauncher/releases/new"
echo "3. Tag: v$VERSION"
echo "4. Upload the archives"
echo "5. Update CHANGELOG.md"
echo "=============================================="

# Create a simple changelog entry
cat > "release-notes-v${VERSION}.md" <<EOF
# Racked.ru PrismLauncher v$VERSION

Released: $(date +%Y-%m-%d)

## Changes
- Based on upstream PrismLauncher fork
- Custom racked.ru theme (black/red minimalist design)
- Portable mode enabled (USB-friendly)
- Stripped unused themes and resources
- Optimized for minimal footprint

## Downloads
- Windows: racked-prismlauncher-${VERSION}-windows-portable.zip
- Linux: racked-prismlauncher-${VERSION}-linux-portable.tar.gz
- macOS: racked-prismlauncher-${VERSION}-macos-portable.tar.gz

## Installation
1. Download the archive for your platform
2. Extract to any folder (works from USB drives!)
3. Run prismlauncher.exe (Windows) or run.sh (Linux/macOS)
4. No installation required

## Notes
- All data is stored in the launcher directory (portable mode)
- Delete portable.txt to use system directories instead
- Theme: racked.ru (custom black/red theme)
- Background: racked_ru catpack
EOF

echo ""
echo "Created release notes: release-notes-v${VERSION}.md"
echo "=============================================="

exit 0
