@echo off
REM Build script for Windows portable version of Racked.ru PrismLauncher
REM This creates a portable build that can be run from USB drives

setlocal EnableDelayedExpansion

REM Configuration
set BUILD_TYPE=Release
set BUILD_DIR=build-windows-portable
set INSTALL_DIR=install-windows-portable
set QT_PATH=C:\Qt\6.5.3\msvc2019_64

REM Clean previous builds
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
if exist "%INSTALL_DIR%" rmdir /s /q "%INSTALL_DIR%"

mkdir "%BUILD_DIR%"
cd "%BUILD_DIR%"

echo ========================================
echo Building Racked.ru PrismLauncher (Windows Portable)
echo ========================================

REM Configure with CMake
cmake .. ^
    -G "Visual Studio 17 2022" ^
    -A x64 ^
    -DCMAKE_BUILD_TYPE=%BUILD_TYPE% ^
    -DCMAKE_INSTALL_PREFIX="../%INSTALL_DIR%" ^
    -DCMAKE_PREFIX_PATH="%QT_PATH%" ^
    -DLauncher_QT_VERSION_MAJOR=6 ^
    -DENABLE_LTO=ON ^
    -DUSE_SYSTEM_LIBS=OFF

if errorlevel 1 (
    echo CMake configuration failed!
    exit /b 1
)

REM Build
cmake --build . --config %BUILD_TYPE% --parallel %NUMBER_OF_PROCESSORS%

if errorlevel 1 (
    echo Build failed!
    exit /b 1
)

REM Install to staging directory
cmake --install . --config %BUILD_TYPE%

if errorlevel 1 (
    echo Installation failed!
    exit /b 1
)

cd ..

REM Create portable package
echo Creating portable package...
set RELEASE_DIR=release\Racked.ru-PrismLauncher-Windows-Portable

if exist "%RELEASE_DIR%" rmdir /s /q "%RELEASE_DIR%"
mkdir "%RELEASE_DIR%"

REM Copy built files
xcopy /E /I /Y "%INSTALL_DIR%\*" "%RELEASE_DIR%\"

REM Copy portable.txt to enable portable mode
copy launcher\portable.txt "%RELEASE_DIR%\"

REM Copy Qt6 DLLs and dependencies
copy "C:\Qt\6.5.3\msvc2019_64\bin\Qt6Core.dll" "%RELEASE_DIR%\"
copy "C:\Qt\6.5.3\msvc2019_64\bin\Qt6Gui.dll" "%RELEASE_DIR%\"
copy "C:\Qt\6.5.3\msvc2019_64\bin\Qt6Widgets.dll" "%RELEASE_DIR%\"
copy "C:\Qt\6.5.3\msvc2019_64\bin\Qt6Network.dll" "%RELEASE_DIR%\"
copy "C:\Qt\6.5.3\msvc2019_64\bin\Qt6Svg.dll" "%RELEASE_DIR%\"
copy "C:\Qt\6.5.3\msvc2019_64\bin\Qt6Xml.dll" "%RELEASE_DIR%\"
copy "C:\Qt\6.5.3\msvc2019_64\bin\Qt6OpenGL.dll" "%RELEASE_DIR%\"
copy "C:\Qt\6.5.3\msvc2019_64\bin\Qt6Core5Compat.dll" "%RELEASE_DIR%\"
copy "C:\Qt\6.5.3\msvc2019_64\bin\Qt6NetworkAuth.dll" "%RELEASE_DIR%\"

REM Copy Qt platforms
mkdir "%RELEASE_DIR%\platforms"
copy "C:\Qt\6.5.3\msvc2019_64\plugins\platforms\qwindows.dll" "%RELEASE_DIR%\platforms\"

mkdir "%RELEASE_DIR%\iconengines"
copy "C:\Qt\6.5.3\msvc2019_64\plugins\iconengines\*.*" "%RELEASE_DIR%\iconengines\"

mkdir "%RELEASE_DIR%\imageformats"
copy "C:\Qt\6.5.3\msvc2019_64\plugins\imageformats\*.*" "%RELEASE_DIR%\imageformats\"

mkdir "%RELEASE_DIR%\styles"
copy "C:\Qt\6.5.3\msvc2019_64\plugins\styles\*.*" "%RELEASE_DIR%\styles\"

REM Copy required runtime DLLs
where msvcp140.dll >nul 2>&1
if not errorlevel 1 (
    for /f "tokens=*" %%i in ('where msvcp140.dll') do copy "%%i" "%RELEASE_DIR%\"
)

where vcruntime140.dll >nul 2>&1
if not errorlevel 1 (
    for /f "tokens=*" %%i in ('where vcruntime140.dll') do copy "%%i" "%RELEASE_DIR%\"
)

echo ========================================
echo Build complete!
echo Output: %RELEASE_DIR%
echo ========================================
echo To create a release archive, zip the %RELEASE_DIR% folder
echo ========================================

exit /b 0
