<div align="center">

# Noctalia Theme System

**Theme data and runtime behavior for the Noctalia desktop shell**

</div>

This directory contains the theme definitions used by Noctalia and the `nyx-theme` script.

## ✨ Features

- **🎨 Per-Theme Variants** - Each theme provides both dark and light palettes in the same JSON file
- **🔄 Mode Switching** - `toggle` flips between dark and light for the current theme
- **⌚ Time-Based Sync** - `sync` selects the mode according to the time of day
- **🧩 Desktop Integration** - Colors are applied to Noctalia, Hyprland, GTK, and related shell components

## 📁 Structure

Each theme lives in its own folder under `colorschemes/`.

Example:

```text
~/.config/noctalia/colorschemes/
└── Green/
    └── Green.json
```

Inside each theme file, the palette is split into two top-level sections:

- `dark`
- `light`

Both sections should provide the same color keys so the runtime can switch modes without changing the theme name.

## 🎯 How It Works

The current setup treats theme and mode as separate pieces of state:

**Theme selection:**
- `nyx-theme apply <theme>` changes the active theme and keeps the current mode

**Mode control:**
- `nyx-theme toggle` switches between dark and light for the current theme
- `nyx-theme sync` sets the mode based on the current time

That means you only need one theme name per palette, instead of maintaining separate dark and light theme files.

## 📜 nyx-theme Command

### `nyx-theme apply <theme>`
Apply a specific theme while preserving the current mode.

**Usage:**
```bash
nyx-theme apply Green
```

### `nyx-theme toggle`
Toggle between dark and light for the active theme.

**Usage:**
```bash
nyx-theme toggle
```

### `nyx-theme sync`
Set the current mode according to the time of day.

**Usage:**
```bash
nyx-theme sync
```

**Schedule:**
- **06:00 - 19:29**: Light mode
- **19:30 - 05:59**: Dark mode

## ⏰ Automatic Switching

### Using Systemd Timer

The theme sync can run automatically through the user timer:

```bash
systemctl --user enable --now theme.timer
```

This keeps the mode aligned with the schedule and also lets Hyprland synchronize on login through `autostart.conf`.

## 📦 Runtime Files

The theme command stores its runtime state in the cache directory:

```text
~/.cache/theme/
├── status.json
└── hyprland_colors.conf
```

- `status.json` stores the current theme and mode
- `hyprland_colors.conf` contains the generated Hyprland border colors

## 🎨 Adding Themes

To add a new theme, create a folder under `colorschemes/` and place a JSON file inside it with the same name.

Example:

```text
~/.config/noctalia/colorschemes/
└── MyTheme/
    └── MyTheme.json
```

The file should include both `dark` and `light` sections with the color keys expected by `nyx-theme`.

## 🔧 Troubleshooting

**Theme not applying:**
```bash
ls ~/.config/noctalia/colorschemes/
nyx-theme apply Green
cat ~/.cache/theme/status.json
```

**Timer not running:**
```bash
systemctl --user status theme.timer
journalctl --user -u theme.service
```

**Login sync not working:**
```bash
grep "nyx-theme sync" ~/.config/hypr/modules/autostart.conf
```
