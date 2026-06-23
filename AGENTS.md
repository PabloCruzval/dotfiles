# AGENTS.md — Dotfiles chezmoi

## Commits

- **Never commit unless explicitly instructed.**
- When told to commit, use:
  `git commit --author="<agent_name>-<username> <agent_name+user_email>" -m "<commit-message>"`
  - `<agent_name>` — your own name (e.g. `opencode`, `claude`)
  - `<username>` — `git config user.name` (e.g. `PabloCruzval`)
  - `<user_email>` — `git config user.email` (e.g. `p.cruzat.valenzuela@gmail.com`)
  - The email format is **literal** `<agent_name>+<user_email>` — the `+` is part of the address
  - Example: `opencode-PabloCruzval <opencode+p.cruzat.valenzuela@gmail.com>`
  - `<commit-message>` must follow conventional commits

## Repo overview

Personal dotfiles for Arch Linux + Hyprland, managed by [chezmoi](https://chezmoi.io).
The source directory IS the chezmoi source (`~/.local/share/chezmoi`). No CI, tests, linters, or build steps.

## Chezmoi naming conventions

- `dot_` → `.` (hidden files), e.g. `dot_config/hypr/` → `~/.config/hypr/`
- `.tmpl` suffix = chezmoi template (Go template syntax)
- `executable_` prefix = executable bit set on apply
- `.chezmoiignore` lists files chezmoi skips (e.g. `install/`, `setup.sh`, `README.md`)

## Machine-specific config

- `.chezmoi.toml.tmpl` sets `machinename` from `hostnamectl hostname`
- Templates branch on `{{ if eq .machinename "cnyx" }}` for desktop vs laptop
- `dot_config/hypr/hyprland.lua` does its own hostname detection at runtime (archtower vs lnyx)

## Key paths

| Path | Purpose |
|------|---------|
| `install/*.sh` | Interactive Arch Linux setup scripts (modular) |
| `dot_config/<app>/` | Per-app config (hypr, nvim, kitty, tmux, systemd) |
| `dot_local/bin/executable_*` | Custom scripts (vc-mount, tmux-workspace) |
| `.chezmoi.toml.tmpl` | Chezmoi config / template data |
| `.chezmoiignore` | Files excluded from chezmoi management |
| `.env.example` | Template for VeraCrypt credentials (`.env` is gitignored) |

## Git workflow

```bash
chezmoi cd          # go to source dir
# edit files
chezmoi apply       # deploy changes locally
git add -A && git commit -m "..." && git push
chezmoi update      # on other machines: pull + apply
```

## Install flow

`bash setup.sh` orchestrates `install/*.sh` interactively. Arch Linux only.
`install/chezmoi.sh` and `install/sddm.sh` are currently empty stubs.

## Gitignored (don't touch)

`.env`, `.ArchConf/`, `.backup/`, `.vscode/`, `dot_config/noctalia/colors.json`
