# Racked.ru PrismLauncher - Release Checklist

## Pre-Release Verification

### Build Verification
- [ ] Windows build completes without errors
- [ ] Linux build completes without errors
- [ ] macOS build completes without errors
- [ ] All builds produce executable launcher
- [ ] Portable mode works (data stored locally)
- [ ] No missing DLLs or dependencies

### Theme Verification
- [ ] Application theme is racked.ru (black/red)
- [ ] Icon theme is flat_white
- [ ] Background shows racked_ru cat
- [ ] UI elements are readable
- [ ] No theme-related crashes

### Functionality Tests
- [ ] Launcher starts successfully
- [ ] Can create new instance
- [ ] Can launch Minecraft
- [ ] Settings persist between launches
- [ ] Portable mode stores data correctly
- [ ] No console errors on startup

### Size Verification
- [ ] Windows package is < 120MB
- [ ] Linux package is < 100MB
- [ ] macOS package is < 110MB
- [ ] Size reduction from full build is noticeable

### File Structure
- [ ] portable.txt present in root
- [ ] All Qt DLLs included (Windows)
- [ ] Platform plugins included
- [ ] Image format plugins included
- [ ] No unnecessary theme files

### Documentation
- [ ] BUILD_GUIDE.md is accurate
- [ ] README_RELEASE.md is clear
- [ ] PROJECT_SUMMARY.md covers all changes
- [ ] Build scripts are executable (Linux/macOS)

### Platform-Specific

#### Windows
- [ ] Runs on Windows 10/11
- [ ] No UAC errors
- [ ] Works from USB drive
- [ ] MSVC runtime DLLs included
- [ ] Qt bindings work correctly

#### Linux
- [ ] Runs on Ubuntu 22.04+
- [ ] Runs on Fedora 38+
- [ ] run.sh is executable
- [ ] LD_LIBRARY_PATH set correctly
- [ ] No missing shared libraries

#### macOS
- [ ] Runs on macOS 12+
- [ ] .app bundle is valid
- [ ] Codesigned (or instructions provided)
- [ ] No quarantine issues
- [ ] Intel and Apple Silicon support

## Release Creation

### Version Numbering
Use semantic versioning: MAJOR.MINOR.PATCH
- MAJOR: Breaking changes
- MINOR: New features
- PATCH: Bug fixes

### Create Release Package
```bash
# From project root
bash scripts/create-release.sh 1.0.0
```

### Verify Release Packages
- [ ] All three platform archives created
- [ ] Archives extract correctly
- [ ] Version number in filenames
- [ ] Release notes generated
- [ ] Archives are not corrupted

### Testing Release Packages
For each platform:
1. Extract archive to fresh directory
2. Run launcher
3. Verify theme loads
4. Create test instance
5. Verify portable mode
6. Delete test directory

## Distribution

### GitHub Release
1. Go to repository releases page
2. Create new release
3. Tag: v1.0.0
4. Title: "Racked.ru PrismLauncher v1.0.0"
5. Description: Copy from release notes
6. Upload all three archives
7. Mark as latest release

### Website (racked.ru)
Upload archives to your server:
```bash
# Example upload command
scp release/racked-prismlauncher-1.0.0-* user@racked.ru:/var/www/html/downloads/
```

### Update Download Links
Update https://racked.ru/ with new version links

## Post-Release

### Documentation
- [ ] Update CHANGELOG.md
- [ ] Update version in README
- [ ] Note any known issues
- [ ] Document platform-specific quirks

### Communication
- [ ] Announce on your website
- [ ] Update Discord/forums if applicable
- [ ] Tag upstream PrismLauncher if sharing back

### Backup
- [ ] Tag git repository
- [ ] Backup source code
- [ ] Backup build artifacts
- [ ] Keep release packages

## Known Limitations

These components were intentionally removed:
- Alternative icon themes (only flat_white kept)
- Alternative application themes (only racked.ru kept)
- Some built-in backgrounds (only racked_ru kept)

## Success Criteria

Release is successful when:
1. All three platforms build without errors
2. Launcher runs with correct theme
3. Portable mode works correctly
4. Package sizes are reasonable
5. No crash reports in first 24 hours

## Rollback Plan

If issues are found:
1. Keep previous version available
2. Document the issue
3. Fix in development branch
4. Increment patch version
5. Create new release

---

Last updated: 2026-04-13
Version: 1.0.0 (initial release)
