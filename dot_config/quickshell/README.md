<div align="center">

# Quickshell Configuration

**Modern QML-based status bar for Hyprland**

</div>

A minimalist and dynamic Quickshell configuration featuring workspace management, theme integration, and multi-monitor support.

## ✨ Features

- **🎨 Dynamic Theming** - Automatic light/dark mode with IPC-based color updates
- **📊 Workspace Indicators** - Visual status with color-coded dots (active/occupied/empty)
- **🖥️ Multi-Monitor** - Independent workspace configuration per monitor
- **⌨️ Keyboard Layout** - Real-time active layout display
- **🪟 Window Title** - Shows active window in the bar
- **🎭 Smooth Animations** - Color transitions and state changes
- **🔄 Template-Based** - Machine-specific configs via chezmoi

## 📸 Preview

**Bar Layout:**
```
┌─────────────────────────────────────────────────────────────┐
│ ● ● ● ● ●          Active Window Title              [US]   │
└─────────────────────────────────────────────────────────────┘
  Workspaces           Center                        Keyboard
```

**Color States:**
- 🟢 **Green (primary)** - Active workspace
- 🟡 **Occupied** - Workspace with windows
- ⚫ **Empty** - Unused workspace

---

## 📁 Project Structure

```
quickshell/
├── shell.qml                 # Main entry point
├── core/
│   ├── Appearance.qml        # Color and style management
│   └── Config.qml.tmpl       # Machine-specific configuration
├── components/
│   ├── Bar.qml               # Main bar component
│   ├── WorkspacesWidget.qml  # Workspaces widget
│   ├── WorkspaceDot.qml      # Individual workspace indicator
│   └── ClockWidget.qml       # Date/time display
└── services/
    ├── ThemeService.qml      # Dynamic theme service
    ├── KeyboardService.qml   # Keyboard layout service
    ├── WorkspaceService.qml  # Workspace logic
    └── DateTime.qml          # Date/time service
```

---

## 🎨 Components

<details>
<summary><b>Bar (Bar.qml)</b></summary>

<br>

**Layout:**
- **Left**: Workspace dots
- **Center**: Active window title
- **Right**: Keyboard layout indicator

**Specifications:**
- Height: 35px
- Position: Top of screen
- Adaptive background based on theme
- One bar per monitor

</details>

<details>
<summary><b>WorkspacesWidget</b></summary>

<br>

Displays workspaces assigned to each monitor with visual indicators:

| State | Color | Description |
|-------|-------|-------------|
| Active | Primary (green) | Currently focused workspace |
| Occupied | Occupied color (yellow) | Has windows but not focused |
| Empty | Unused color (gray) | No windows |

**Interaction:**
- Click on dot to switch to that workspace
- Automatic updates when workspace state changes

</details>

<details>
<summary><b>ThemeService</b></summary>

<br>

**Features:**
- IPC endpoint for real-time theme updates
- Automatic theme detection from cache
- Color synchronization across all components
- Integration with `nyx-theme` script

**Theme Colors:**
```qml
property color bg: "#191D1C"           // Background
property color fg: "#CCCDBC"           // Foreground/text
property color primary: "#4DAB4E"      // Accent (active)
property color surface: "#313244"      // Surface color
property color occupiedWs: "#A1AF89"   // Occupied workspace
property color unusedWs: "#202824"     // Empty workspace
```

**IPC Usage:**
```bash
# Apply theme via IPC
quickshell ipc call theme applyColors "$(cat ~/.cache/theme/current.json)"
```

</details>

<details>
<summary><b>KeyboardService</b></summary>

<br>

**Features:**
- Real-time keyboard layout detection
- Layout code caching for performance
- Parsing of `/usr/share/X11/xkb/rules/base.lst`
- Automatic updates on layout change

**Supported Layouts:**
- US (English)
- LATAM (Spanish)
- Any layout defined in XKB rules

**Display:**
Shows 2-letter code in bar (e.g., `us`, `es`, `fr`)

</details>

---

## ⚙️ Configuration

<details>
<summary><b>Config.qml.tmpl (Machine-Specific)</b></summary>

<br>

