<div align="center">

# Hyprland Configuration

**Modular Wayland compositor setup with multi-device support**

</div>

Personal Hyprland configuration featuring modular design, dynamic theming, and automatic device-specific adjustments via chezmoi templates.

## ✨ Features

- **📦 Modular Design** - Configuration split by functionality for easy maintenance
- **🖥️ Multi-Device Support** - Automatic desktop/laptop configuration via templates
- **🎨 Nord-Inspired Colors** - Cohesive color scheme across borders and UI
- **🔒 Security First** - Integrated idle management and screen locking
- **⚡ Optimized Performance** - 144Hz support on desktop, power-efficient on laptop
- **🎯 Custom Animations** - "Diablo-1" animation preset for snappy feel
- **📱 Quickshell Integration** - Custom QML-based status bar

## 📁 Structure

```
hypr/
├── hyprland.conf.tmpl              # Main config (chezmoi template)
├── hyprpaper.conf.tmpl             # Wallpaper daemon config
├── hypridle.conf                   # Idle management & auto-suspend
├── hyprlock.conf                   # Lock screen configuration
└── modules/
    ├── env.conf                    # Environment variables & default apps
    ├── general.conf                # Gaps, borders, layouts, misc settings
    ├── inputs.conf                 # Keyboard, mouse, touchpad, gestures
    ├── decorations.conf            # Borders, shadows, blur, rounding
    ├── animations.conf             # Animation settings (Diablo-1 preset)
    ├── keybindings.conf            # All keybindings
    ├── windowrules.conf            # Window-specific rules
    ├── autostart.conf              # Startup applications (exec-once)
    ├── monitors-desktop.conf       # Desktop monitor setup
    └── monitors-laptop.conf        # Laptop monitor setup
```

---

## 🎨 Visual Design

<details>
<summary><b>Appearance & Theming</b></summary>

<br>

**Color Scheme (Nord-inspired)**:
- Active border: `#88c0d0` (Frost blue)
- Inactive border: `#3b4252` (Dark gray)
- Background: `#2e3440` (Polar night)

**Layout**:
- No gaps between windows (maximalist space usage)
- No corner rounding (minimal aesthetic)
- 2px borders for clear focus indication
- Top bar reservation for Quickshell (35px)

**Effects**:
- Blur on transparent windows
- Shadows with Nord dark background
- Smooth color transitions

</details>

<details>
<summary><b>Animations</b></summary>

<br>

Custom "Diablo-1" animation preset featuring:

- **Windows**: Slide animations with `popin 80%` effect
- **Workspaces**: Smooth sliding transitions
- **Layers**: Bouncy fade effects
- **Border colors**: Instant transitions (0ms)

All animations tuned for responsiveness without sacrificing smoothness.

</details>

---

## 🖥️ Multi-Device Configuration

The configuration automatically adapts based on your machine name (set in chezmoi):

<details>
<summary><b>Desktop Setup (cnyx)</b></summary>

<br>

**Monitors**:
- Primary: `DP-1` at 1920x1080@144Hz
- Secondary: `HDMI-A-1` at 1920x1080@60Hz

**Workspaces**:
- Workspaces 1-5: Primary monitor
- Workspaces 6-10: Secondary monitor

**Wallpapers**:
- Different wallpaper per monitor
- Primary: `arch-nord.png`
- Secondary: `nord-mountain.png`

</details>

<details>
<summary><b>Laptop Setup (other machines)</b></summary>

<br>

**Monitor**:
- Built-in: `eDP-1` at 1920x1080@60Hz
- External: `HDMI-A-1` (optional)

**Workspaces**:
- All workspaces (1-10) on built-in display

**Wallpapers**:
- Single wallpaper across all monitors
- Default: `arch-nord.png`

**Power Management**:
- Integrated hypridle configuration
- Brightness dimming after 2.5min
- Screen lock after 5min
- Suspend after 15min

</details>

---

## 🔒 Security & Power Management

<details>
<summary><b>Hypridle Configuration</b></summary>

<br>

Automatic power and security management:

| Timeout | Action |
|---------|--------|
| 2.5min | Dim screen to 10% brightness |
| 2.5min | Turn off keyboard backlight |
| 5min | Lock screen (hyprlock) |
| 5.5min | Turn off display (DPMS) |
| 15min | Suspend system |

**Features**:
- Lock before sleep/suspend
- Avoid multiple hyprlock instances
- Display turns on automatically on activity

</details>

<details>
<summary><b>Hyprlock Lock Screen</b></summary>

<br>

Secure and beautiful lock screen:

- Screenshot-based background with blur
- Nord-themed password input field
- Date and time display
- User greeting with current status
- Grace period: 5 seconds
- Ignore empty password attempts

</details>

---

---

## ⌨️ Keybindings

**Modifier**: `SUPER` (Windows/Command key)

<details>
<summary><b>📱 Applications</b></summary>

<br>

| Keybind | Action |
|---------|--------|
| `SUPER + Return` | Launch terminal (Kitty) |
| `SUPER + SUPER_L` | Application launcher (Rofi) |
| `SUPER + B` | Browser (Brave) |
| `SUPER + E` | File manager (Thunar) |
| `SUPER + O` | Notion |
| `SUPER + .` | Emoji picker (Emote) |

