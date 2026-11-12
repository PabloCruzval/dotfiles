#!/bin/bash

set -euo pipefail
trap 'echo ""; exit 130' INT TERM HUP

C_DEF='\033[0m'
C_BLU='\033[1;34m'
C_GRN='\033[1;32m'
C_RED='\033[1;31m'
C_YEL='\033[1;33m'

info() { echo -e "${C_BLU}[INFO]${C_DEF} $1"; }
ok()   { echo -e "${C_GRN}[ OK ]${C_DEF} $1"; }
err()  { echo -e "${C_RED}[ERR!]${C_DEF} $1"; }
warn() { echo -e "${C_YEL}[WARN]${C_DEF} $1"; }

if ! command -v pacman >/dev/null 2>&1; then
    warn "pacman not found; skipping Arch/CachyOS package installation."
    exit 0
fi

PKG_FILE="${CHEZMOI_SOURCE_DIR:-$HOME/.local/share/chezmoi}/.chezmoidata/packages.toml"
if [ ! -f "$PKG_FILE" ]; then
    warn "Package file not found: $PKG_FILE"
    exit 0
fi

mapfile -t PKGS < <(awk '/^pacman = \[/,/^\]/' "$PKG_FILE" | awk -F'"' '/^    "/{print $2}')
mapfile -t AUR  < <(awk '/^aur = \[/,/^\]/' "$PKG_FILE" | awk -F'"' '/^    "/{print $2}')

missing_repo=()
for p in "${PKGS[@]}"; do
    pacman -Q "$p" >/dev/null 2>&1 || missing_repo+=("$p")
done

missing_aur=()
for p in "${AUR[@]}"; do
    pacman -Q "$p" >/dev/null 2>&1 || missing_aur+=("$p")
done

if [ ${#missing_repo[@]} -eq 0 ] && [ ${#missing_aur[@]} -eq 0 ]; then
    ok "All packages already installed."
    exit 0
fi

if [ ! -t 0 ]; then
    warn "Non-interactive shell; skipping installation of missing packages."
    exit 0
fi

echo -ne "${C_BLU}[ ?? ]${C_DEF} Install missing packages (${missing_repo[*]} ${missing_aur[*]})? [Y/n]: "
read -r reply </dev/tty || exit 0
if [[ -n "$reply" && ! "$reply" =~ ^[Yy]$ ]]; then
    info "Skipping package installation."
    exit 0
fi

if ! sudo -v; then
    err "Could not obtain sudo privileges. Aborting package installation."
    exit 1
fi

if [ ${#missing_repo[@]} -gt 0 ]; then
    info "Installing ${#missing_repo[@]} official packages: ${missing_repo[*]}"
    sudo pacman -S --needed --noconfirm "${missing_repo[@]}"
    ok "Official packages installed."
fi

if [ ${#missing_aur[@]} -gt 0 ]; then
    AUR_HELPER=""
    if command -v paru >/dev/null 2>&1; then
        AUR_HELPER="paru"
    elif command -v yay >/dev/null 2>&1; then
        AUR_HELPER="yay"
    else
        info "Installing paru..."
        sudo pacman -S --needed --noconfirm paru && AUR_HELPER="paru"
    fi

    if [ -n "$AUR_HELPER" ]; then
        info "Installing ${#missing_aur[@]} AUR packages: ${missing_aur[*]}"
        "$AUR_HELPER" -S --needed --noconfirm --skipreview --removemake "${missing_aur[@]}"
        ok "AUR packages installed."
    else
        warn "No AUR helper available. Skipping: ${missing_aur[*]}"
    fi
fi
