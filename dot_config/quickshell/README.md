# Quickshell Configuration

A modern and minimalist Quickshell configuration for Hyprland, with dynamic theme support and multi-monitor capabilities.

## ✨ Features

- **Minimalist top bar** with essential information
- **Dynamic workspaces** with visual status indicators (active/occupied/empty)
- **Multi-monitor support** with independent workspace configuration
- **Dynamic theming** that automatically adapts between light and dark modes
- **Keyboard layout indicator** showing the active layout
- **Active window title** in the bar
- **Smooth animations** for color transitions and state changes

## 📁 Project Structure

```
quickshell/
├── shell.qml                 # Main entry point
├── core/
│   ├── Appearance.qml        # Color and style management
│   └── Config.qml            # General configuration
├── components/
│   ├── Bar.qml               # Main bar component
│   ├── WorkspacesWidget.qml  # Workspaces widget
│   └── WorkspaceDot.qml      # Individual workspace indicator
└── services/
    ├── ThemeService.qml      # Dynamic theme service
    ├── KeyboardService.qml   # Keyboard layout service
    └── WorkspaceService.qml  # Workspace logic
```

## 🎨 Components

### Bar (Bar.qml)
- **Left section**: Workspaces widget
- **Center section**: Active window title
- **Right section**: Keyboard layout indicator
- Height: 35px
- Adaptive background color based on theme

### WorkspacesWidget
- Displays workspaces assigned to each monitor
- Visual indicators with color coding:
  - 🟢 **Green (primary)**: Active workspace
  - 🟡 **Occupied**: Workspace with windows
  - ⚫ **Empty**: Workspace without windows
- Click to switch workspaces

### ThemeService
- Automatic system theme detection
- Synchronization with `~/.cache/theme-mode`
- IPC support for real-time changes
- Integration with `theme-toggle` script

### KeyboardService
- Automatic active keyboard layout detection
- Layout code caching for performance
- Parsing of `/usr/share/X11/xkb/rules/base.lst`
- Real-time updates when switching layouts

## ⚙️ Configuration

### Config.qml (Chezmoi Template)

This configuration uses [chezmoi](https://www.chezmoi.io/) templates to automatically adapt to different machines. The file `Config.qml.tmpl` generates the appropriate configuration based on your machine name:

```qml
{{- if eq .machinename "cnyx" }}
property bool isLaptop: false
property string primaryMonitor: "DP-1"
{{- else}}
property bool isLaptop: true
property string primaryMonitor: "eDP-1"
{{- end }}
```

**Benefits of using chezmoi templates:**
- **Automatic machine detection**: Different configurations for desktop and laptop without manual editing
- **Single source of truth**: One template file that adapts to all your machines
- **Version control friendly**: Keep machine-specific configs in the same repository

**Configuration variables:**
- `isLaptop`: If `true`, all workspaces (1-10) are on a single monitor; if `false`, workspaces are split between monitors
- `primaryMonitor`: Name of the primary monitor (workspaces 1-5), secondary will have workspaces 6-10

To customize for your machines, edit `Config.qml.tmpl` and adjust the machine name condition or add more machines as needed.

### Appearance.qml
Customize colors and styles:
```qml
property int radius: 8          // Border radius
property int barHeight: 35      // Bar height
```

Adaptive colors (dark/light theme):
- `bg`: Background color
- `fg`: Text color
- `primary`: Accent color (active workspace)
- `surface`: Surface color
- `occupiedWs`: Occupied workspace color
- `unusedWs`: Empty workspace color

## 🚀 Installation

### Using chezmoi (Recommended)

This configuration is designed to work with [chezmoi](https://www.chezmoi.io/) for multi-machine dotfile management:

1. Make sure you have Quickshell and chezmoi installed

2. If you're using this dotfiles repository with chezmoi:
```bash
chezmoi apply
```

3. The `Config.qml.tmpl` template will automatically generate the appropriate configuration for your machine

### Manual Installation

If you prefer not to use chezmoi:

1. Make sure you have [Quickshell](https://github.com/outfoxxed/quickshell) installed

2. Copy this configuration to your config directory:
```bash
cp -r quickshell ~/.config/
```

3. Rename `Config.qml.tmpl` to `Config.qml` and manually edit the values:
```bash
mv ~/.config/quickshell/core/Config.qml.tmpl ~/.config/quickshell/core/Config.qml
# Edit the file to set your preferences
```

### Final Steps

1. (Optional) If using dynamic theming, ensure you have the `theme-toggle` script:
```bash
chmod +x ~/.local/bin/theme-toggle
```

2. Start Quickshell:
```bash
quickshell
```

3. Or configure it to start automatically with Hyprland in `hyprland.conf`:
```conf
exec-once = quickshell
```

## 🎯 Usage

- **Click on workspace dot**: Switch to the corresponding workspace
- Theme will automatically update when switching between light/dark mode
- Keyboard indicator will display the active layout code (e.g., `es`, `us`)

## 📝 Customization

To adapt the configuration to your needs:

1. **Change workspace distribution**: Edit `WorkspaceService.qml`
2. **Modify colors**: Customize `Appearance.qml`
3. **Adjust primary monitor**: Update `Config.qml`
4. **Add widgets**: Create new components in `components/` and include them in `Bar.qml`

## 🙏 Credits

This configuration is inspired by and contains code adapted from [end-4](https://github.com/end-4/dots-hyprland)'s dotfiles, particularly:

- **KeyboardService.qml**: Based on [HyprlandXkb.qml](https://github.com/end-4/dots-hyprland/blob/main/dots/.config/quickshell/ii/services/HyprlandXkb.qml)
- General project structure and design patterns

Additional inspiration was also drawn from [caelestia](https://github.com/caelestia)'s dotfiles.

Special thanks to end-4 and caelestia for sharing their excellent work with the community.

## 📄 License

This project maintains the same license as the original project it's based on.

---

**Note**: This is an actively developed configuration. Feel free to report issues or suggest improvements.
