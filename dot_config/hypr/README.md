# Hyprland Configuration

Modular Hyprland configuration for Wayland with support for multiple device types (desktop/laptop) using chezmoi templates.

## Overview

This setup features:
- **Modular configuration** - Separated by functionality for easy maintenance
- **Template-based** - Device-specific configs using chezmoi templates
- **Nord-inspired colors** - Matching the system theme
- **Dual monitor support** - Optimized for both desktop and laptop setups
- **Custom animations** - "Diablo-1" animation preset
- **Quickshell integration** - Custom status bar with rounded borders

## Structure

```
hypr/
├── hyprland.conf.tmpl          # Main config (template)
├── hyprpaper.conf.tmpl         # Wallpaper config (template)
└── modules/
    ├── env.conf                # Environment variables & programs
    ├── general.conf            # Appearance, animations, layouts
    ├── input.conf              # Keyboard, mouse, gestures
    ├── keybinds.conf           # All keybindings
    ├── monitors-desktop.conf   # Desktop monitor setup
    ├── monitors-laptop.conf    # Laptop monitor setup
    ├── quickshell.conf         # Status bar integration
    └── startup.conf            # Autostart applications
```

## Features

### Visual Appearance
- **No gaps** between windows (except for status bar)
- **No rounding** on corners (minimal aesthetic)
- **Nord color scheme** borders:
  - Active: `#88c0d0` (Nord frost blue)
  - Inactive: `#3b4252` (Nord dark gray)
- **Blur effects** on transparent windows
- **Shadow effects** with Nord dark background

### Animations
Custom "Diablo-1" animation preset with:
- Snappy window transitions
- Smooth workspace switching
- Bouncy layer animations
- Slide effects for windows

### Input Configuration
- **Keyboard layouts**: US + LATAM with Alt+Shift toggle
- **Caps Lock**: Remapped to Escape
- **Mouse**: Flat acceleration profile
- **Gestures**: 3-finger horizontal swipe for workspace switching
- **Numlock**: Enabled by default

### Device-Specific Configuration

The configuration adapts based on the `machinename` variable set in chezmoi:

#### Desktop Setup
- **Primary monitor**: DP-1 (1920x1080@144Hz)
- **Secondary monitor**: HDMI-A-1 (1920x1080@60Hz)
- **Workspaces 1-5**: Primary monitor
- **Workspaces 6-10**: Secondary monitor
- **Wallpapers**: Different wallpaper per monitor

#### Laptop Setup
- **Built-in display**: eDP-1 (1920x1080@60Hz)
- **External display**: HDMI-A-1 (1920x1080@60Hz) - optional
- **Workspaces 1-10**: Built-in display
- **Wallpapers**: Single wallpaper

## Keybindings

**Modifier key**: `SUPER` (Windows key)

For complete keybinding reference, see below.

### Applications

| Key | Action |
|-----|--------|
| `SUPER + Return` | Launch terminal (Kitty) |
| `SUPER + SUPER_L` | Open application menu (Rofi) |
| `SUPER + B` | Launch browser (Brave) |
| `SUPER + E` | Open file manager (Thunar) |
| `SUPER + O` | Launch Notion |
| `SUPER + .` | Open emoji picker (Emote) |

### Window Management

| Key | Action |
|-----|--------|
| `SUPER + Q` | Close active window |
| `SUPER + V` | Toggle floating mode |
| `SUPER + M` | Toggle fullscreen |
| `SUPER + P` | Pseudo-tiling (dwindle) |
| `SUPER + H/J/K/L` | Move focus (Vim keys) |
| `SUPER + Arrow keys` | Move focus (arrows) |
| `SUPER + LMB drag` | Move window |
| `SUPER + RMB drag` | Resize window |

### Workspaces

| Key | Action |
|-----|--------|
| `SUPER + [1-9,0]` | Switch to workspace 1-10 |
| `SUPER + SHIFT + [1-9,0]` | Move window to workspace 1-10 |
| `SUPER + Mouse wheel` | Cycle through workspaces |

### System Controls

