#!/bin/bash

set -e

echo ""
echo "=== Uninstall Terminal ==="

echo "[1/4] Removing Starship..."
sed -i '' '/starship init zsh/d' "$HOME/.zshrc" 2>/dev/null || true

echo "[2/4] Removing FZF..."
sed -i '' '/fzf --zsh/d' "$HOME/.zshrc" 2>/dev/null || true
sed -i '' '/FZF_DEFAULT_COMMAND/d' "$HOME/.zshrc" 2>/dev/null || true
sed -i '' '/FZF_CTRL_T_COMMAND/d' "$HOME/.zshrc" 2>/dev/null || true
sed -i '' '/fzf --zsh/d' "$HOME/.zshrc" 2>/dev/null || true
brew uninstall fzf 2>/dev/null || true

echo "[3/4] Removing Vi mode..."
sed -i '' '/set -o vi/d' "$HOME/.zshrc" 2>/dev/null || true
sed -i '' '/bindkey -v/d' "$HOME/.zshrc" 2>/dev/null || true

echo "[4/4] Removing zsh plugins..."
sed -i '' '/zsh-history-substring-search/d' "$HOME/.zshrc" 2>/dev/null || true
sed -i '' '/zsh-autosuggestions/d' "$HOME/.zshrc" 2>/dev/null || true
sed -i '' '/zsh-syntax-highlighting/d' "$HOME/.zshrc" 2>/dev/null || true
rm -rf "$HOME/.zsh/plugins" 2>/dev/null || true

echo ""
echo "[+] Terminal uninstalled"
echo "Restart terminal or run: source ~/.zshrc"