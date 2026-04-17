# macos-arm

Scripts and configs for macOS ARM (MacBook Air M1)

## Wallpaper Changer

Auto-download and rotate anime wallpapers from Wallhaven every 20 minutes.

### Features

- Fetches high-quality anime wallpapers (2560x1440+) from Wallhaven
- Auto-changes wallpaper every 20 minutes via background daemon
- Manual trigger with `wp` command
- Keeps only last 10 wallpapers (auto-cleanup)

### Setup

```bash
# Add to PATH (add to ~/.zshrc)
export PATH="$HOME/dev/macos-arm/wallpaper-changer:$PATH"

# Start daemon
nohup /Users/gunawan/dev/macos-arm/wallpaper-changer/wp-daemon > /tmp/wp-daemon.log 2>&1 &
```

### Usage

```bash
wp              # Random anime wallpaper
wp cyber        # Search for "cyber" wallpaper
wp cars         # Search for "cars" wallpaper
wp anime girl   # Search for anime girl wallpaper
```

Wallpapers stored in `~/Pictures/wallpapers/`