| Key | Action |
|-----|--------|
| `SUPER + SHIFT + M` | Exit Hyprland |
| `SUPER + SHIFT + S` | Screenshot selection (to clipboard) |
| `XF86AudioRaiseVolume` | Volume up 5% |
| `XF86AudioLowerVolume` | Volume down 5% |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioPlay` | Play/pause media |
| `XF86AudioNext` | Next track |
| `XF86AudioPrev` | Previous track |
| `XF86MonBrightnessUp` | Increase brightness 10% |
| `XF86MonBrightnessDown` | Decrease brightness 10% |

## Programs

Default applications configured in [modules/env.conf](modules/env.conf):

- **Terminal**: Kitty
- **Browser**: Brave
- **File Manager**: Thunar
- **Application Launcher**: Rofi
- **Cursor Theme**: Bibata-Modern-Classic
- **GTK Theme**: Adwaita:dark

## Dependencies

### Required
```bash
sudo pacman -S hyprland kitty rofi-wayland
```

### Recommended
```bash
# Wallpaper and idle management
sudo pacman -S hyprpaper
yay -S hypridle

# Status bar (custom)
yay -S quickshell-git

# Screenshots and clipboard
sudo pacman -S grim slurp wl-clipboard

# Media control
sudo pacman -S playerctl wireplumber

# Brightness control (laptops)
sudo pacman -S brightnessctl

# Utilities
sudo pacman -S thunar brave-bin
yay -S emote notion-app-enhanced
```

### Optional
```bash
# Credential management
sudo pacman -S gnome-keyring

# File synchronization
sudo pacman -S syncthing

# QT theme integration
sudo pacman -S qt6ct
```

## Startup Applications

The following applications start automatically ([modules/startup.conf](modules/startup.conf)):

- **Hypridle** - Idle management
- **Quickshell** - Status bar
- **Hyprpaper** - Wallpaper daemon
- **Syncthing** - File synchronization
- **GNOME Keyring** - Credential storage
- **GTK/Cursor themes** - Applied via gsettings

## Customization

### Changing Monitor Configuration

Edit the appropriate monitor file based on your device type:

**Desktop**: [modules/monitors-desktop.conf](modules/monitors-desktop.conf)
```properties
monitor = DP-1,1920x1080@144,0x0,1
monitor = HDMI-A-1,1920x1080@60,-1920x0,1
```

**Laptop**: [modules/monitors-laptop.conf](modules/monitors-laptop.conf)
```properties
monitor = eDP-1,1920x1080@60,-1920x0,1
```

Use `hyprctl monitors` to list available monitors and their properties.

### Changing Keybindings

All keybindings are in [modules/keybinds.conf](modules/keybinds.conf):

```properties
# Add a new keybinding
bind = $mainMod, KEY, action, parameters

# Examples:
bind = $mainMod, T, exec, firefox
bind = $mainMod SHIFT, F, togglefloating,
```

### Adding Startup Applications

Edit [modules/startup.conf](modules/startup.conf):

```properties
# Add any program to autostart
exec-once = your-program
```

### Customizing Appearance

Edit [modules/general.conf](modules/general.conf):

**Borders**:
```properties
general {
    border_size = 2
    col.active_border = rgba(88c0d0ff)
    col.inactive_border = rgba(3b4252ff)
}
```

**Gaps** (if you want spacing):
```properties
general {
    gaps_in = 5
    gaps_out = 10
}
```

**Rounding**:
```properties
decoration {
    rounding = 10
}
```

### Changing Wallpapers

1. Place your wallpapers in `~/NyxWallpapers/wallpapers/`
2. Edit [hyprpaper.conf.tmpl](hyprpaper.conf.tmpl):
   ```properties
   preload = ~/path/to/your/wallpaper.jpg
   wallpaper = MONITOR-NAME,~/path/to/your/wallpaper.jpg
   ```

## Troubleshooting

### Check Hyprland version
```bash
hyprctl version
```

### Reload configuration
```bash
hyprctl reload
```

### View active configuration
```bash
hyprctl getoption general
hyprctl getoption decoration
```

### List monitors
```bash
hyprctl monitors
```

### Check for errors
```bash
# View Hyprland logs
cat ~/.cache/hyprland/hyprland.log

# Or run from terminal to see live output
Hyprland
```

### Test keybindings
```bash
# List all active binds
hyprctl binds
```

## Tips

- Use `SUPER + LMB` to drag floating windows
- Use `SUPER + RMB` to resize floating windows
- Three-finger swipe horizontally to switch workspaces
- Screenshot selection with `SUPER + SHIFT + S` copies directly to clipboard
- Workspaces are persistent per monitor (desktop setup)

## Related Configurations

- **Status Bar**: [Quickshell configuration](../quickshell/README.md)
- **Terminal**: [Kitty configuration](../kitty/kitty.conf)
- **Application Launcher**: [Rofi configuration](../rofi/config.rasi)

## License

Part of the [Nyx dotfiles](../../README.md) project. Open source under MIT License.
