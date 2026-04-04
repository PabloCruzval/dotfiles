<h1 align="center">Pablo Dotfiles 💽</h1>

<div align="center">

![GitHub last commit](https://img.shields.io/github/last-commit/PabloCruzval/dotfiles?style=for-the-badge&labelColor=1e1e2e&color=89b4fa)
![GitHub repo size](https://img.shields.io/github/repo-size/PabloCruzval/dotfiles?style=for-the-badge&labelColor=1e1e2e&color=a6e3a1)
![License](https://img.shields.io/github/license/PabloCruzval/dotfiles?style=for-the-badge&labelColor=1e1e2e&color=fab387)

</div>

---



https://github.com/user-attachments/assets/adce3f51-be9a-433b-9a28-7132e8fb3eb2



Personal dotfiles for Arch Linux featuring a modern Hyprland setup where [Noctalia Shell](https://noctalia.dev/) defines the visual feel of the desktop, while [chezmoi](https://www.chezmoi.io/) manages the dotfiles for consistent deployment across multiple machines.

## ✨ Features

- **🎨 Dynamic Theming** - Automatic light/dark mode with system-wide color synchronization
- **🖥️ Multi-Monitor Support** - Separate configurations for desktop and laptop setups
- **📦 Modular Configuration** - Clean, organized configs split by functionality
- **🔄 Template-Based** - Machine-specific configs generated automatically via chezmoi
- **⚡ Modern Wayland Stack** - Hyprland compositor with Noctalia Shell as the desktop layer that drives the overall feel
- **🛠️ Developer-Focused** - Neovim with LSP, DAP, and modern plugin ecosystem
- **🔧 One-Command Setup** - Automated installation with backup of existing configs

## 📦 What's Inside

- **[Hyprland](dot_config/hypr/README.md)** - Wayland compositor with modular configuration
- **[Neovim](dot_config/nvim/readme.md)** - Modern IDE setup with LSP, Treesitter, and debugging
- **[Noctalia](https://noctalia.dev/)** - Wayland desktop shell and the component that defines the look, feel, and interaction model of the desktop
- **Kitty** - GPU-accelerated terminal emulator
- **Zsh** - Shell with Powerlevel10k and Zinit plugin manager
- **Rofi** - Application launcher

> 📚 Applications with their own detailed README are linked above.

## 🚀 Quick Start

### One-Line Installation

>[!IMPORTANT]
> Only for Arch Linux. The script was made for my machines and may require adjustments for yours.

>[!NOTE]
> Existing configurations for `hypr`, `noctalia`, `kitty`, `nvim`, or `rofi` will be backed up to `$HOME/.backups_dotfiles/<timestamp>`

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/PabloCruzval/dotfiles/refs/heads/main/setup.sh)"
```

### What the installer does:
1. Installs required packages from `pkglist` and `aurlist`
2. Installs chezmoi if not present
3. Backs up existing configurations
4. Initializes chezmoi with this repository
5. Applies configurations with machine-specific templates

## 📋 Requirements

- **OS**: Arch Linux
- **Display Server**: Wayland
- **Package Managers**: `pacman` and an AUR helper (`yay` or `paru`)
- **Fonts**: Nerd Fonts (installed automatically)
- **Dependencies**: Listed in `pkglist` and `aurlist`

## 📁 Structure

The repository is organized with chezmoi naming conventions:

| What | Where | Description |
|------|-------|-------------|
| **Hyprland** | `dot_config/hypr/` | Modular Wayland compositor config with templates |
| **Neovim** | `dot_config/nvim/` | LSP, DAP, and plugin configurations |
| **Noctalia** | `dot_config/noctalia/` | Desktop shell and UI components |
| **Kitty** | `dot_config/kitty/` | Terminal emulator config |
| **Rofi** | `dot_config/rofi/` | Application launcher |
| **Themes** | `dot_config/noctalia/colorschemes/` | Noctalia theme definitions with dark and light variants |
| **Scripts** | `dot_local/bin/` | Utility scripts (nyx-theme) |

> 💡 **Chezmoi naming**: `dot_` → `.` (hidden files), `.tmpl` → template, `executable_` → executable bit

---

## 🎯 Key Features

Noctalia Shell is the layer that ties the dotfiles together visually: it controls the desktop shell, the accent colors, and the overall pacing of the interface.

<details>
<summary><b>🎨 Dynamic Theming</b></summary>

<br>

Automated Noctalia theme system with per-theme dark and light variants.

**Features:**
- 🌅 **Auto Mode Switch** - Switches the active mode automatically at 6am (light) and 7:30pm (dark)
- 🔄 **Login Sync** - Applies the correct mode at startup
- ⌨️ **Quick Toggle** - `SUPER + T` switches dark/light for the current theme
- 🎯 **Per-Theme Variants** - Each theme provides its own dark and light palette

**Available Themes:**
- `Green` - Theme with both dark and light variants stored in one JSON file

**Usage:**
```bash
nyx-theme apply Green        # Apply the current mode of a theme
nyx-theme toggle             # Toggle dark/light for the current theme
nyx-theme sync               # Sync the current mode based on time of day
```

**Automatic Switching:**
```bash
# Enable the systemd timer for automatic mode changes
systemctl --user enable --now theme.timer
```

> 📖 For detailed documentation, see [Noctalia Theme README](dot_config/noctalia/README.md)

</details>

<details>
<summary><b>🖥️ Multi-Machine Support</b></summary>

<br>

Chezmoi templates automatically adapt configurations based on machine name:

```conf
{{- if eq .machinename "cnyx" }}
source = ~/.config/hypr/modules/monitors-desktop.conf
{{- else}}
source = ~/.config/hypr/modules/monitors-laptop.conf
{{- end }}
```

Same source, different output per machine!

</details>

---

## 🔧 Managing Your Dotfiles

<details>
<summary><b>📝 Making Changes</b></summary>

<br>

**Direct editing (recommended):**
```bash
chezmoi cd                               # Navigate to source
nvim dot_config/hypr/hyprland.conf.tmpl  # Edit files
chezmoi apply                            # Apply changes
git add . && git commit -m "Update"      # Commit
git push                                 # Push
```

**Quick edit:**
```bash
chezmoi edit ~/.config/hypr/hyprland.conf
chezmoi apply
```

</details>

<details>
<summary><b>🔄 Syncing Across Machines</b></summary>

<br>

**Machine A (send changes):**
```bash
cd ~/.local/share/chezmoi
git add . && git commit -m "Update" && git push
```

**Machine B (receive updates):**
```bash
chezmoi update  # Pulls and applies changes
```

</details>

<details>
<summary><b>➕ Adding New Files</b></summary>

<br>

```bash
chezmoi add ~/.config/app/config.conf
# Creates: ~/.local/share/chezmoi/dot_config/app/config.conf
```

</details>

<details>
<summary><b>🔍 Quick Reference</b></summary>

<br>

```bash
chezmoi managed   # List all managed files
chezmoi diff      # Show differences
chezmoi apply     # Apply changes
chezmoi update    # Pull and apply
chezmoi cd        # Go to source directory
```

</details>

---

## 🎨 Customization

Each major component has detailed documentation:
- **[Hyprland](dot_config/hypr/README.md)** - Compositor, keybindings, modules
- **[Neovim](dot_config/nvim/readme.md)** - Plugins, LSP, DAP

<details>
<summary><b>Common Tasks</b></summary>

<br>

**Change themes:**
```bash
nvim ~/.config/noctalia/colorschemes/Green/Green.json
nyx-theme apply Green
nyx-theme toggle
```

**Adjust monitors:**
```bash
nvim ~/.local/share/chezmoi/dot_config/hypr/modules/monitors-desktop.conf
chezmoi apply
```

**Modify keybindings:**
```bash
nvim ~/.local/share/chezmoi/dot_config/hypr/modules/keybindings.conf
chezmoi apply
```

</details>

---

## 🔐 VeraCrypt Volume Mounting

This setup includes a helper script to mount and unmount a VeraCrypt volume quickly.

### Setup

1. Create your local environment file from the example:

```bash
cp ~/.local/share/chezmoi/.env.example ~/.local/share/chezmoi/.env
```

2. Edit `~/.local/share/chezmoi/.env` and set your real values:

```bash
VC_PASS="your_veracrypt_password"
VC_PARTUUID="your_device_partuuid"
VC_MOUNT_POINT="/mnt/your_mount_point"
```

3. Restrict permissions (required by the script):

```bash
chmod 600 ~/.local/share/chezmoi/.env
```

> The mount helper refuses to run if `.env` permissions are not `600`.

### Usage

The script is managed by chezmoi as `dot_local/bin/executable_vc-mount` and is available as `vc-mount` after apply.

```bash
# Mount the VeraCrypt volume
vc-mount mnt

# Unmount the VeraCrypt volume
vc-mount umnt

# Toggle state: mount if unmounted, unmount if mounted
vc-mount toggle
```

### What it does

- Validates `.env` permissions before reading secrets
- Reads `VC_PASS`, `VC_PARTUUID`, and `VC_MOUNT_POINT`
- Mounts `/dev/disk/by-partuuid/<VC_PARTUUID>` with user ownership (`uid`/`gid`)
- Supports `toggle` mode by checking whether the mount point is currently mounted
- Clears sensitive shell variables after execution

### Security Notes

- Never commit your real `.env` file
- Keep `.env` permissions as `600`
- Consider replacing plain password storage with keyfiles or an external secret manager if your threat model requires stronger protection

---

## 🤝 Contributing

While this is a personal configuration, contributions are welcome!

If you find bugs or have suggestions:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

---

## 🙏 Acknowledgements

These dotfiles include ideas, patterns, and tools from several great open-source projects:

- **[Noctalia](https://github.com/noctalia-dev/noctalia)** - Desktop shell and UI tooling used in this setup.
- **[Hyprland](https://github.com/hyprwm/Hyprland)** - Core Wayland compositor powering this environment.
- **[chezmoi](https://github.com/twpayne/chezmoi)** - Dotfile manager used to template and deploy this configuration.

Thanks to all maintainers and contributors behind these projects.

---

## ⚠️ Important Notes

**Before using these dotfiles:**
- These configurations are tailored to my workflow and hardware
- You may need to adjust:
  - Monitor configurations and resolutions
  - Input device settings
  - Application paths and preferences
  - Machine names in templates

**Disclaimer:** Don't blindly use these settings. Review and understand what each configuration does before applying.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

You are free to use, modify, and distribute these configurations. Attribution is appreciated but not required.

---

<div align="center">

**Maintained by [@PabloCruzval](https://github.com/PabloCruzval)**

For issues or questions, feel free to [open an issue](https://github.com/PabloCruzval/dotfiles/issues)

⭐ Star this repo if you find it useful!

</div>
