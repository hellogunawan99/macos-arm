# macos-arm

Scripts and configs for macOS ARM (MacBook Air M1)

## Structure

```
macos-arm/
├── wallpaper-changer/    # Auto wallpaper from Wallhaven
├── terminal/             # Terminal setup (Starship, FZF, Vi mode, plugins)
└── setup/                # Setup scripts
    ├── setup.sh         # Interactive menu (calls other setups)
    ├── install.sh        # Wallpaper only installer
    └── uninstall.sh      # Cleanup script
```

## Quick Setup (Fresh Mac)

```bash
git clone https://github.com/hellogunawan99/macos-arm.git
cd macos-arm
./setup/setup.sh
```

Choose from the menu:
- **1** - Wallpaper Changer only
- **2** - Terminal setup
- **3** - Homebrew
- **4** - Install everything
- **5** - Uninstall
- **6** - Exit

## Manual Setup

### Wallpaper Changer
```bash
./wallpaper-changer/wp              # Random anime wallpaper
./wallpaper-changer/wp cyber        # Search wallpaper
./wallpaper-changer/wp --help       # Show help
```

### Terminal
```bash
./terminal/setup.sh
```

