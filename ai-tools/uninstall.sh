#!/bin/bash

set -e

echo ""
echo "=== Uninstall AI Tools ==="
echo ""
echo "  [1] Opencode"
echo "  [2] Claude Code"
echo "  [3] Gemini CLI"
echo "  [4] All of the above"
echo "  [5] Back"
echo ""
read -p "Select option [1-5]: " choice

case $choice in
    1)
        echo ""
        echo "[1/2] Removing Opencode..."
        rm -rf "$HOME/.opencode"
        sed -i '' '/opencode/d' "$HOME/.zshrc" 2>/dev/null || true
        echo "[+] Opencode removed"

        echo "[2/2] Removing PATH entry..."
        sed -i '' '/\.opencode\/bin/d' "$HOME/.zshrc" 2>/dev/null || true
        ;;
    2)
        echo ""
        echo "[+] Uninstalling Claude Code..."
        npm uninstall -g @anthropic/claude-code
        sed -i '' '/claude-skip/d' "$HOME/.zshrc" 2>/dev/null || true
        echo "[+] Claude Code removed"
        ;;
    3)
        echo ""
        echo "[+] Uninstalling Gemini CLI..."
        npm uninstall -g @google/gemini-cli
        echo "[+] Gemini CLI removed"
        ;;
    4)
        echo ""
        echo "[1/5] Removing Opencode..."
        rm -rf "$HOME/.opencode"
        sed -i '' '/opencode/d' "$HOME/.zshrc" 2>/dev/null || true
        sed -i '' '/\.opencode\/bin/d' "$HOME/.zshrc" 2>/dev/null || true

        echo "[2/5] Uninstalling Claude Code..."
        npm uninstall -g @anthropic/claude-code 2>/dev/null || true
        sed -i '' '/claude-skip/d' "$HOME/.zshrc" 2>/dev/null || true

        echo "[3/5] Uninstalling Gemini CLI..."
        npm uninstall -g @google/gemini-cli 2>/dev/null || true

        echo "[4/5] Removing aliases..."
        sed -i '' '/claude-skip/d' "$HOME/.zshrc" 2>/dev/null || true

        echo "[+] All AI tools removed"
        ;;
    5) return ;;
    *) echo "Invalid option" ;;
esac