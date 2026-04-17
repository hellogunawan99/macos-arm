#!/bin/bash

echo "=== Uninstall Wallpaper Changer ==="

PLIST_PATH="$HOME/Library/LaunchAgents/com.wallpaper.changer.plist"

echo "[1/3] Stopping daemon..."
launchctl unload "$PLIST_PATH" 2>/dev/null || true
rm -f "$PLIST_PATH"

echo "[2/3] Removing from PATH..."
if grep -q "wallpaper-changer" "$HOME/.zshrc" 2>/dev/null; then
    sed -i '' '/wallpaper-changer/d' "$HOME/.zshrc"
    echo "Removed from ~/.zshrc"
fi

echo "[3/3] Wallpapers kept in ~/Pictures/wallpapers (delete manually if wanted)"

echo ""
echo "Done! Restart terminal or run: source ~/.zshrc"