</details>

<details>
<summary><b>🪟 Window Management</b></summary>

<br>

| Keybind | Action |
|---------|--------|
| `SUPER + Q` | Close active window |
| `SUPER + V` | Toggle floating mode |
| `SUPER + M` | Toggle fullscreen |
| `SUPER + P` | Pseudo-tiling (dwindle) |
| `SUPER + H/J/K/L` | Move focus (Vim keys) |
| `SUPER + Arrow Keys` | Move focus (arrows) |
| `SUPER + LMB` (drag) | Move window |
| `SUPER + RMB` (drag) | Resize window |

</details>

<details>
<summary><b>🖥️ Workspaces</b></summary>

<br>

| Keybind | Action |
|---------|--------|
| `SUPER + [1-9,0]` | Switch to workspace 1-10 |
| `SUPER + SHIFT + [1-9,0]` | Move window to workspace 1-10 |
| `SUPER + Mouse Wheel` | Cycle through workspaces |

</details>

<details>
<summary><b>🎮 System Controls</b></summary>

<br>

| Keybind | Action |
|---------|--------|
| `SUPER + SHIFT + M` | Exit Hyprland |
| `SUPER + SHIFT + S` | Screenshot selection → clipboard |

**Media Keys**:
- `XF86AudioRaiseVolume` - Volume up 5%
- `XF86AudioLowerVolume` - Volume down 5%
- `XF86AudioMute` - Toggle mute
- `XF86AudioPlay` - Play/pause
- `XF86AudioNext` - Next track
- `XF86AudioPrev` - Previous track

**Brightness** (Laptop):
- `XF86MonBrightnessUp` - Increase 10%
- `XF86MonBrightnessDown` - Decrease 10%

</details>

---

## 🎯 Window Rules

Automatic workspace assignment for common applications:

| Application | Workspace |
|-------------|-----------|
| Brave | 2 |
| Visual Studio Code | 3 |
| Obsidian | 4 |
| Thunar | 4 |
| Discord | 5 |
| Telegram | 5 |

> Configure in [modules/windowrules.conf](modules/windowrules.conf)

---

## 🔧 Configuration

<details>
<summary><b>Input Devices</b></summary>

<br>

**Keyboard**:
- Layouts: US + LATAM (Spanish)
- Switch: `Alt + Shift`
- Caps Lock → Escape
- Numlock enabled by default

**Mouse**:
- Acceleration: Flat profile
- Natural scroll: Disabled

**Touchpad**:
- Natural scroll: Enabled
- Tap-to-click: Enabled
- Drag lock: Disabled

**Gestures**:
- 3-finger horizontal swipe: Switch workspace

</details>

<details>
<summary><b>Default Applications</b></summary>

<br>

Configured in [modules/env.conf](modules/env.conf):

| Type | Application |
|------|-------------|
| Terminal | Kitty |
| Browser | Brave |
| File Manager | Thunar |
| Launcher | Rofi |
| Cursor Theme | Bibata-Modern-Classic |
| GTK Theme | Adwaita:dark |

</details>

<details>
<summary><b>Startup Applications</b></summary>

<br>

Auto-started on login ([modules/autostart.conf](modules/autostart.conf)):

- **Hypridle** - Idle & power management
- **Quickshell** - Status bar
- **Hyprpaper** - Wallpaper daemon
- **Syncthing** - File synchronization
- **GNOME Keyring** - Credential storage
- **GTK/Cursor themes** - Applied via gsettings

</details>

---

## 📦 Dependencies

<details>
<summary><b>Required Packages</b></summary>

<br>

```bash
sudo pacman -S hyprland kitty rofi-wayland
```

</details>

<details>
<summary><b>Recommended Packages</b></summary>

<br>

**Core functionality**:
```bash
# Wallpaper, idle, and lock management
sudo pacman -S hyprpaper
yay -S hypridle hyprlock

# Status bar
yay -S quickshell-git

# Screenshots and clipboard
sudo pacman -S grim slurp wl-clipboard

# Media and brightness control
sudo pacman -S playerctl wireplumber brightnessctl
```

**Applications**:
```bash
sudo pacman -S thunar
yay -S brave-bin emote notion-app-enhanced
```

</details>

<details>
<summary><b>Optional Packages</b></summary>

<br>

```bash
# Credential management
sudo pacman -S gnome-keyring

# File synchronization
sudo pacman -S syncthing

# QT theme integration
sudo pacman -S qt6ct
```

</details>

---

## 🎨 Customization

<details>
<summary><b>Monitors</b></summary>

<br>

**Desktop**: [modules/monitors-desktop.conf](modules/monitors-desktop.conf)
```properties
monitor = DP-1,1920x1080@144,0x0,1
monitor = HDMI-A-1,1920x1080@60,-1920x0,1
```

**Laptop**: [modules/monitors-laptop.conf](modules/monitors-laptop.conf)
```properties
monitor = eDP-1,1920x1080@60,0x0,1
```

**List your monitors**:
```bash
hyprctl monitors
```

