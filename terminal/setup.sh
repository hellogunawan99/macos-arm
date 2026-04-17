#!/bin/bash

set -e

echo ""
echo "=== Setting up Terminal ==="

echo "[1/7] Installing Starship prompt..."
if command -v starship &>/dev/null; then
    echo "[=] Starship already installed"
else
    curl -sS https://starship.rs/install.sh | sh
    echo "[+] Starship installed"
fi

echo "[2/7] Configuring Starship in .zshrc..."
if ! grep -q 'starship init zsh' "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

echo "[3/7] Installing FZF..."
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

echo "[4/7] Configuring Vim..."
if [[ ! -f "$HOME/.vimrc" ]]; then
    cp "$PARENT_DIR/terminal/vimrc" "$HOME/.vimrc"
    echo "[+] Vim config installed"
else
    echo "[=] Vim config already exists"
fi

echo "[5/7] Setting up Vi mode..."
if ! grep -q 'set -o vi' "$HOME/.zshrc" 2>/dev/null; then
    echo 'set -o vi' >> "$HOME/.zshrc"
    echo 'bindkey -v' >> "$HOME/.zshrc"
fi

echo "[6/7] Installing zsh plugins..."
PLUGIN_DIR="$HOME/.zsh/plugins"
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
if [[ ! -d "$PLUGIN_DIR/zsh-vi-mode" ]]; then
    git clone --depth 1 https://github.com/jeffreytse/zsh-vi-mode "$PLUGIN_DIR/zsh-vi-mode"
fi

if ! grep -q 'zsh-history-substring-search.zsh' "$HOME/.zshrc" 2>/dev/null; then
    echo 'source ~/.zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh' >> "$HOME/.zshrc"
    echo 'source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh' >> "$HOME/.zshrc"
    echo 'source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> "$HOME/.zshrc"
    echo 'source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> "$HOME/.zshrc"
fi

echo '[7/7] Configuring vi mode colors...'
if ! grep -q 'ZVM_COLOR' "$HOME/.zshrc" 2>/dev/null; then
    cat >> "$HOME/.zshrc" << 'EOF'
# Vi mode colors
ZVM_INSERT_MODE_FOREGROUND=cyan
ZVM_NORMAL_MODE_FOREGROUND=green
ZVM_VI_ESCAPE_KEYBINDING=jj
EOF
fi

echo ""
echo "[+] Terminal setup complete!"
echo "    Restart terminal or run: source ~/.zshrc"