#!/bin/bash
# Master build script for Racked.ru PrismLauncher - All Platforms
# This script orchestrates the build process for Windows, macOS, and Linux

set -e

echo "=============================================="
echo "Racked.ru PrismLauncher - Multi-Platform Build"
echo "=============================================="
echo ""

# Detect OS
case "$(uname -s)" in
    Linux*)     PLATFORM="linux";;
    Darwin*)    PLATFORM="macos";;
    CYGWIN*|MINGW*|MSYS*|Windows_NT*) PLATFORM="windows";;
    *)          echo "Unsupported platform!"; exit 1;;
esac

echo "Detected platform: $PLATFORM"
echo ""

# Build based on platform
case "$PLATFORM" in
    linux)
        echo "Building for Linux..."
        bash scripts/build-linux-portable.sh
        ;;
    macos)
        echo "Building for macOS..."
        bash scripts/build-macos-portable.sh
        ;;
    windows)
        echo "Building for Windows..."
        scripts/build-windows-portable.bat
        ;;
esac

if [ $? -ne 0 ]; then
    echo ""
    echo "Build failed!"
    exit 1
fi

echo ""
echo "=============================================="
echo "All builds completed successfully!"
echo "Check the release/ directory for output"
echo "=============================================="

exit 0