</details>

<details>
<summary><b>Appearance</b></summary>

<br>

Edit [modules/decorations.conf](modules/decorations.conf) and [modules/general.conf](modules/general.conf):

**Borders**:
```properties
general {
    border_size = 2
    col.active_border = $active_border
    col.inactive_border = $inactive_border
}
```

**Gaps** (if desired):
```properties
general {
    gaps_in = 5
    gaps_out = 10
}
```

**Corner rounding**:
```properties
decoration {
    rounding = 10
}
```

</details>

<details>
<summary><b>Keybindings</b></summary>

<br>

All keybindings in [modules/keybindings.conf](modules/keybindings.conf):

```properties
# Add custom keybinding
bind = $mainMod, KEY, action, parameters

# Examples:
bind = $mainMod, T, exec, firefox
bind = $mainMod SHIFT, F, togglefloating,
```

</details>

<details>
<summary><b>Wallpapers</b></summary>

<br>

1. Place wallpapers in `~/NyxWallpapers/wallpapers/`
2. Edit [hyprpaper.conf.tmpl](hyprpaper.conf.tmpl):
   ```properties
   preload = ~/NyxWallpapers/wallpapers/your-wallpaper.png
   wallpaper = MONITOR,~/NyxWallpapers/wallpapers/your-wallpaper.png
   ```
3. Apply changes:
   ```bash
   chezmoi apply
   pkill hyprpaper && hyprpaper &
   ```

</details>

<details>
<summary><b>Autostart Apps</b></summary>

<br>

Edit [modules/autostart.conf](modules/autostart.conf):

```properties
exec-once = your-application
```

Reload Hyprland to apply:
```bash
hyprctl reload
```

</details>

<details>
<summary><b>Window Rules</b></summary>

<br>

Edit [modules/windowrules.conf](modules/windowrules.conf):

```properties
# Assign to workspace
windowrule = workspace NUMBER, match:title .*AppName.*

# Make floating
windowrule = float, ^(app-id)$

# Set opacity
windowrule = opacity 0.9, ^(app-id)$
```

</details>

<details>
<summary><b>Input Devices</b></summary>

<br>

Edit [modules/inputs.conf](modules/inputs.conf):

```properties
input {
    kb_layout = us,latam
    kb_options = caps:escape,grp:alt_shift_toggle
    sensitivity = 0
    accel_profile = flat
}
```

</details>

<details>
<summary><b>Animations</b></summary>

<br>

Edit [modules/animations.conf](modules/animations.conf):

```properties
animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
}
```

</details>

---

## 🔍 Troubleshooting

<details>
<summary><b>Common Commands</b></summary>

<br>

```bash
# Check Hyprland version
hyprctl version

# Reload configuration
hyprctl reload

# List active monitors
hyprctl monitors

# List active keybindings
hyprctl binds

# View current settings
hyprctl getoption general
hyprctl getoption decoration

# Check Hyprland logs
cat ~/.cache/hyprland/hyprland.log

# Run Hyprland with debug output
Hyprland
```

</details>

<details>
<summary><b>Lock Screen Not Working</b></summary>

<br>

1. Check if hyprlock is installed:
   ```bash
   which hyprlock
   ```

2. Test hyprlock manually:
   ```bash
   hyprlock
   ```

3. Check hypridle status:
   ```bash
   pidof hypridle
   ```

4. Restart hypridle:
   ```bash
   pkill hypridle && hypridle &
   ```

</details>

<details>
<summary><b>Monitor Not Detected</b></summary>

<br>

1. List available outputs:
   ```bash
   hyprctl monitors all
   ```

2. Check if cable is properly connected
3. Update monitor configuration in appropriate module
4. Reload Hyprland:
   ```bash
   hyprctl reload
   ```

</details>

<details>
<summary><b>Wallpaper Issues</b></summary>

<br>

1. Check if hyprpaper is running:
   ```bash
   pidof hyprpaper
   ```

2. Check hyprpaper logs:
   ```bash
   pkill hyprpaper
   hyprpaper  # Run in foreground to see errors
   ```

3. Verify wallpaper paths in `hyprpaper.conf.tmpl`
4. Restart hyprpaper:
   ```bash
   pkill hyprpaper && hyprpaper &
   ```

</details>

---

## 💡 Tips & Tricks

- **Drag floating windows**: `SUPER + LMB`
- **Resize floating windows**: `SUPER + RMB`
- **Workspace navigation**: 3-finger horizontal swipe (touchpad)
- **Quick screenshot**: `SUPER + SHIFT + S` copies directly to clipboard
- **Persistent workspaces**: Each workspace stays on its assigned monitor
- **Caps Lock as Escape**: Great for Vim users!

---

## 🔗 Related Configurations

- **[Quickshell](../quickshell/README.md)** - Status bar configuration
- **[Kitty](../kitty/kitty.conf)** - Terminal emulator
- **[Rofi](../rofi/config.rasi)** - Application launcher
- **[Main Dotfiles](../../README.md)** - Complete dotfiles documentation

---

<div align="center">

Part of **[Nyx's Dotfiles](../../README.md)**

Open source under MIT License

</div>
