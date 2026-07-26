#!/bin/bash

green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

function log_info() { echo "${green}[INFO]${reset} $1"; }
function log_warn() { echo "${yellow}[WARN]${reset} $1"; }

function inpath() { command -v "$1" >/dev/null 2>&1; }

if ! inpath pacman; then
    echo "This script is for CachyOS / Arch-based systems only." >&2
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
    syncthing
    just
    noto-fonts-cjk
    noto-fonts-emoji
    ttf-jetbrains-mono-nerd
)

AUR=(
    obsidian
)

# Official packages
log_info "Installing packages..."
sudo pacman -S --needed --noconfirm "${PKGS[@]}"
log_info "Official packages done."

# AUR (paru or yay required)
if [ ${#AUR[@]} -gt 0 ]; then
    AUR_HELPER=""
    if inpath paru; then
        AUR_HELPER="paru"
    elif inpath yay; then
        AUR_HELPER="yay"
    fi

    if [ -n "$AUR_HELPER" ]; then
        log_info "Installing AUR packages with $AUR_HELPER..."
        $AUR_HELPER -S --needed --noconfirm "${AUR[@]}"
        log_info "AUR packages done."
    else
        log_warn "No AUR helper found. Install paru or yay first."
    fi
else
    log_info "No AUR packages configured."
fi

log_info "All packages installed."
