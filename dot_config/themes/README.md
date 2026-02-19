# Theme Management System

Automated theme switching system for Hyprland, Quickshell, and GTK applications.

## 🎨 Available Themes

- **dark_green** - Dark theme with green accents
- **light_green** - Light theme with green accents

Themes are stored in `~/.config/themes/` as JSON files.

## 📜 nyx-theme Command

Unified theme management script with three subcommands:

### `nyx-theme apply <theme-name>`
Apply a specific theme by name.

**Usage:**
```bash
nyx-theme apply dark_green
nyx-theme apply light_green
```

**What it does:**
- Applies colors to Quickshell via IPC
- Generates Hyprland color configuration
- Sets GTK theme (Adwaita/Adwaita-dark)
- Sets color-scheme preference (dark/light)
- Shows notification

### `nyx-theme toggle`
Toggle between dark and light themes.

**Usage:**
```bash
nyx-theme toggle
```

**Keybinding:** `SUPER + T`

**What it does:**
- Reads current theme type from cache
- Switches to the opposite (dark ↔ light)

### `nyx-theme sync`
Sync theme based on current time.

**Usage:**
```bash
nyx-theme sync
```

**Schedule:**
- **06:00 - 20:29**: Light theme (`light_green`)
- **20:30 - 05:59**: Dark theme (`dark_green`)

**Auto-runs:**
- At Hyprland startup (via `autostart.conf`)

## ⏰ Automatic Theme Switching

### Using Systemd Timers (Recommended)

Enable automatic theme switching based on time of day:

```bash
# Enable and start timers
systemctl --user enable --now theme-light.timer
systemctl --user enable --now theme-dark.timer

# Check timer status
systemctl --user list-timers
```

**Schedule:**
- Light theme: Every day at **06:00**
- Dark theme: Every day at **20:30**

### Login Sync

The `nyx-theme sync` command runs automatically when Hyprland starts (via `autostart.conf`) to ensure the correct theme is applied based on the current time. This prevents stale themes when:
- The PC was shut down and restarted at a different time
- You log out and log back in
- Systemd timers didn't run while the system was off

## 📁 Files

```
~/.config/themes/           # Theme definitions
├── dark_green.json
└── light_green.json

~/.config/systemd/user/     # Systemd timers for scheduled theme switching
├── theme-dark.service
├── theme-dark.timer
├── theme-light.service
└── theme-light.timer

~/.local/bin/               # Theme management
└── nyx-theme               # Unified theme command (apply|toggle|sync)

~/.cache/theme/             # Runtime cache
├── current.json            # Currently active theme
└── hyprland_colors.conf    # Generated Hyprland colors
```

## 🎨 Creating Custom Themes

Create a new JSON file in `~/.config/themes/`:

```json
{
  "name": "My Theme",
  "type": "dark",
  "colors": {
    "bg": "#191D1C",
    "fg": "#CCCDBC",
    "primary": "#4DAB4E",
    "surface": "#313244",
    "occupiedWs": "#A1AF89",
    "unusedWs": "#202824",
    "active_border": "#4DAB4E",
    "inactive_border": "#202824",
    "shadow": "#111312"
  }
}
```

**Required fields:**
- `type`: `"dark"` or `"light"` (determines GTK theme)
- `colors.active_border`: Hyprland active window border
- `colors.inactive_border`: Hyprland inactive window border
- `colors.shadow`: Hyprland shadow color
- Other colors are used by Quickshell

Apply your theme:
```bash
nyx-theme apply my-theme
```

## 🔧 Troubleshooting

**Theme not applying:**
```bash
# Check if theme file exists
ls ~/.config/themes/

# Test theme manually
nyx-theme apply dark_green

# Check Quickshell is running
pidof quickshell

# Check Hyprland colors generated
cat ~/.cache/theme/hyprland_colors.conf
```

**Timers not working:**
```bash
# Check timer status
systemctl --user status theme-light.timer
systemctl --user status theme-dark.timer

# View timer logs
journalctl --user -u theme-light.service
journalctl --user -u theme-dark.service

# Restart timers
systemctl --user restart theme-light.timer theme-dark.timer
```

**Wrong theme at login:**
```bash
# Check if nyx-theme sync is in autostart
grep "nyx-theme sync" ~/.config/hypr/modules/autostart.conf

# Run manually to test
nyx-theme sync

# Check Hyprland logs for errors
journalctl --user -u hyprland-session.target
```

## 💡 Tips

- Use `SUPER + T` to quickly toggle between light and dark themes
- Systemd timers persist across reboots (with `Persistent=true`)
- The login sync ensures you always have the correct theme for the time of day
- Themes apply to: Hyprland borders, Quickshell bar, GTK apps, and cursor theme
- Notifications show which theme was applied
