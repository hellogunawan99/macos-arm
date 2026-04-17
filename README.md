# macos-arm

Scripts and configs for macOS ARM (MacBook Air M1)

## Structure

```
macos-arm/
├── wallpaper-changer/
│   ├── wp
│   └── wp-daemon
├── terminal/
│   ├── setup.sh
│   └── uninstall.sh
├── homebrew/
│   ├── setup.sh
│   └── uninstall.sh
└── setup/
    └── setup.sh          # Main menu
```

## Quick Setup (Fresh Mac)

```bash
git clone https://github.com/hellogunawan99/macos-arm.git
cd macos-arm
./setup/setup.sh
```

Menu options:
- **1** - Wallpaper Changer
- **2** - Terminal (Starship, FZF, Vi mode, plugins)
- **3** - Homebrew
- **4** - Install everything
- **5** - Uninstall
- **6** - Exit

## Uninstall

Choose option **5** from the menu, then select what to uninstall:
- **1** - Wallpaper Changer
- **2** - Terminal
- **3** - Homebrew
- **4** - Everything
- **5** - Back