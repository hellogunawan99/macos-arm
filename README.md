# macos-arm 🖥️

> Setup scripts for macOS ARM (MacBook Air M1) - One command to set up everything

## Features

| Module | Description |
|--------|-------------|
| 🖼️ **Wallpaper Changer** | Auto-download anime wallpapers from Wallhaven, changes every 20 mins |
| 💻 **Terminal** | Starship prompt, FZF fuzzy finder, Vi mode, zsh plugins |
| 🍺 **Homebrew** | Package manager installation |

## Structure

```
macos-arm/
├── wallpaper-changer/     # wp command + auto-change daemon
├── terminal/              # Terminal customization
├── homebrew/              # Package manager
└── setup/                 # Main menu
    └── setup.sh
```

## Quick Start (Fresh Mac)

```bash
git clone https://github.com/hellogunawan99/macos-arm.git
cd macos-arm
./setup/setup.sh
```

## Menu Options

```
  [1] Wallpaper Changer      - Auto wallpaper dari Wallhaven
  [2] Terminal               - Starship + FZF + Vi mode
  [3] Homebrew               - Package manager
  [4] Install everything     - Setup semua
  [5] Uninstall              - Hapus setup
  [6] Exit
```

## Usage

### Wallpaper Changer
```bash
wp              # Random anime wallpaper
wp cyber        # Search wallpaper
wp anime girl   # Custom search
wp --help      # Show help
```

### Terminal Themes
- Starship prompt (📦 git, node, python, etc.)
- FZF Ctrl+T / Ctrl+R
- Vi mode keybindings

## Uninstall

Pilih menu **5**, lalu pilih apa yang mau dihapus:

```
  [1] Wallpaper Changer
  [2] Terminal
  [3] Homebrew
  [4] Everything
  [5] Back
```

## Author

Gunawan Wibisono - [@hellogunawan99](https://github.com/hellogunawan99)