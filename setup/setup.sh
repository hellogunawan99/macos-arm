#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"

echo ""
echo "=========================================="
echo "    macos-arm Setup (Gunawan's Mac)"
echo "=========================================="
echo ""

show_menu() {
    echo "What do you want to setup?"
    echo ""
    echo "  [1] Wallpaper Changer"
    echo "  [2] Terminal (Starship + FZF + Vi mode)"
    echo "  [3] Homebrew"
    echo "  [4] Image Tools (resize, compress)"
    echo "  [5] AI Tools (OpenCode, Claude Code, Gemini CLI)"
    echo "  [6] All of the above"
    echo "  [7] Uninstall"
    echo "  [8] Exit"
    echo ""
}

setup_wallpaper() {
    echo ""
    echo "=== Installing Wallpaper Changer ==="

    local WALLPAPER_DIR="$HOME/Pictures/wallpapers"
    local PLIST_PATH="$HOME/Library/LaunchAgents/com.wallpaper.changer.plist"

    if ! grep -q "wallpaper-changer" "$HOME/.zshrc" 2>/dev/null; then
        echo 'export PATH="$HOME/dev/macos-arm/wallpaper-changer:$PATH"' >> "$HOME/.zshrc"
        echo "[+] Added to PATH"
    else
        echo "[=] Already in PATH"
    fi

    mkdir -p "$WALLPAPER_DIR"
    touch "$WALLPAPER_DIR/.last_change"

    if [[ ! -f "$WALLPAPER_DIR/wallpapers.db" ]]; then
        sqlite3 "$WALLPAPER_DIR/wallpapers.db" "CREATE TABLE wallpapers (id INTEGER PRIMARY KEY, path TEXT, wallhaven_id TEXT, last_shown INTEGER)"
        echo "[+] Database created"
    fi

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
    echo "[+] Daemon installed & running"
    echo "    Run 'wp' to change wallpaper"
}

setup_terminal() {
    "$PARENT_DIR/terminal/setup.sh"
}

setup_homebrew() {
    "$PARENT_DIR/homebrew/setup.sh"
}

setup_image() {
    echo ""
    echo "=== Installing Image Tools ==="

    echo "[1/3] Installing ImageMagick, jpegoptim, pngquant..."
    brew install imagemagick jpegoptim pngquant

    echo "[2/3] Making resize script executable..."
    chmod +x "$PARENT_DIR/image/resize"

    echo "[3/3] Adding to PATH..."
    if ! grep -q 'macos-arm/image' "$HOME/.zshrc" 2>/dev/null; then
        echo 'export PATH="$HOME/dev/macos-arm/image:$PATH"' >> "$HOME/.zshrc"
    fi

    echo ""
    echo "[+] Image tools installed!"
    echo "    Usage: resize image.jpg 1MB"
    echo "           resize image.png 500KB"
}

setup_ai() {
    "$PARENT_DIR/ai-tools/setup.sh"
}

while true; do
    show_menu
    read -p "Select option [1-8]: " choice
    echo ""

    uninstall() {
    echo ""
    echo "=== Uninstall ==="
    echo ""
    echo "  [1] Wallpaper Changer"
    echo "  [2] Terminal"
    echo "  [3] Homebrew"
    echo "  [4] Image Tools"
    echo "  [5] AI Tools"
    echo "  [6] Everything"
    echo "  [7] Back"
    echo ""
    read -p "Select option [1-7]: " uninstall_choice

    case $uninstall_choice in
        1)
            echo ""
            echo "[1/2] Stopping wallpaper daemon..."
            launchctl unload "$HOME/Library/LaunchAgents/com.wallpaper.changer.plist" 2>/dev/null || true
            rm -f "$HOME/Library/LaunchAgents/com.wallpaper.changer.plist"
            echo "[+] Daemon stopped"

            echo "[2/2] Removing PATH entries..."
            sed -i '' '/wallpaper-changer/d' "$HOME/.zshrc" 2>/dev/null || true
            echo "[+] Wallpaper Changer removed"
            ;;
        2)
            "$PARENT_DIR/terminal/uninstall.sh"
            ;;
        3)
            "$PARENT_DIR/homebrew/uninstall.sh"
            ;;
        4)
            echo ""
            echo "[!] To uninstall Image Tools, run: brew uninstall imagemagick jpegoptim pngquant"
            ;;
        5)
            "$PARENT_DIR/ai-tools/uninstall.sh"
            ;;
        6)
            echo ""
            echo "[1/6] Stopping wallpaper daemon..."
            launchctl unload "$HOME/Library/LaunchAgents/com.wallpaper.changer.plist" 2>/dev/null || true
            rm -f "$HOME/Library/LaunchAgents/com.wallpaper.changer.plist"

            echo "[2/6] Removing PATH entries..."
            sed -i '' '/wallpaper-changer/d' "$HOME/.zshrc" 2>/dev/null || true

            echo "[3/6] Uninstalling Terminal..."
            "$PARENT_DIR/terminal/uninstall.sh"

            echo "[4/6] Uninstalling Homebrew..."
            "$PARENT_DIR/homebrew/uninstall.sh"

            echo "[5/6] Uninstalling Image Tools..."
            brew uninstall imagemagick jpegoptim pngquant 2>/dev/null || true

            echo "[6/6] Uninstalling AI Tools..."
            "$PARENT_DIR/ai-tools/uninstall.sh"
            ;;
        7) return ;;
        *) echo "Invalid option" ;;
    esac
}

case $choice in
        1) setup_wallpaper; echo "" ;;
        2) setup_terminal; echo "" ;;
        3) setup_homebrew; echo "" ;;
        4) setup_image; echo "" ;;
        5) setup_ai; echo "" ;;
        6)
            setup_wallpaper
            setup_terminal
            setup_homebrew
            setup_image
            setup_ai
            echo ""
            echo "=========================================="
            echo "    All setup complete!"
            echo "=========================================="
            echo ""
            echo "Restart terminal or run: source ~/.zshrc"
            exit 0
            ;;
        7) uninstall; echo "" ;;
        8) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option" ;;
    esac

    read -p "Press Enter to continue..."
done