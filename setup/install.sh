#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
PLIST_PATH="$HOME/Library/LaunchAgents/com.wallpaper.changer.plist"

echo "=== Wallpaper Changer Setup ==="

echo "[1/4] Adding to PATH..."
if ! grep -q "wallpaper-changer" "$HOME/.zshrc" 2>/dev/null; then
    echo 'export PATH="$HOME/dev/macos-arm/wallpaper-changer:$PATH"' >> "$HOME/.zshrc"
    echo "Added to ~/.zshrc - restart shell or run: source ~/.zshrc"
else
    echo "Already in PATH"
fi

echo "[2/4] Creating wallpapers directory..."
mkdir -p "$WALLPAPER_DIR"
mkdir -p "$WALLPAPER_DIR/wallpapers"
touch "$WALLPAPER_DIR/.last_change"

echo "[3/4] Creating database..."
if [[ ! -f "$WALLPAPER_DIR/wallpapers.db" ]]; then
    sqlite3 "$WALLPAPER_DIR/wallpapers.db" "CREATE TABLE wallpapers (id INTEGER PRIMARY KEY, path TEXT, wallhaven_id TEXT, last_shown INTEGER)"
    echo "Database created"
else
    echo "Database already exists"
fi

echo "[4/4] Setting up daemon..."
if [[ -f "$PLIST_PATH" ]]; then
    launchctl unload "$PLIST_PATH" 2>/dev/null || true
fi

cat > "$PLIST_PATH" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.wallpaper.changer</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Users/gunawan/dev/macos-arm/wallpaper-changer/wp-daemon</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF

launchctl load "$PLIST_PATH"
echo "Daemon loaded"

echo ""
echo "=== Done! ==="
echo "Run 'wp' to change wallpaper"
echo "Or restart terminal and the daemon will auto-run"
