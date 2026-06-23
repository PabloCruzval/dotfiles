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

- **🎨 Nord-Inspired Color Scheme** - Cohesive color palette across Hyprland borders, Kitty terminal, and tmux
- **🖥️ Multi-Monitor Support** - Separate configurations for desktop and laptop setups
- **📦 Modular Configuration** - Clean, organized configs split by functionality
- **🔄 Template-Based** - Machine-specific configs generated automatically via chezmoi
- **⚡ Modern Wayland Stack** - Hyprland compositor with Noctalia Shell as the desktop layer that drives the overall feel
- **🛠️ Developer-Focused** - Neovim with LSP, DAP, and modern plugin ecosystem
- **🔧 Interactive Modular Setup** - Clean, step-by-step interactive installation flow inspired by [Symphony](https://github.com/vyrx-dev/symphony).

## 📦 What's Inside

- **[Hyprland](dot_config/hypr/README.md)** - Wayland compositor with modular configuration
- **[Neovim](dot_config/nvim/readme.md)** - Modern IDE setup with LSP, Treesitter, and debugging
- **[Noctalia](https://noctalia.dev/)** - Wayland desktop shell and the component that defines the look, feel, and interaction model of the desktop
- **Kitty** - GPU-accelerated terminal emulator
- **Zsh** - Shell with Powerlevel10k and Zinit plugin manager
- **Rofi** - Application launcher

> 📚 Applications with their own detailed README are linked above.

## 🚀 Quick Start

### Interactive Installation

>[!IMPORTANT]
> Only for Arch Linux. The script was made for my machines and may require adjustments for yours.

>[!NOTE]
> Existing configurations for `hypr`, `noctalia`, `kitty`, `nvim`, or `rofi` will be backed up to `$HOME/.backups_dotfiles/<timestamp>`

```bash
bash -c "$(curl -fsSL [https://raw.githubusercontent.com/PabloCruzval/dotfiles/refs/heads/main/setup.sh](https://raw.githubusercontent.com/PabloCruzval/dotfiles/refs/heads/main/setup.sh))"
```

### What the installer does:
The setup script acts as an orchestrator, allowing you to choose exactly what to install:
1. **Base System:** Installs core tools (Git, base-devel, Chezmoi) and sets up Yay.
2. **Packages:** Installs official and AUR packages from defined lists.
3. **Git Config:** Interactive global Git user configuration.
4. **Services:** Enables necessary system and user services (NetworkManager, Bluetooth, custom timers).
5. **Dotfiles:** Safely applies Chezmoi configurations with automatic conflict backups.

## 📋 Requirements

- **OS**: Arch Linux
- **Display Server**: Wayland
- **Package Managers**: `pacman` and an AUR helper `yay`
- **Fonts**: Nerd Fonts (installed automatically)
- **Dependencies**: Listed in `install/pkgs.sh`.

## 📁 Structure

The repository is organized with chezmoi naming conventions:

| What | Where | Description |
|------|-------|-------------|
| **Installer**| `install/` | Modular setup scripts (`utils.sh`, `base.sh`, `pkgs.sh`, etc.) |
| **Hyprland** | `dot_config/hypr/` | Modular Wayland compositor config with templates |
| **Neovim** | `dot_config/nvim/` | LSP, DAP, and plugin configurations |
| **Kitty** | `dot_config/kitty/` | Terminal emulator config |
| **Scripts** | `dot_local/bin/` | Utility scripts (vc-mount, tmux-workspace) |

> 💡 **Chezmoi naming**: `dot_` → `.` (hidden files), `.tmpl` → template, `executable_` → executable bit

---

## 🎯 Key Features

Noctalia Shell provides the desktop widget layer (bar, launcher, control center) but its visual configuration is managed directly within the app.

<details>
<summary><b>🎨 Theming</b></summary>

<br>

Nord-inspired color scheme applied to:

- **Hyprland** - Border colors (`#88c0d0` active, `#3b4252` inactive) and shadow (`#2e3440`) are hardcoded in `modules/general.lua` and `modules/decorations.lua`
- **Kitty** - 16-color Nord palette defined inline in `kitty.conf`
- **tmux** - Full OpenCode palette in `tmux.conf`
- **GTK** - `Adwaita-dark` theme with `prefer-dark` color scheme set via `gsettings`
- **Cursor** - `volantes-cursors` at size 34

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

**Change GTK theme:**
```bash
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
# or use nwg-look for a GUI
nwg-look
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

- **[Symphony](https://github.com/vyrx-dev/symphony)** - Huge inspiration for the clean, modular, and interactive bash installation flow used in this setup.
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

This project is open source and available under the [GPL License](LICENSE).

You are free to use, modify, and distribute these configurations. Attribution is appreciated but not required.

---

<div align="center">

**Maintained by [@PabloCruzval](https://github.com/PabloCruzval)**

For issues or questions, feel free to [open an issue](https://github.com/PabloCruzval/dotfiles/issues)

⭐ Star this repo if you find it useful!

</div>