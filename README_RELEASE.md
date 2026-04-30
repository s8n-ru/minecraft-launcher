# Racked.ru PrismLauncher - Quick Start

## For Users (Download & Run)

### Windows
1. Download `racked-prismlauncher-*-windows-portable.zip`
2. Extract to any folder (even USB drive)
3. Run `prismlauncher.exe`
4. Enjoy your minimal black/red themed launcher!

### Linux
```bash
# Download
tar xzf racked-prismlauncher-*-linux-portable.tar.gz
cd Racked.ru-PrismLauncher-Linux-Portable
./run.sh
```

### macOS
```bash
# Download
tar xzf racked-prismlauncher-*-macos-portable.tar.gz
cd Racked.ru-PrismLauncher-macOS-Portable
./run.sh
```

## For Developers (Build from Source)

```bash
# Clone
git clone <repo-url>
cd prismlauncher-racked

# Build
bash scripts/build-all-platforms.sh

# Create release
bash scripts/create-release.sh 1.0.0
```

## Configuration

Your launcher configuration is stored in:
- `prismlauncher.cfg` (in the launcher directory for portable mode)
- `instances/` (your Minecraft instances)
- `cache/` (download cache)

All these files travel with the launcher in portable mode!

## Custom Theme Files

- `themes/racked.ru/theme.json` - Theme colors
- `themes/racked.ru/themeStyle.css` - Qt stylesheet
- `catpacks/racked_ru.png` - Background cat image

## Support

- Website: https://racked.ru/
- Issue Tracker: GitHub Issues
- Based on: PrismLauncher upstream fork (Diegiwg)

## Updating

To update to a newer version:
1. Download the new release
2. Backup your `instances/` folder and `prismlauncher.cfg`
3. Replace all other files
4. Restore your backup
