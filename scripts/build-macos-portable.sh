#!/bin/bash
# Build script for macOS portable version of Racked.ru PrismLauncher
# This creates a portable .app bundle that can be run from USB drives

set -e

# Configuration
BUILD_TYPE="Release"
BUILD_DIR="build-macos-portable"
INSTALL_DIR="install-macos-portable"
RELEASE_DIR="release/Racked.ru-PrismLauncher-macOS-Portable"

# Clean previous builds
rm -rf "$BUILD_DIR" "$INSTALL_DIR" "$RELEASE_DIR"

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "========================================"
echo "Building Racked.ru PrismLauncher (macOS Portable)"
echo "========================================"

# Configure with CMake
cmake .. \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    -DCMAKE_INSTALL_PREFIX="../$INSTALL_DIR" \
    -DLauncher_QT_VERSION_MAJOR=6 \
    -DENABLE_LTO=ON \
    -DUSE_SYSTEM_LIBS=OFF \
    -DENABLE_GLFW=OFF \
    -DENABLE_OPENAL=OFF

if [ $? -ne 0 ]; then
    echo "CMake configuration failed!"
    exit 1
fi

# Build
make -j$(sysctl -n hw.ncpu)

if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

# Install to staging directory
make install

if [ $? -ne 0 ]; then
    echo "Installation failed!"
    exit 1
fi

cd ..

# Create portable package
echo "Creating portable package..."
mkdir -p "$RELEASE_DIR"

# Copy the .app bundle
cp -r "$INSTALL_DIR/PrismLauncher.app" "$RELEASE_DIR/"

# Copy portable.txt inside the app bundle
cp launcher/portable.txt "$RELEASE_DIR/PrismLauncher.app/Contents/Resources/"

# Create a simple launcher script
cat > "$RELEASE_DIR/run.sh" <<'EOF'
#!/bin/bash
# Racked.ru PrismLauncher portable launcher
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
open "$SCRIPT_DIR/PrismLauncher.app"
EOF

chmod +x "$RELEASE_DIR/run.sh"

echo "========================================"
echo "Build complete!"
echo "Output: $RELEASE_DIR"
echo "========================================"
echo "To create a release archive:"
echo "  cd $RELEASE_DIR && tar czf ../racked-prismlauncher-macos-portable.tar.gz PrismLauncher.app run.sh"
echo "========================================"
echo ""
echo "Note: For distribution, you may want to codesign the app:"
echo "  codesign --deep --force --sign \"Your Certificate\" $RELEASE_DIR/PrismLauncher.app"
echo "========================================"

exit 0
