# macos-arm

Scripts and configs for macOS ARM (MacBook Air M1)

## Wallpaper Changer

Auto-download and rotate anime wallpapers from Wallhaven every 20 minutes.

### Features

- Fetches high-quality anime wallpapers (2560x1440+) from Wallhaven
- Auto-changes wallpaper every 20 minutes via background daemon
- Manual trigger with `wp` command
- Keeps only last 10 wallpapers (auto-cleanup)

### Setup (Fresh Mac)

```bash
git clone https://github.com/hellogunawan99/macos-arm.git
cd macos-arm
./setup/install.sh
source ~/.zshrc
```

### Usage

```bash
wp              # Random anime wallpaper
wp cyber        # Search for "cyber" wallpaper
wp cars         # Search for "cars" wallpaper
wp anime girl   # Search for anime girl wallpaper
wp --help       # Show help
```

Wallpapers stored in `~/Pictures/wallpapers/`

### Uninstall

```bash
./setup/uninstall.sh
```
