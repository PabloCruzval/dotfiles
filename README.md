<h1 align="center">Pablo Dotfiles 💽</h1>

<div align="center">

![GitHub last commit](https://img.shields.io/github/last-commit/PabloCruzval/dotfiles?style=for-the-badge&labelColor=1e1e2e&color=89b4fa)
![GitHub repo size](https://img.shields.io/github/repo-size/PabloCruzval/dotfiles?style=for-the-badge&labelColor=1e1e2e&color=a6e3a1)
![License](https://img.shields.io/github/license/PabloCruzval/dotfiles?style=for-the-badge&labelColor=1e1e2e&color=fab387)

</div>

---

https://github.com/user-attachments/assets/adce3f51-be9a-433b-9a28-7132e8fb3eb2

Personal dotfiles for CachyOS featuring a modern Hyprland setup where [Noctalia Shell](https://noctalia.dev/) defines the visual feel of the desktop, while [chezmoi](https://www.chezmoi.io/) manages the dotfiles for consistent deployment across multiple machines.

## ✨ Features

- **🎨 Noctalia v5 Theming** - Native C++ desktop shell that generates cohesive Material Design colors for Hyprland, Kitty, and GTK
- **🖥️ Multi-Monitor Support** - Separate configurations for desktop and laptop setups
- **📦 Modular Configuration** - Clean, organized configs split by functionality
- **🔄 Template-Based** - Machine-specific configs generated automatically via chezmoi
- **⚡ Modern Wayland Stack** - Hyprland compositor with Noctalia Shell as the desktop layer that drives the overall feel
- **🛠️ Developer-Focused** - Neovim with LSP, DAP, and modern plugin ecosystem
- **🔧 Interactive Modular Setup** - Clean, step-by-step interactive installation flow inspired by [Symphony](https://github.com/vyrx-dev/symphony).

## 📦 What's Inside

- **[Hyprland](dot_config/hypr/README.md)** - Wayland compositor with modular Lua configuration
- **[Neovim](dot_config/nvim/readme.md)** - Modern IDE setup with LSP, Treesitter, and debugging
- **[Noctalia v5](https://docs.noctalia.dev/v5/)** - Native Wayland desktop shell (C++) powering bars, launcher, control center, and themes
- **Kitty** - GPU-accelerated terminal emulator
- **Fish** - Shell with CachyOS defaults and custom tool integrations
- **Fcitx5** - Input method framework (Mozc for Japanese + US/Latin keyboards)

> 📚 Applications with their own detailed README are linked above.

## 🚀 Quick Start

### Interactive Installation

>[!IMPORTANT]
> Only for CachyOS. The script was made for my machines and may require adjustments for yours.

>[!NOTE]
> Existing configurations will be backed up by chezmoi automatically.

```bash
bash -c "$(curl -fsSL [https://raw.githubusercontent.com/PabloCruzval/dotfiles/refs/heads/main/setup.sh](https://raw.githubusercontent.com/PabloCruzval/dotfiles/refs/heads/main/setup.sh))"
```

### What the installer does:
1. **Packages:** Installs extra packages not included in CachyOS base (chezmoi, nvim, tmux, CLI tools, fonts, Rust toolchain, fcitx5).
2. **AUR:** Bootstraps an AUR helper (paru) if missing, then installs AUR packages (librewolf, etc.).
3. **Git Config:** Interactive global Git user configuration.
4. **Dotfiles:** Applies chezmoi configurations from this repo.
5. **Fonts:** Installs Funnel Display font.
6. **SDDM:** Installs the qylock SDDM theme.

> The package installer is idempotent: it skips already-installed packages, auto-bootstraps an AUR helper, and falls back to per-package installs if a batch fails — so it is safe to re-run until everything is installed.

## 📋 Requirements

- **OS**: CachyOS with Hyprland
- **Display Server**: Wayland
- **Shell**: Fish (default on CachyOS)
- **Dependencies**: Listed in `install/packages.sh` (Rust toolchain includes `rust-src` for the LSP).
- **AUR Helper**: `paru` (auto-installed by the setup if missing).

## 📁 Structure

The repository is organized with chezmoi naming conventions:

| What | Where | Description |
|------|-------|-------------|
| **Installer**| `install/` | Modular setup scripts (`utils.sh`, `packages.sh`, etc.) |
| **Hyprland** | `dot_config/hypr/` | Modular Wayland compositor config in Lua |
| **Neovim** | `dot_config/nvim/` | LSP, DAP, and plugin configurations |
| **Kitty** | `dot_config/kitty/` | Terminal emulator config |
| **Fish** | `dot_config/fish/` | Shell configuration with tool integrations |
| **Fcitx5** | `dot_config/fcitx5/` | Input method (Mozc + Latin keyboard layouts) |
| **UWSM** | `dot_config/uwsm/` | Wayland session environment variables |
| **Scripts** | `dot_local/bin/` | Utility scripts (vc-mount, tmux-workspace) |

> 💡 **Chezmoi naming**: `dot_` → `.` (hidden files), `.tmpl` → template, `executable_` → executable bit

---

## 🎯 Key Features

Noctalia v5 is a native Wayland desktop shell (C++) that provides bars, launcher, control center, notifications, wallpaper, lock screen, and app theming. The active palette is derived from the current wallpaper (`[theme].source = "wallpaper"`) and applied to Hyprland, Kitty, and GTK apps through built-in templates.

<details>
<summary><b>🎨 Theming</b></summary>

<br>

Noctalia v5 generates themed configuration files for external apps via its built-in template engine:

- **Hyprland** - `require("noctalia").apply_theme()` sets border colors from the active palette defined in `noctalia.lua`.
- **Kitty** - `include themes/noctalia.conf` loads the 16-color terminal palette.
- **GTK** - Handled by Noctalia v5 templates and `adw-gtk-theme` (shipped with CachyOS).

**Palette location**: `~/.config/noctalia/palettes/<Name>.json`

**Applying templates**: Templates are automatically applied when the wallpaper or theme mode changes. Manual rerender:

```bash
noctalia msg templates-apply
```

**GTK theming details**: See [`dot_config/gtk-3.0/README.md`](dot_config/gtk-3.0/README.md)

**Chromium browser note**: Chromium-based browsers (e.g. librewolf) read the GTK theme only at startup. After switching light/dark, restart the browser.

</details>

<details>
<summary><b>🖥️ Multi-Machine Support</b></summary>

<br>

Chezmoi templates automatically adapt configurations based on machine name:

```lua
if HOSTNAME == "t-nyx" then
    require("config.monitors-desktop")
    require("config.workspaces-desktop")
else
    require("config.monitors-laptop")
    require("config.workspaces-laptop")
end
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
nvim dot_config/hypr/config/binds.lua    # Edit files
chezmoi apply                            # Apply changes
git add . && git commit -m "Update"      # Commit
git push                                 # Push
```

**Quick edit:**
```bash
chezmoi edit ~/.config/hypr/hyprland.lua
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
- **[Hyprland](dot_config/hypr/README.md)** - Compositor, keybindings, config
- **[Neovim](dot_config/nvim/README.md)** - Plugins, LSP, DAP

<details>
<summary><b>Common Tasks</b></summary>

<br>

**Change theme:**
Use Noctalia's control center (Super + Super_L) and open Settings > Theme.
Palettes are managed in `~/.config/noctalia/palettes/`.

**Adjust monitors:**
```bash
nvim ~/.local/share/chezmoi/dot_config/hypr/config/monitors-desktop.lua
chezmoi apply
```

**Modify keybindings:**
```bash
nvim ~/.local/share/chezmoi/dot_config/hypr/config/binds.lua
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