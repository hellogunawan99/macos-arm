# macos-arm 🖥️

> Setup scripts for macOS ARM (MacBook Air M1) - One command to set up everything

## Features

| Module | Description |
|--------|-------------|
| 🖼️ **Wallpaper Changer** | Auto-download anime wallpapers from Wallhaven, changes every 20 mins |
| 💻 **Terminal** | Starship prompt, FZF fuzzy finder, Vi mode, zsh plugins |
| 🍺 **Homebrew** | Package manager installation |
| 🖼️ **Image Tools** | Resize & compress images to target file size |
| 🤖 **AI Tools** | OpenCode, Claude Code, Gemini CLI |

## Structure

```
macos-arm/
├── wallpaper-changer/     # wp command + auto-change daemon
├── terminal/              # Terminal customization
├── homebrew/              # Package manager
├── image/                 # Image resize script
├── ai-tools/              # OpenCode, Claude, Gemini CLI
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
  [4] Image Tools             - Resize & compress images
  [5] AI Tools               - OpenCode, Claude Code, Gemini CLI
  [6] Install everything      - Setup semua
  [7] Uninstall              - Hapus setup
  [8] Exit
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

### Image Resize
```bash
resize image.jpg 1MB      # Resize JPEG to max 1MB
resize image.jpg 500KB    # Resize JPEG to max 500KB
resize image.png 2MB      # Resize PNG to max 2MB
```

Output: `image_resized.jpg` (original stays intact)

### AI Tools
```bash
opencode              # OpenCode AI coding agent
claude                # Claude Code
claude-skip           # Claude Code with auto permission
gemini                # Gemini CLI
```

## Uninstall

Pilih menu **7**, lalu pilih apa yang mau dihapus:

```
  [1] Wallpaper Changer
  [2] Terminal
  [3] Homebrew
  [4] Image Tools
  [5] AI Tools
  [6] Everything
  [7] Back
```

## Author

Gunawan Wibisono - [@hellogunawan99](https://github.com/hellogunawan99)