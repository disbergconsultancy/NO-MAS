#!/bin/bash

# No Mas! Release Script
# Creates a release package for Homebrew distribution

set -e

# Configuration
VERSION="${1:-1.0.0}"
APP_NAME="NoMas"
DISPLAY_NAME="No Mas!"
BUILD_DIR=".build/release"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
RELEASE_DIR="releases"
ZIP_NAME="$APP_NAME-$VERSION.zip"

echo "🚀 Creating $DISPLAY_NAME release v$VERSION..."

# Build the app first
echo "📦 Building app..."
./scripts/build.sh

# Create releases directory (use absolute path)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
RELEASE_PATH="$PROJECT_ROOT/$RELEASE_DIR"
mkdir -p "$RELEASE_PATH"

# Create the zip file
echo "📦 Creating release package..."
cd "$BUILD_DIR"
zip -r "$RELEASE_PATH/$ZIP_NAME" "$APP_NAME.app"
cd "$PROJECT_ROOT"

# Calculate SHA256
echo "🔐 Calculating SHA256 hash..."
SHA256=$(shasum -a 256 "$RELEASE_PATH/$ZIP_NAME" | cut -d' ' -f1)

echo ""
echo "✅ Release package created!"
echo ""
echo "📍 Package: $RELEASE_DIR/$ZIP_NAME"
echo "🔐 SHA256:  $SHA256"
echo ""
echo "📝 Next steps:"
echo "   1. Create a GitHub release at:"
echo "      https://github.com/disbergconsultancy/CAL-SYNC/releases/new"
echo ""
echo "   2. Tag: v$VERSION"
echo "   3. Upload: $RELEASE_DIR/$ZIP_NAME"
echo ""
echo "   4. Update Formula/nomas.rb with:"
echo "      version \"$VERSION\""
echo "      sha256 \"$SHA256\""
echo ""
echo "   5. Push changes to homebrew-nomas repo"
