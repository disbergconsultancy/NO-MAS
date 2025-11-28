# No Mas! Makefile
# Simple commands for building and installing No Mas!

.PHONY: build install uninstall clean run help test release

# Configuration
APP_NAME := NoMas
DISPLAY_NAME := No Mas!
BUILD_DIR := .build/release
APP_BUNDLE := $(BUILD_DIR)/$(APP_NAME).app
INSTALL_DIR := /Applications

help:
	@echo "No Mas! - macOS Calendar Sync App (No Meeting Auto-Accept)"
	@echo ""
	@echo "Usage:"
	@echo "  make build      Build the app bundle"
	@echo "  make install    Build and install to /Applications"
	@echo "  make uninstall  Remove from /Applications"
	@echo "  make run        Build and run the app"
	@echo "  make clean      Remove build artifacts"
	@echo "  make test       Run unit tests"
	@echo "  make release    Create a release package (VERSION=x.x.x)"
	@echo ""

build:
	@echo "🔨 Building No Mas!..."
	@./scripts/build.sh

install: build
	@echo "📦 Installing to $(INSTALL_DIR)..."
	@if [ -d "$(INSTALL_DIR)/$(APP_NAME).app" ]; then \
		echo "⚠️  Removing existing installation..."; \
		rm -rf "$(INSTALL_DIR)/$(APP_NAME).app"; \
	fi
	@cp -r "$(APP_BUNDLE)" "$(INSTALL_DIR)/"
	@echo "✅ No Mas! installed to $(INSTALL_DIR)/$(APP_NAME).app"
	@echo ""
	@echo "Launch with: open /Applications/NoMas.app"

uninstall:
	@echo "🗑️  Uninstalling No Mas!..."
	@if [ -d "$(INSTALL_DIR)/$(APP_NAME).app" ]; then \
		rm -rf "$(INSTALL_DIR)/$(APP_NAME).app"; \
		echo "✅ No Mas! removed from $(INSTALL_DIR)"; \
	else \
		echo "ℹ️  No Mas! is not installed in $(INSTALL_DIR)"; \
	fi

run: build
	@echo "🚀 Launching No Mas!..."
	@open "$(APP_BUNDLE)"

clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -rf .build
	@echo "✅ Clean complete"

test:
	@echo "🧪 Running tests..."
	@swift run NoMasTests

release:
	@chmod +x scripts/release.sh
	@./scripts/release.sh $(VERSION)
