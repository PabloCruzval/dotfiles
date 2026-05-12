#!/bin/bash

# Colors
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

function log_info() { echo "${green}[INFO]${reset} $1"; }
function log_warn() { echo "${yellow}[WARN]${reset} $1"; }
function log_error() { echo "${red}[ERROR]${reset} $1"; }

function exists() {
    command -v "$1" >/dev/null 2>&1
}

function is_installed() {
    pacman -Q "$1" >/dev/null 2>&1
}

pkgs=(
	# Core & Hardware (Nvidia LTS + Backends de Red y Bluetooth)
	linux-lts-headers nvidia-open-lts nvidia-utils egl-wayland
	networkmanager bluez bluez-utils

	# Development & CLI Tools
	git base-devel neovim npm ripgrep
	jq eza bat fd lazygit

	# Dotfiles Management
	chezmoi

	# Shell
	zsh fzf zoxide

	# Terminal Emulator
	kitty

	# Hyprland & Wayland Ecosystem
	hyprland hyprpaper hyprpolkitagent 
	hyprlock hypridle hyprpicker cliphist
	xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
	qt5-wayland qt6-wayland xdg-user-dirs

	# Screenshot Tools
	grim slurp

	# Wayland/System Utilities
	wl-clipboard brightnessctl unzip wget curl less

	# Audio/Media (Backends de audio + mixer en terminal + control avanzado GUI)
	pipewire pipewire-audio pipewire-alsa pipewire-pulse
	wireplumber pamixer wiremix pavucontrol

	# File Manager
	dolphin yazi

	# Fonts
	noto-fonts-cjk noto-fonts-emoji noto-fonts ttf-jetbrains-mono-nerd

	# Keyring/Security
	gnome-keyring libsecret
)

aur_pkgs=(
	brave-bin
	noctalia-shell
	emote
	volantes-cursors-git
	obsidian
)

# ==========================================
#  Install Official Packages (Dependencies first)
# ==========================================
log_info "Installing official packages..."
sudo pacman -S --needed --noconfirm "${pkgs[@]}"
log_info "Official packages installation process finished."

# ==========================================
#  Install Yay if not present
# ==========================================
if ! command -v yay &> /dev/null; then
	log_info "Installing Yay..."
	git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
	cd /tmp/yay-bin || exit
	makepkg -si --noconfirm
	cd - || exit
	rm -rf /tmp/yay-bin
	log_info "Yay installed successfully"
else
	log_warn "Yay is already installed"
fi

# ==========================================
#  Install AUR Packages
# ==========================================
if [ ${#aur_pkgs[@]} -gt 0 ]; then
	log_info "Installing AUR packages..."
	yay -S --needed --noconfirm "${aur_pkgs[@]}"
	log_info "AUR packages installation process finished."
else
	log_warn "No AUR packages to install."
fi

log_info "Package installation completed!"
