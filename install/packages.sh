#!/bin/bash

if ! command -v info >/dev/null 2>&1; then
	source "$(dirname "${BASH_SOURCE[0]:-$0}")/utils.sh"
fi

if ! command -v pacman >/dev/null 2>&1; then
    err "This script is for CachyOS / Arch-based systems only."
    exit 1
fi

PKGS=(
    chezmoi
    neovim
    tmux
    lazygit
    ripgrep
    fd
    eza
    bat
    fzf
    zoxide
    yazi
    nodejs
    npm
    just
    noto-fonts-cjk
    noto-fonts-emoji
    ttf-jetbrains-mono-nerd
    ttf-meslo-nerd
    awesome-terminal-fonts
    fcitx5
    fcitx5-mozc
    fcitx5-im
    fcitx5-lua
    fcitx5-gtk
    fcitx5-qt
    fcitx5-configtool
    github-cli
    pnpm
    typst
    tree-sitter-cli
    docker
    docker-compose
    syncthing
)

AUR=(
    obsidian
    crudini
    librewolf
    ttf-ms-fonts
)

# Official packages
info "Installing packages..."
sudo pacman -S --needed --noconfirm "${PKGS[@]}"
ok "Official packages done."

# AUR (paru or yay required)
if [ ${#AUR[@]} -gt 0 ]; then
    AUR_HELPER=""
    if command -v paru >/dev/null 2>&1; then
        AUR_HELPER="paru"
    elif command -v yay >/dev/null 2>&1; then
        AUR_HELPER="yay"
    fi

    if [ -n "$AUR_HELPER" ]; then
        info "Installing AUR packages with $AUR_HELPER..."
        $AUR_HELPER -S --needed --noconfirm "${AUR[@]}"
        ok "AUR packages done."
    else
        err "No AUR helper found (paru/yay). The following AUR packages were skipped:"
        for pkg in "${AUR[@]}"; do
            warn "  - $pkg"
        done
        warn "Install paru or yay and re-run to install them."
    fi
else
    info "No AUR packages configured."
fi

ok "All packages installed."
