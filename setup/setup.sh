#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

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
    echo "  [3] Dev Tools (NVM, Bun, Docker CLI)"
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
    echo ""
    echo "=== Setting up Terminal ==="

    echo "[1/5] Installing Starship prompt..."
    if command -v starship &>/dev/null; then
        echo "[=] Starship already installed"
    else
        curl -sS https://starship.rs/install.sh | sh
        echo "[+] Starship installed"
    fi

    echo "[2/5] Configuring Starship in .zshrc..."
    if ! grep -q 'starship init zsh' "$HOME/.zshrc" 2>/dev/null; then
        echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
    fi

    echo "[3/5] Installing FZF..."
    if command -v fzf &>/dev/null; then
        echo "[=] FZF already installed"
    else
        brew install fzf
        $(brew --prefix)/opt/fzf/install --all 2>/dev/null || true
    fi

    if ! grep -q 'source <(fzf --zsh)' "$HOME/.zshrc" 2>/dev/null; then
        echo 'source <(fzf --zsh)' >> "$HOME/.zshrc"
    fi
    if ! grep -q 'FZF_DEFAULT_COMMAND' "$HOME/.zshrc" 2>/dev/null; then
        echo "export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'" >> "$HOME/.zshrc"
        echo "export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git'" >> "$HOME/.zshrc"
    fi

    echo "[4/5] Setting up Vi mode..."
    if ! grep -q 'set -o vi' "$HOME/.zshrc" 2>/dev/null; then
        echo 'set -o vi' >> "$HOME/.zshrc"
        echo 'bindkey -v' >> "$HOME/.zshrc"
    fi

    echo "[5/5] Installing zsh plugins..."
    local PLUGIN_DIR="$HOME/.zsh/plugins"
    mkdir -p "$PLUGIN_DIR"

    if [[ ! -d "$PLUGIN_DIR/zsh-history-substring-search" ]]; then
        git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search "$PLUGIN_DIR/zsh-history-substring-search"
    fi
    if [[ ! -d "$PLUGIN_DIR/zsh-autosuggestions" ]]; then
        git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR/zsh-autosuggestions"
    fi
    if [[ ! -d "$PLUGIN_DIR/zsh-syntax-highlighting" ]]; then
        git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGIN_DIR/zsh-syntax-highlighting"
    fi

    if ! grep -q 'zsh-history-substring-search.zsh' "$HOME/.zshrc" 2>/dev/null; then
        echo 'source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh' >> "$HOME/.zshrc"
        echo 'source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> "$HOME/.zshrc"
        echo 'source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> "$HOME/.zshrc"
    fi

    echo ""
    echo "[+] Terminal setup complete!"
    echo "    Restart terminal or run: source ~/.zshrc"
}

setup_devtools() {
    echo ""
    echo "=== Setting up Dev Tools ==="

    echo "[1/3] NVM..."
    export NVM_DIR="$HOME/.nvm"
    if [[ ! -d "$NVM_DIR" ]]; then
        mkdir "$NVM_DIR"
        git clone --depth 1 https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        (cd "$NVM_DIR" && git checkout --depth 1 v0.39.7 2>/dev/null || true)
    fi
    if ! grep -q 'NVM_DIR' "$HOME/.zshrc" 2>/dev/null; then
        echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.zshrc"
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$HOME/.zshrc"
    fi
    echo "[+] NVM installed"

    echo "[2/3] Bun..."
    if command -v bun &>/dev/null; then
        echo "[=] Bun already installed"
    else
        curl -fsSL https://bun.sh/install | bash
        echo 'export BUN_INSTALL="$HOME/.bun"' >> "$HOME/.zshrc"
        echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> "$HOME/.zshrc"
        echo "[+] Bun installed"
    fi

    echo "[3/3] Docker CLI completions..."
    if ! grep -q 'fpath.*docker/completions' "$HOME/.zshrc" 2>/dev/null; then
        echo 'fpath=(/Users/gunawan/.docker/completions $fpath)' >> "$HOME/.zshrc"
        echo 'autoload -Uz compinit' >> "$HOME/.zshrc"
        echo 'compinit' >> "$HOME/.zshrc"
    fi
    echo "[+] Docker completions configured"

    echo ""
    echo "[+] Dev tools setup complete!"
}

while true; do
    show_menu
    read -p "Select option [1-5]: " choice
    echo ""

    case $choice in
        1) setup_wallpaper; echo "" ;;
        2) setup_terminal; echo "" ;;
        3) setup_devtools; echo "" ;;
        4)
            setup_wallpaper
            setup_terminal
            setup_devtools
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