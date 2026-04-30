# Adding Java 21 to Your Launcher (For Minecraft 1.21.10)

## The Issue
Minecraft 1.21.10 requires **Java 21**, but your system has Java 25 (too new).

## Quick Solution - Install Java 21 Locally (No Root Needed)

### Step 1: Download Java 21

```bash
# Go to your launcher folder
cd /home/admin/ai-lab/_projects/_minecraft/launcher/

# Create java directory
mkdir -p java

# Download Adoptium Java 21 (portable tar.gz)
cd java
wget https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz

# Extract it
tar xzf OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz

# Verify
ls -la
# You should see: jdk-21.0.5+11/
```

### Step 2: Configure Launcher to Use It

**Option A: Via Launcher GUI (Easiest)**
1. Run your launcher: `bash start.sh`
2. Go to **Settings** (gear icon)
3. Click **Java** tab
4. Under "Java Installation", click **"Auto-detect"** or **"Browse"**
5. Navigate to: `/home/admin/ai-lab/_projects/_minecraft/launcher/java/jdk-21.0.5+11/bin/java`
6. Click **OK**

**Option B: Edit Config File Directly**
```bash
cd /home/admin/ai-lab/_projects/_minecraft/launcher/

# Edit the config file
nano bin/prismlauncher.cfg

# Find or add these lines:
JavaPath=/home/admin/ai-lab/_projects/_minecraft/launcher/java/jdk-21.0.5+11/bin/java
JavaDetect=true

# Save (Ctrl+X, Y, Enter)
```

### Step 3: Test It

```bash
# Run launcher
cd /home/admin/ai-lab/_projects/_minecraft/launcher/
bash start.sh

# Create a 1.21.10 instance
# It should now work without version errors!
```

## Alternative Java 21 Downloads

If the above link doesn't work:

### Amazon Corretto 21
```bash
cd java
wget https://corretto.aws/downloads/latest/amazon-corretto-21-x64-linux-jdk.tar.gz
tar xzf amazon-corretto-21-x64-linux-jdk.tar.gz
```

### Azul Zulu 21
```bash
cd java
wget https://cdn.azul.com/zulu/bin/zulu21.38.21-ca-jdk21.0.5-linux_x64.tar.gz
tar xzf zulu21.38.21-ca-jdk21.0.5-linux_x64.tar.gz
```

## Verify It's Working

```bash
# Test the Java version
java/jdk-21.0.5+11/bin/java -version

# Should output:
# openjdk version "21.0.5"
# OpenJDK Runtime Environment ...
# OpenJDK 64-Bit Server VM ...
```

## Permanent Storage

With this setup:
- ✅ Java is stored **inside your launcher folder**
- ✅ Portable - travels with the launcher
- ✅ Works from USB drives
- ✅ No root/sudo needed
- ✅ Doesn't affect system Java

## Folder Structure After Adding Java

```
launcher/
├── start.sh
├── bin/
│   └── prismlauncher
├── java/
│   └── jdk-21.0.5+11/    ← Java 21 installed here
│       ├── bin/
│       │   └── java      ← Point to this
│       └── (other files)
└── share/
```

## For Minecraft 1.21.10

**Required Java Versions:**
- Minimum: Java 21
- Recommended: Java 21.0.5 or later

**NOT Compatible:**
- ❌ Java 8 (too old)
- ❌ Java 17 (too old for 1.21)
- ❌ Java 25 (too new, causes issues)

## Quick Install Script

Copy-paste this entire block to auto-install Java 21:

```bash
cd /home/admin/ai-lab/_projects/_minecraft/launcher/
mkdir -p java && cd java
wget https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz
tar xzf OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz
cd ..
echo "Java installed!"
ls -la java/
echo ""
echo "Now configure your launcher to use:"
echo "java/jdk-21.0.5+11/bin/java"
```

---

**Updated:** 2026-04-13
**For:** Minecraft 1.21.10
**Java Version:** 21.0.5+11 (LTS)