This configuration uses [chezmoi](https://www.chezmoi.io/) templates to automatically adapt to different machines:

```qml
{{- if eq .machinename "cnyx" }}
property bool isLaptop: false
property string primaryMonitor: "DP-1"
{{- else}}
property bool isLaptop: true
property string primaryMonitor: "eDP-1"
{{- end }}
```

**Configuration Variables:**

| Variable | Type | Description |
|----------|------|-------------|
| `isLaptop` | bool | If true, all workspaces on one monitor; if false, split across monitors |
| `primaryMonitor` | string | Name of primary monitor (workspaces 1-5) |

**Desktop Setup (cnyx):**
- Primary monitor: `DP-1` (workspaces 1-5)
- Secondary monitor: `HDMI-A-1` (workspaces 6-10)

**Laptop Setup (other):**
- Single monitor: `eDP-1` (all workspaces 1-10)

**To customize:**
1. Edit `Config.qml.tmpl` in chezmoi source
2. Add more machine conditions as needed
3. Apply with `chezmoi apply`

</details>

<details>
<summary><b>Appearance.qml (Styling)</b></summary>

<br>

Customize visual appearance:

```qml
QtObject {
    property int radius: 8          // Border radius
    property int barHeight: 35      // Bar height in pixels
    property int spacing: 8         // Widget spacing
}
```

**Theme Colors:**
Colors are managed by ThemeService and adapt automatically based on light/dark mode.

</details>

---

## 🚀 Installation

<details>
<summary><b>Using Chezmoi (Recommended)</b></summary>

<br>

If using this dotfiles repository with chezmoi:

```bash
# Apply dotfiles
chezmoi apply

# Config.qml.tmpl will automatically generate the appropriate configuration
# Start Quickshell (or it will start automatically via Hyprland autostart)
quickshell
```

</details>

<details>
<summary><b>Manual Installation</b></summary>

<br>

1. Install [Quickshell](https://github.com/outfoxxed/quickshell):
```bash
yay -S quickshell-git
```

2. Copy configuration:
```bash
cp -r quickshell ~/.config/
```

3. Rename template file:
```bash
cd ~/.config/quickshell/core
mv Config.qml.tmpl Config.qml
# Edit Config.qml manually with your preferences
```

4. Start Quickshell:
```bash
quickshell
```

</details>

---

## 🎯 Usage

<details>
<summary><b>Workspace Navigation</b></summary>

<br>

- **Click workspace dot**: Switch to that workspace
- **Color indicators**: See workspace status at a glance
- **Per-monitor workspaces**: Each monitor shows its assigned workspaces

</details>

<details>
<summary><b>Theme Management</b></summary>

<br>

**Automatic:**
Theme updates automatically via systemd timers and login sync.

**Manual:**
```bash
# Toggle theme
nyx-theme toggle

# Apply specific theme
nyx-theme apply dark_green
```

**How it works:**
1. `nyx-theme` saves theme to `~/.cache/theme/current.json`
2. Script calls Quickshell IPC to apply colors
3. ThemeService updates all components in real-time

</details>

<details>
<summary><b>Keyboard Layout</b></summary>

<br>

Layout indicator updates automatically when you switch layouts:

- **Hyprland**: `SUPER + SHIFT` (as configured)
- **Display**: Shows current layout code in bar

</details>

---

## 🔧 Customization

<details>
<summary><b>Add Custom Widgets</b></summary>

<br>

1. Create widget in `components/`:
```qml
// components/MyWidget.qml
import Quickshell

Row {
    Text {
        text: "Hello World"
        color: Appearance.fg
    }
}
```

2. Add to Bar.qml:
```qml
import "./components"

Row {
    WorkspacesWidget { }
    MyWidget { }  // Add here
}
```

</details>

<details>
<summary><b>Adjust Bar Height</b></summary>

<br>

Edit `Appearance.qml`:
```qml
property int barHeight: 40  // Change from 35 to 40
```

Also update Hyprland workspace reservation in `hyprland.conf`:
```conf
monitor = MONITOR,RES,POS,1,reserved,40 0 0 0
```

</details>

<details>
<summary><b>Change Colors</b></summary>

<br>

Colors are defined in theme JSON files (`~/.config/themes/*.json`):

```json
{
  "name": "Dark Green",
  "type": "dark",
  "colors": {
    "bg": "#191D1C",
    "fg": "#CCCDBC",
    "primary": "#4DAB4E",
    "surface": "#313244",
    "occupiedWs": "#A1AF89",
    "unusedWs": "#202824"
  }
}
```

After editing, apply with:
```bash
nyx-theme apply dark_green
```

</details>

<details>
<summary><b>Workspace Distribution</b></summary>

<br>

Edit `WorkspaceService.qml` to change workspace assignment logic:

```qml
// Example: Assign specific workspaces to monitors
function getWorkspacesForMonitor(monitorName) {
    if (monitorName === "DP-1") return [1, 2, 3, 4, 5]
    if (monitorName === "HDMI-A-1") return [6, 7, 8, 9, 10]
    return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
}
```

</details>

---

## 🔍 Troubleshooting

<details>
<summary><b>Quickshell Not Starting</b></summary>

<br>

```bash
# Check if Quickshell is installed
which quickshell

# Try starting manually to see errors
quickshell

# Check Quickshell version
quickshell --version

# View logs
journalctl --user -u quickshell
```

</details>

<details>
<summary><b>Theme Not Applying</b></summary>

<br>

```bash
# Check if theme file exists
cat ~/.cache/theme/current.json

# Test IPC manually
quickshell ipc call theme applyColors "$(cat ~/.cache/theme/current.json)"

# Check ThemeService is registered
quickshell ipc list
```

</details>

<details>
<summary><b>Workspaces Not Showing</b></summary>

<br>

1. Verify Hyprland is running and accessible
2. Check workspace configuration in `Config.qml`
3. Ensure monitor names match your setup:
   ```bash
   hyprctl monitors
   ```
4. Restart Quickshell:
   ```bash
   pkill quickshell && quickshell &
   ```

</details>

<details>
<summary><b>Keyboard Layout Not Updating</b></summary>

<br>

```bash
# Check if XKB rules file exists
ls -la /usr/share/X11/xkb/rules/base.lst

# Verify Hyprland keyboard layout
hyprctl devices

# Check KeyboardService in Quickshell
# (Add debug output to KeyboardService.qml if needed)
```

</details>

<details>
<summary><b>Bar Not Visible</b></summary>

<br>

1. Check bar reservation in Hyprland config:
   ```conf
   monitor = MONITOR,RES,POS,1,reserved,35 0 0 0
   ```

2. Verify Quickshell is running:
   ```bash
   pidof quickshell
   ```

3. Check for overlapping windows:
   ```bash
   hyprctl clients
   ```

</details>

---

## 💡 Tips & Tricks

- **Reload Quickshell**: `pkill quickshell && quickshell &`
- **IPC Testing**: Use `quickshell ipc list` to see available commands
- **Debug Mode**: Run `quickshell` from terminal to see real-time logs
- **Theme Preview**: Test themes instantly with `nyx-theme apply <theme-name>`
- **Multi-Monitor**: Quickshell creates one bar per monitor automatically

---

## 🙏 Credits

This configuration is inspired by and contains code adapted from excellent community work:

- **[@end-4](https://github.com/end-4)** - For the amazing [dots-hyprland](https://github.com/end-4/dots-hyprland) which provided:
  - **KeyboardService.qml** - Based on [HyprlandXkb.qml](https://github.com/end-4/dots-hyprland/blob/main/dots/.config/quickshell/ii/services/HyprlandXkb.qml)
  - General Quickshell architecture and design patterns
  - IPC integration patterns

- **[@caelestia](https://github.com/caelestia-dots)** - For additional inspiration from [caelestia-shell](https://github.com/caelestia-dots/shell):
  - Service patterns and structure
  - Component design approach

Special thanks to the Quickshell and Hyprland communities for their continuous support and excellent tools!

---

## 🔗 Related Configurations

- **[Main Dotfiles](../../README.md)** - Complete dotfiles documentation
- **[Hyprland](../hypr/README.md)** - Compositor configuration
- **[Theme System](../themes/README.md)** - Theme management details
- **[Neovim](../nvim/readme.md)** - Editor configuration

---

<div align="center">

Part of **[Nyx's Dotfiles](../../README.md)**

Open source under MIT License

</div>
