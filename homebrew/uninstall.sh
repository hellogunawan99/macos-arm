#!/bin/bash

set -e

echo ""
echo "=== Uninstall Homebrew ==="

if ! command -v brew &>/dev/null; then
    echo "[=] Homebrew not installed"
    exit 0
fi

echo "[!] This will remove Homebrew completely"
read -p "Are you sure? [y/N] " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "[+] Uninstalling Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    sed -i '' '/brew shellenv/d' "$HOME/.zshrc" 2>/dev/null || true
    echo "[+] Homebrew uninstalled"
else
    echo "Cancelled"
fi