# Hyprland Dotfiles

A modern, cohesive Wayland desktop environment configuration featuring Hyprland window manager with Catppuccin Mocha theming throughout.

## Preview

| Component | Description |
|-----------|-------------|
| WM | Hyprland (master layout) |
| Bar | Waybar |
| Terminal | Kitty |
| Editor | Neovim (Lazy.nvim) |
| Launcher | Wofi |
| Shell | Zsh |
| Theme | Catppuccin Mocha |

## Features

- **Consistent theming** - Catppuccin Mocha across all applications
- **Master layout** - Efficient window management with gaps and rounded corners
- **Smooth animations** - Custom bezier curves for fluid transitions
- **Transparent terminal** - 80% opacity with blur
- **Modern Neovim** - Lazy.nvim, Telescope, Treesitter
- **System monitoring** - CPU, memory, temperature, battery in waybar
- **Media controls** - MPD integration and playerctl support
- **Screenshot tools** - Window and region capture with hyprshot

## Installation

### Quick Start

```bash
git clone https://github.com/yfe404/hyprland-dotfiles.git
cd hyprland-dotfiles
./install.sh
```

### Manual Installation

Symlink each config directory to `~/.config/`:

```bash
ln -sf $(pwd)/hypr ~/.config/hypr
ln -sf $(pwd)/kitty ~/.config/kitty
ln -sf $(pwd)/nvim ~/.config/nvim
ln -sf $(pwd)/waybar ~/.config/waybar
ln -sf $(pwd)/wofi ~/.config/wofi
ln -sf $(pwd)/zsh/.zshrc ~/.zshrc
```

## Dependencies

### Required

| Package | Description |
|---------|-------------|
| `hyprland` | Wayland compositor |
| `waybar` | Status bar |
| `kitty` | Terminal emulator |
| `wofi` | Application launcher |
| `swaync` | Notification daemon |
| `hypridle` | Idle daemon |
| `hyprlock` | Lock screen |
| `hyprpaper` | Wallpaper |
| `hyprshot` | Screenshots |

### Optional

| Package | Description |
|---------|-------------|
| `yazi` | Terminal file manager |
| `fzf` | Fuzzy finder |
| `playerctl` | Media control |
| `brightnessctl` | Brightness control |
| `power-profiles-daemon` | Power management |
| `mpd` | Music player daemon |
| `pass` | Password manager (for transmission scripts) |

### Fonts

- JetBrainsMono Nerd Font (lock screen)
- Caskaydia Cove Nerd Font (terminal)

### Arch Linux

```bash
# Required
paru -S hyprland waybar kitty wofi swaync hypridle hyprlock hyprpaper hyprshot

# Optional
paru -S yazi fzf playerctl brightnessctl power-profiles-daemon mpd

# Fonts
paru -S ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd
```

## Post-Installation

1. **Wallpaper**: Place your wallpaper at `~/.config/backgrounds/shaded.png`
2. **Avatar** (optional): Place your avatar at `~/.face` for the lock screen
3. **Log out** and select Hyprland from your display manager

## Keybindings

### General

| Keys | Action |
|------|--------|
| `Super + Return` | Open terminal |
| `Super + D` | Open app launcher |
| `Super + Q` | Close window |
| `Super + E` | File manager (yazi) |
| `Super + Y` | FreeTube |
| `Super + V` | Toggle floating |
| `Super + F` | Fullscreen |
| `Super + M` | Exit Hyprland |
| `Super + Shift + Q` | Lock screen |

### Layout

| Keys | Action |
|------|--------|
| `Super + J/K` | Cycle windows |
| `Super + H/L` | Resize window |
| `Super + Space` | Swap with master |
| `Super + 1-0` | Switch workspace |
| `Super + Shift + 1-0` | Move to workspace |
| `Super + S` | Toggle scratchpad |

### Media

| Keys | Action |
|------|--------|
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86AudioMute` | Toggle mute |
| `XF86MonBrightnessUp/Down` | Brightness |
| `XF86AudioPlay/Pause` | Play/pause media |
| `XF86AudioNext/Prev` | Next/previous track |

### Screenshots

| Keys | Action |
|------|--------|
| `Print` | Capture window |
| `Shift + Print` | Capture region |

Screenshots are saved to `~/Pictures/screenshots/`.

## Neovim

Leader key: `Space`

| Keys | Action |
|------|--------|
| `Space + ff` | Find files (Telescope) |
| `Space + fg` | Live grep |
| `Space + fb` | Buffers |
| `Space + fh` | Help tags |

## Transmission Scripts

The `bin/` directory contains scripts for remote transmission daemon control.

Set these environment variables:

```bash
export TRANSMISSION_HOST="192.168.1.100:9091"
export TRANSMISSION_USER="your-username"
export TRANSMISSION_PASS_PATH="path/in/pass/store"
```

| Script | Usage |
|--------|-------|
| `tadd` | `tadd <magnet-link>` |
| `tdel` | `tdel <torrent-id>` |
| `tlist` | `tlist` |

## Structure

```
.
├── bin/                  # Utility scripts
├── hypr/
│   ├── hyprland.conf     # Main config
│   ├── hypridle.conf     # Idle timeouts
│   ├── hyprlock.conf     # Lock screen
│   └── hyprpaper.conf    # Wallpaper
├── hyprmocha/
│   └── mocha.conf        # Catppuccin colors
├── kitty/
│   ├── kitty.conf        # Terminal config
│   └── current-theme.conf
├── nvim/
│   └── init.lua          # Neovim config
├── waybar/
│   ├── config.jsonc      # Bar modules
│   └── power_menu.xml    # Power menu
├── wofi/
│   └── style.css         # Launcher styling
├── zsh/
│   └── .zshrc            # Shell config
├── install.sh            # Installation script
└── README.md
```

## Customization

### Colors

The Catppuccin Mocha palette is defined in:
- `hyprmocha/mocha.conf` - Hyprland/hyprlock
- `kitty/current-theme.conf` - Terminal
- `wofi/style.css` - Launcher
- `nvim/init.lua` - Editor (via catppuccin plugin)

### Monitor Configuration

Edit `hypr/hyprland.conf`:

```bash
# Example: laptop with external monitor
monitor=eDP-1,1920x1080@60,0x0,1
monitor=HDMI-A-1,2560x1440@144,1920x0,1
```

### Gaps and Borders

In `hypr/hyprland.conf`:

```bash
general {
    gaps_in = 5
    gaps_out = 20
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
}
```

## License

MIT
