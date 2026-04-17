#!/bin/bash

set -e

echo ""
echo "=== Installing AI Tools ==="

echo "[1/4] Opencode..."
if command -v opencode &>/dev/null; then
    echo "[=] Opencode already installed"
else
    curl -fsSL https://opencode.ai/install | bash
    echo 'export PATH="$HOME/.opencode/bin:$PATH"' >> "$HOME/.zshrc"
    echo "[+] Opencode installed"
fi

echo "[2/4] Claude Code..."
if command -v claude &>/dev/null; then
    echo "[=] Claude Code already installed"
else
    npm install -g @anthropic/claude-code
    echo "[+] Claude Code installed"
fi

echo "[3/4] Gemini CLI..."
if command -v gemini &>/dev/null; then
    echo "[=] Gemini CLI already installed"
else
    npm install -g @google/gemini-cli
    echo "[+] Gemini CLI installed"
fi

echo "[4/4] Adding shortcuts to .zshrc..."
if ! grep -q 'claude-skip' "$HOME/.zshrc" 2>/dev/null; then
    echo "alias claude-skip='claude --permission-mode auto'" >> "$HOME/.zshrc"
fi

echo ""
echo "[+] All AI tools installed!"
echo ""
echo "Usage:"
echo "  opencode              # OpenCode AI coding agent"
echo "  claude               # Claude Code"
echo "  claude-skip          # Claude Code with auto permission"
echo "  gemini               # Gemini CLI"