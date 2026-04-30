#!/bin/bash
# Install dependencies for building Racked.ru PrismLauncher on Fedora

echo "=============================================="
echo "Installing Build Dependencies"
echo "=============================================="
echo ""
echo "This will install the required packages to build the launcher."
echo "You will need to enter your sudo password."
echo ""

read -p "Continue? [y/N] " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 1
fi

sudo dnf install -y \
    cmake \
    gcc-c++ \
    make \
    extra-cmake-modules \
    qt6-qtbase-devel \
    qt6-qttools-devel \
    qt6-qtsvg-devel \
    qt6-qtnetworkauth-devel \
    qt6-qtimageformats \
    zlib-devel \
    mesa-libGL-devel \
    cmark-devel \
    gamemode-devel \
    git \
    pkgconfig

echo ""
echo "=============================================="
echo "Verifying Installation"
echo "=============================================="
echo ""

if command -v cmake &> /dev/null; then
    echo "✓ CMake installed: $(cmake --version | head -n1)"
else
    echo "✗ CMake installation failed"
    exit 1
fi

if command -v qmake6 &> /dev/null; then
    echo "✓ Qt6 installed: $(qmake6 -query QT_VERSION)"
else
    echo "✗ Qt6 installation failed"
    exit 1
fi

echo ""
echo "=============================================="
echo "All dependencies installed successfully!"
echo "=============================================="
echo ""
echo "You can now build the launcher by running:"
echo "  bash scripts/build-linux-portable.sh"
echo ""
