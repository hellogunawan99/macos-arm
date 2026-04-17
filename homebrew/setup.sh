#!/bin/bash

set -e

echo ""
echo "=== Setting up Homebrew ==="

if command -v brew &>/dev/null; then
    echo "[=] Homebrew already installed"
else
    echo "[+] Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo ""
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zshrc"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "[+] Homebrew installed"
fi

echo ""
echo "[+] Homebrew ready"
echo ""
echo "Common packages:"
echo "  brew install git, node, python, curl, wget, fzf, starship, etc."