# Nyx's Arch Linux Dotfiles

![Desktop Screen Shot](./DesktopImage.jpeg)

> Wallpaper from this [repo](https://github.com/DenverCoder1/minimalistic-wallpaper-collection).

Personal dotfiles configuration for Arch Linux, managed with [chezmoi](https://www.chezmoi.io/) for reproducible deployment and simplified maintenance across multiple machines.

## Description

This repository contains my system configuration managed as code, enabling:
- **Versioned management** of configuration files
- **Consistent deployment** across different machines (desktop/laptop)
- **Dynamic templates** that adapt based on the device

## What is Chezmoi?

Chezmoi is a dotfiles manager that allows you to:
- Use templates for machine-specific configurations
- Apply changes safely with preview
- Manage files in their correct system locations
- Handle secrets and private configurations

### Naming Conventions

Chezmoi uses special prefixes in file names:

- `dot_` → converts to `.` (hidden files)
  - Example: `dot_zshrc` → `~/.zshrc`
- `dot_config/` → `~/.config/`
- `.tmpl` → template file that gets processed
  - Example: `hyprland.conf.tmpl` → `hyprland.conf`

## Repository Structure

```
.
├── dot_zshrc                          # ~/.zshrc - Zsh configuration
├── dot_config/
│   ├── hypr/                          # Modular Hyprland configuration
│   │   ├── hyprland.conf.tmpl         # Main file with templates
│   │   ├── hyprpaper.conf.tmpl        # Wallpaper configuration
│   │   └── modules/                   # Modules separated by functionality
│   │       ├── env.conf               # Environment variables
│   │       └── ...                    # Other files
│   ├── kitty/                         # Kitty terminal
│   │   └── kitty.conf
│   ├── nvim/                          # Neovim editor (see separate README)
│   │   ├── init.lua
│   │   ├── lua/
│   │   └── readme.md
│   ├── quickshell/                    # Custom status bar (see separate README)
│   │   ├── Config.qml
│   │   ├── shell.qml
│   │   ├── modules/
│   │   └── README.md
│   └── rofi/                          # Application launcher
│       └── config.rasi
└── NyxWallpapers/                     # Wallpaper collection
    └── README.md
```

## Configured Applications

This dotfile manages the configuration for:

- **Hyprland** - Wayland compositor ([see README](dot_config/hypr/README.md))
- **Neovim** - Text editor ([see README](dot_config/nvim/readme.md))
- **Quickshell** - Status bar ([see README](dot_config/quickshell/README.md))
- **Kitty** - Terminal emulator
- **Zsh** - Shell with Powerlevel10k, Zinit, and plugins
- **Rofi** - Application launcher

> **Note**: Applications marked have their own README with detailed documentation.

## Usage

### Managing Your Dotfiles

#### View Current Status
```bash
# See which files chezmoi manages
chezmoi managed

# Check for differences between repository and system
chezmoi diff
```

#### Making Changes

**Recommended Method: Edit source files directly**
```bash
# Navigate to chezmoi's source directory
chezmoi cd

# Edit your files with your preferred editor
nvim dot_zshrc
# or
nvim dot_config/hypr/hyprland.conf.tmpl

# Apply changes to the system
chezmoi apply

# Commit and push to repository
git add .
git commit -m "Update configuration"
git push
```

**Alternative: Quick edit with chezmoi edit**
```bash
# Edit the source file in chezmoi's directory
chezmoi edit ~/.zshrc

# Apply changes to the system
chezmoi apply
```

#### Update from Repository
```bash
# Pull latest changes from repository
chezmoi update

# Or manually:
cd ~/.local/share/chezmoi
git pull
chezmoi apply
```

#### Adding New Files
```bash
# Add a new file to chezmoi management
chezmoi add ~/.config/some-app/config.conf

# This creates the file in ~/.local/share/chezmoi with appropriate naming
```

### Templates and Machine-Specific Configuration

The dotfiles use chezmoi templates to handle differences between machines:

**Example from [dot_config/hypr/hyprland.conf.tmpl](dot_config/hypr/hyprland.conf.tmpl)**:
```conf
{{- if eq .chassis "desktop" }}
source = ~/.config/hypr/modules/monitors-desktop.conf
{{- else if eq .chassis "laptop"}}
source = ~/.config/hypr/modules/monitors-laptop.conf
{{- else }}
monitor = ,auto,auto,1
{{- end }}
```

This allows the same source to generate different configurations based on the device type.

### Syncing Across Machines

1. **On the first machine**:
   ```bash
   cd ~/.local/share/chezmoi
   git add .
   git commit -m "Update configurations"
   git push
   ```

2. **On the second machine**:
   ```bash
   chezmoi update
   ```

Chezmoi will automatically handle machine-specific differences through templates.

## Project Structure

- **Modular configuration**: Large configs (Hyprland, Neovim) are split into logical modules
- **Template-based**: Uses `.tmpl` files for machine-specific configurations
- **Documentation**: Each major application has its own README
- **Version controlled**: All changes tracked with Git

## Contributing

This is a personal dotfiles repository, but contributions are welcome!

If you find issues or have suggestions:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).

You are free to use, modify, and distribute these configurations. Attribution is appreciated but not required.

---

**Note**: This configuration is tailored to my personal workflow. You may need to adjust:
- Hardware-specific settings (monitor configurations, input devices)
- Application preferences
- Paths and usernames