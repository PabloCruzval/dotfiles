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
    fcitx5-lua
    fcitx5-gtk
    fcitx5-qt
    fcitx5-configtool
    github-cli
    xclip
    pnpm
    rust
    rust-src
    typst
    tree-sitter-cli
    docker
    docker-compose
    syncthing
    obsidian
)

AUR=(
    crudini
    librewolf-bin
    ttf-ms-fonts
)

# Install official packages idempotently. Filter out packages that are
# already installed, install the rest in a single transaction, and if that
# fails fall back to installing one-by-one so a single bad package does not
# abort the whole batch.
install_repo_pkgs() {
    local -a missing=()
    local p

    for p in "$@"; do
        pacman -Q "$p" >/dev/null 2>&1 || missing+=("$p")
    done

    if [ ${#missing[@]} -eq 0 ]; then
        ok "All official packages already installed."
        return 0
    fi

    info "Installing ${#missing[@]} official packages..."
    if sudo pacman -S --needed --noconfirm "${missing[@]}"; then
        ok "Official packages installed."
        return 0
    fi

    warn "Batch install failed. Retrying per package to isolate failures..."
    local failed=0
    for p in "${missing[@]}"; do
        if ! sudo pacman -S --needed --noconfirm "$p"; then
            err "  Failed to install: $p"
            failed=1
        fi
    done
    return $failed
}

# Ensure an AUR helper is available, setting AUR_HELPER to "paru"/"yay" on
# success. Prefer paru from the CachyOS repo (built against the system
# libalpm); fall back to building paru from source. Do NOT use paru-bin, which
# links against a fixed libalpm soname and fails to load on CachyOS.
AUR_HELPER=""
ensure_aur_helper() {
    if command -v paru >/dev/null 2>&1; then AUR_HELPER="paru"; return 0; fi
    if command -v yay  >/dev/null 2>&1; then AUR_HELPER="yay";  return 0; fi

    info "No AUR helper found. Installing paru from the CachyOS repo..."
    if sudo pacman -S --needed --noconfirm paru; then
        if command -v paru >/dev/null 2>&1; then AUR_HELPER="paru"; return 0; fi
    fi

    info "paru not in repos. Building paru from source..."
    sudo pacman -S --needed --noconfirm base-devel git || {
        err "Failed to install base-devel/git."
        return 1
    }

    local tmp
    tmp="$(mktemp -d)"
    if ! git clone https://aur.archlinux.org/paru.git "$tmp/paru"; then
        err "Failed to clone paru."
        rm -rf "$tmp"
        return 1
    fi
    if ! (cd "$tmp/paru" && makepkg -si --noconfirm); then
        err "Failed to build/install paru."
        rm -rf "$tmp"
        return 1
    fi
    rm -rf "$tmp"

    if command -v paru >/dev/null 2>&1; then AUR_HELPER="paru"; return 0; fi
    err "paru still not available after bootstrap."
    return 1
}

# Install AUR packages idempotently via the given helper.
install_aur_pkgs() {
    local helper="$1"; shift
    local -a missing=()
    local p

    for p in "$@"; do
        "$helper" -Q "$p" >/dev/null 2>&1 || missing+=("$p")
    done

    if [ ${#missing[@]} -eq 0 ]; then
        ok "All AUR packages already installed."
        return 0
    fi

    info "Installing ${#missing[@]} AUR packages with $helper..."
    "$helper" -S --needed --noconfirm --removemake --sudoloop "${missing[@]}" \
        || warn "Some AUR packages failed. Review the output above."
}

# --- main ---

install_repo_pkgs "${PKGS[@]}"

if [ ${#AUR[@]} -gt 0 ]; then
    if ensure_aur_helper; then
        install_aur_pkgs "$AUR_HELPER" "${AUR[@]}"
    else
        err "Could not obtain an AUR helper. Skipping AUR packages:"
        for pkg in "${AUR[@]}"; do
            warn "  - $pkg"
        done
    fi
else
    info "No AUR packages configured."
fi

ok "All packages installed."
