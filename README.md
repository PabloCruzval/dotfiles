# Dotfiles

Personal dotfiles for CachyOS with Hyprland, managed with [chezmoi](https://www.chezmoi.io/). I use these on a desktop and a laptop, and the setup adapts based on the machine's chassis and connected displays.

## Contents

- Hyprland configured in Lua modules (`dot_config/hypr/config/`).
- [Noctalia](https://noctalia.dev/) desktop shell, driving the palette for Hyprland, Kitty, and GTK.
- Neovim with LSP and debugging; see [nvim/README.md](dot_config/nvim/README.md).
- Kitty, Fish, and tmux with sesh session management.
- Fcitx5 with Mozc for Japanese input.
- Zathura for reading papers and notes with Translate Shell integration.
- Package provisioning, fonts, and initial setup handled natively by chezmoi (`.chezmoidata/`, `.chezmoiscripts/`, `.chezmoiexternal.toml`).

## Install

I only run and test this on CachyOS. `chezmoi init --apply` prompts once for your Git name and email, installs missing packages from `.chezmoidata/packages.toml`, downloads the Funnel Display font, and applies all configs:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply PabloCruzval
```

To inspect what would change before applying:

```bash
chezmoi init https://github.com/PabloCruzval/dotfiles.git
chezmoi diff
chezmoi apply
```

## Structure

```
.chezmoidata/           Declarative package lists (pacman + AUR)
.chezmoiscripts/        First-run package install and post-setup hooks (run_once_)
.chezmoiexternal.toml   External archives (Funnel Display TTF font)
dot_config/             Application configs (~/.config)
dot_local/              User scripts (~/.local/bin)
```

chezmoi turns `dot_` into `.` on apply. Files ending in `.tmpl` are Go templates, `create_` seeds a file only if it doesn't exist yet (used for Noctalia's base config and local `sesh` sessions in `~/.config/sesh/local.toml`), and `executable_` sets the executable bit. Items in `.chezmoiignore` (markdown files, local caches) stay in the repo and aren't deployed to `$HOME`.

## Machine detection

- **Chassis & monitors (`.chezmoi.toml.tmpl` + `dot_config/hypr/config/monitors.lua.tmpl`):** `.chezmoi.toml.tmpl` detects `desktop` vs `laptop` via `hostnamectl chassis`, and `monitors.lua.tmpl` renders the matching display layout (`DP-1` + `HDMI-A-1` on desktop, `eDP-1` + `DP-1` on laptop).
- **Tmux sessions (`dot_config/sesh/create_local.toml`):** Imported by `sesh.toml` so each machine defines its own project sessions locally in `~/.config/sesh/local.toml`.
- **User data (`.chezmoi.toml.tmpl`):** Prompts once on `chezmoi init` for `git.name`, `git.email`, and `location` (used in `dot_config/git/config.tmpl` and `dot_config/noctalia/create_config.toml.tmpl`).

## Keybindings

Mod is `Super`. The essentials:

- `Super + Return`: terminal
- `Super + E`: file manager
- `Super + Q`: close window
- `Super + F`: fullscreen
- `Super + V`: toggle floating
- `Super + Shift + L`: lock screen with Noctalia
- `Super + h/j/k/l` or arrow keys: change window focus

Full keybinds live in `dot_config/hypr/config/binds.lua`.

## Workflow

I edit directly in the source directory and push with chezmoi:

```bash
chezmoi cd
# edit files
chezmoi apply
git add -A && git commit -m "..." && git push
```

On another machine: `chezmoi update` pulls and applies.

## Notes

If VS Code account sync complains, check [troubleshoot.md](troubleshoot.md). License is GPL v3 ([LICENSE](LICENSE)).
