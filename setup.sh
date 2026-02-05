#!/bin/bash

# ==========================================
# Configuration and Variables
# ==========================================
readonly CHEZMOI_PATH="$HOME/.local/share/chezmoi"
readonly PKGLIST="pkglist"
readonly AURLIST="aurlist"
readonly REPO_URL="https://github.com/PabloCruzval/dotfiles"
readonly BACKUP_DIR="$HOME/.backups_dotfiles/$(date +%Y%m%d_%H%M%S)"

# Colors
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

# ==========================================
# Functions
# ==========================================
function log_info() { echo "${green}[INFO]${reset} $1"; }
function log_warn() { echo "${yellow}[WARN]${reset} $1"; }
function log_error() { echo "${red}[ERROR]${reset} $1"; }

function exists() {
    command -v "$1" >/dev/null 2>&1
}

function backup_config() {
    local path="$1"
    local name=$(basename "$path")
    
    if [ -e "$path" ]; then
        mkdir -p "$BACKUP_DIR"
        log_warn "Conflict detected at '$path'. Moving to backup..."
        mv "$path" "$BACKUP_DIR/$name"
    fi
}

# ==========================================
# 1. Startup and Dependencies
# ==========================================
log_info "Starting Nyx's dotfiles setup..."

log_info "Updating system and installing base tools..."
sudo pacman -Syu --needed --noconfirm git base-devel unzip wget curl

# ==========================================
# 2. Bootstrapping Yay
# ==========================================
if ! exists yay; then
    log_info "Installing Yay..."
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin || exit
    makepkg -si --noconfirm
    cd - || exit
    rm -rf /tmp/yay-bin
fi

# ==========================================
# 3. Package Installation
# ==========================================
if [ -f "$PKGLIST" ]; then
    log_info "Installing official packages..."
    sudo pacman -S --needed --noconfirm - < <(sed 's/#.*//; /^[[:space:]]*$/d' "$PKGLIST")
fi

if [ -f "$AURLIST" ]; then
    log_info "Installing AUR packages..."
    yay -S --needed --noconfirm - < <(sed 's/#.*//; /^[[:space:]]*$/d' "$AURLIST")
fi

# ==========================================
# 4. Git Configuration
# ==========================================
log_info "Checking Git configuration..."

GIT_NAME=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

if [ -z "$GIT_NAME" ] || [ -z "$GIT_EMAIL" ]; then
    log_warn "Git is not fully configured."
    
    if [ -z "$GIT_NAME" ]; then
        log_warn "User name is not configured."
    fi
    
    if [ -z "$GIT_EMAIL" ]; then
        log_warn "Email is not configured."
    fi
    
    read -p "${yellow}Do you want to configure Git now? (y/n): ${reset}" -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [ -z "$GIT_NAME" ]; then
            read -p "Enter your name: " input_name
            git config --global user.name "$input_name"
            log_info "Name configured: $input_name"
        fi
        
        if [ -z "$GIT_EMAIL" ]; then
            read -p "Enter your email: " input_email
            git config --global user.email "$input_email"
            log_info "Email configured: $input_email"
        fi
    else
        log_warn "Continuing without configuring Git. You can do it later with:"
        log_warn "  git config --global user.name 'Your Name'"
        log_warn "  git config --global user.email 'your@email.com'"
    fi
else
    log_info "Git is already configured (${GIT_NAME} <${GIT_EMAIL}>)"
fi

# ==========================================
# 5. Chezmoi Initialization
# ==========================================
if ! exists chezmoi; then
    sudo pacman -S --needed --noconfirm chezmoi
fi

log_info "Syncing dotfiles repository..."

if [ ! -d "$CHEZMOI_PATH" ]; then
    chezmoi init "$REPO_URL"
else
    log_info "Updating local repo..."
    git -C "$CHEZMOI_PATH" pull
fi

# ==========================================
# 6. Automatic Backup
# ==========================================
log_info "Checking for conflicts and creating backups..."

for dir in "$CHEZMOI_PATH"/dot_config/*; do
    config_name=$(basename "$dir")
    target_path="$HOME/.config/$config_name"
    
    backup_config "$target_path"
done

if [ -f "$CHEZMOI_PATH/dot_zshrc" ]; then
    backup_config "$HOME/.zshrc"
fi

if [ -d "$BACKUP_DIR" ]; then
    log_info "Backups saved to: ${yellow}$BACKUP_DIR${reset}"
fi

# ==========================================
# 7. Apply Changes
# ==========================================
log_info "Applying dotfiles with Chezmoi..."
chezmoi apply

log_info "Installation completed successfully!"