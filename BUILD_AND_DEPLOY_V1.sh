#!/bin/bash
# Build and deploy portable Linux launcher as linux-racked-launcher-build-v1

set -e

echo "=============================================="
echo "Building Racked.ru PrismLauncher for Linux"
echo "=============================================="
echo ""

# Navigate to build directory
cd /home/admin/ai-lab/_project_minecraft/prismlauncher-racked

# Check if cmake is installed
if ! command -v cmake &> /dev/null; then
    echo "❌ CMake is not installed!"
    echo ""
    echo "Please run this first:"
    echo "  bash INSTALL_DEPS.sh"
    echo ""
    echo "Or install manually:"
    echo "  sudo dnf install cmake gcc-c++ make qt6-qtbase-devel"
    echo ""
    exit 1
fi

# Check if Qt6 is installed
if ! command -v qmake6 &> /dev/null; then
    echo "❌ Qt6 is not installed!"
    echo ""
    echo "Please run this first:"
    echo "  bash INSTALL_DEPS.sh"
    echo ""
    exit 1
fi

echo "✅ Dependencies found"
echo ""

# Clean old builds
echo "Cleaning old builds..."
rm -rf build-linux-portable install-linux-portable

# Build
echo "Building launcher..."
bash scripts/build-linux-portable.sh

echo ""
echo "=============================================="
echo "Creating Portable Installation"
echo "=============================================="
echo ""

# Create the v1 folder
V1_DIR="../linux-racked-launcher-build-v1"
rm -rf "$V1_DIR"
mkdir -p "$V1_DIR"

# Copy built files
echo "Copying files to $V1_DIR..."
cp -r release/Racked.ru-PrismLauncher-Linux-Portable/* "$V1_DIR"/

# Create a simple launcher script
cat > "$V1_DIR/start.sh" <<'EOF'
#!/bin/bash
# Racked.ru PrismLauncher - Portable Linux Launcher
# Version 1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Starting Racked.ru PrismLauncher..."
echo ""

# Set environment
export LD_LIBRARY_PATH="$SCRIPT_DIR/lib64:$SCRIPT_DIR/lib:$LD_LIBRARY_PATH"
export QT_QPA_PLATFORM_PLUGIN_PATH="$SCRIPT_DIR/plugins"
export QT_PLUGIN_PATH="$SCRIPT_DIR/plugins"

# Run launcher
exec "$SCRIPT_DIR/bin/prismlauncher" "$@"
EOF

chmod +x "$V1_DIR/start.sh"

# Create a README
cat > "$V1_DIR/README.txt" <<'EOF'
==============================================
Racked.ru PrismLauncher - Linux Portable
Version 1
==============================================

This is a portable Minecraft launcher with custom
racked.ru theme (black/red minimalist design).

HOW TO RUN:
-----------
1. Open terminal in this folder
2. Run: bash start.sh
   OR
   Run: chmod +x start.sh && ./start.sh

FEATURES:
---------
- Portable: All data stored in this folder
- Custom racked.ru theme (black/red)
- USB-friendly: Works from any location
- No installation required

CONFIGURATION:
--------------
Edit prismlauncher.cfg to change settings

YOUR DATA:
----------
- Minecraft instances: instances/
- Settings: prismlauncher.cfg
- Cache: cache/

All data travels with this folder!

SUPPORT:
--------
Website: https://racked.ru/
==============================================
EOF

echo ""
echo "=============================================="
echo "✅ Build Complete!"
echo "=============================================="
echo ""
echo "Your launcher is ready at:"
echo "  /home/admin/ai-lab/_project_minecraft/linux-racked-launcher-build-v1/"
echo ""
echo "To run it:"
echo "  cd /home/admin/ai-lab/_project_minecraft/linux-racked-launcher-build-v1/"
echo "  bash start.sh"
echo ""
echo "=============================================="

exit 0
