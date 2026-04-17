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
    echo "  [4] All of the above"
    echo "  [5] Exit"
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
    echo ""
    echo "=== Setting up Homebrew ==="

    if command -v brew &>/dev/null; then
        echo "[=] Homebrew already installed"
    else
        echo "[+] Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zshrc"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo "[+] Homebrew ready"
    echo "    Run 'brew install <package>' to install packages"
}

while true; do
    show_menu
    read -p "Select option [1-5]: " choice
    echo ""

    case $choice in
        1) setup_wallpaper; echo "" ;;
        2) setup_terminal; echo "" ;;
        3) setup_homebrew; echo "" ;;
        4)
            setup_wallpaper
            setup_terminal
            setup_homebrew
            echo ""
            echo "=========================================="
            echo "    All setup complete!"
            echo "=========================================="
            echo ""
            echo "Restart terminal or run: source ~/.zshrc"
            exit 0
            ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option" ;;
    esac

    read -p "Press Enter to continue..."
done