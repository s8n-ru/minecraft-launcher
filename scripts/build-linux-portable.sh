#!/bin/bash
# Build script for Linux portable version of Racked.ru PrismLauncher
# This creates a portable build that can be run from USB drives

set -e

# Configuration
BUILD_TYPE="Release"
BUILD_DIR="build-linux-portable"
INSTALL_DIR="install-linux-portable"
RELEASE_DIR="release/Racked.ru-PrismLauncher-Linux-Portable"

# Detect Qt6 path
if [ -d "/usr/lib/qt6" ]; then
    QT_PATH="/usr/lib/qt6"
elif [ -d "/usr/lib64/qt6" ]; then
    QT_PATH="/usr/lib64/qt6"
elif [ -d "/opt/qt6" ]; then
    QT_PATH="/opt/qt6"
else
    echo "Qt6 not found! Please install Qt6 development packages."
    exit 1
fi

# Clean previous builds
rm -rf "$BUILD_DIR" "$INSTALL_DIR" "$RELEASE_DIR"

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "========================================"
echo "Building Racked.ru PrismLauncher (Linux Portable)"
echo "========================================"

# Configure with CMake
cmake .. \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    -DCMAKE_INSTALL_PREFIX="../$INSTALL_DIR" \
    -DCMAKE_PREFIX_PATH="$QT_PATH" \
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
make -j$(nproc)

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

# Copy built files
cp -r "$INSTALL_DIR"/* "$RELEASE_DIR"/

# Copy portable.txt to enable portable mode
cp launcher/portable.txt "$RELEASE_DIR"/

# Create launcher script
cat > "$RELEASE_DIR/run.sh" <<'EOF'
#!/bin/bash
# Racked.ru PrismLauncher portable launcher
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LD_LIBRARY_PATH="$SCRIPT_DIR/lib:$LD_LIBRARY_PATH"
export QT_QPA_PLATFORM_PLUGIN_PATH="$SCRIPT_DIR/plugins"
exec "$SCRIPT_DIR/bin/prismlauncher" "$@"
EOF

chmod +x "$RELEASE_DIR/run.sh"

echo "========================================"
echo "Build complete!"
echo "Output: $RELEASE_DIR"
echo "========================================"
echo "To create a release archive:"
echo "  cd $RELEASE_DIR && tar czf ../racked-prismlauncher-linux-portable.tar.gz ."
echo "========================================"

exit 0
