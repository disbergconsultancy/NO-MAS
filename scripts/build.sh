#!/bin/bash

# No Mas! Build Script
# Creates a proper macOS .app bundle from the Swift package

set -e

echo "🔨 Building No Mas!..."

# Configuration
APP_NAME="NoMas"
DISPLAY_NAME="No Mas!"
BUILD_DIR=".build/release"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
CONTENTS_DIR="$APP_BUNDLE/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"

# Clean previous build
rm -rf "$APP_BUNDLE"

# Build the executable
echo "📦 Compiling Swift code..."
swift build -c release

# Create app bundle structure
echo "📁 Creating app bundle structure..."
mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

# Copy executable
cp "$BUILD_DIR/$APP_NAME" "$MACOS_DIR/"

# Copy Info.plist
cp "Sources/NoMas/Resources/Info.plist" "$CONTENTS_DIR/"

# Create PkgInfo
echo -n "APPL????" > "$CONTENTS_DIR/PkgInfo"

# Copy any additional resources
if [ -d "Sources/NoMas/Resources" ]; then
    # Copy resources except Info.plist (already copied)
    find "Sources/NoMas/Resources" -type f ! -name "Info.plist" -exec cp {} "$RESOURCES_DIR/" \;
fi

# Ad-hoc code sign the app bundle
echo "🔐 Code signing app bundle..."
codesign --sign - --force --deep "$APP_BUNDLE"

echo "✅ Build complete!"
echo "📍 App bundle created at: $APP_BUNDLE"
echo ""
echo "To install, run:"
echo "  cp -r \"$APP_BUNDLE\" /Applications/"
echo ""
echo "Or to run directly:"
echo "  open \"$APP_BUNDLE\""
