#!/bin/bash

# ==========================================
# Configuration and Variables
# ==========================================
readonly CHEZMOI_PATH="$HOME/.local/share/chezmoi"
readonly REPO_URL="https://github.com/PabloCruzval/dotfiles"
readonly BACKUP_DIR="$HOME/.backups_dotfiles/$(date +%Y%m%d_%H%M%S)"
readonly PKGLIST="$CHEZMOI_PATH/pkglist"
readonly AURLIST="$CHEZMOI_PATH/aurlist"

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

function backup_and_clone_repo() {
    local backup_path="$BACKUP_DIR/chezmoi_backup"
    mkdir -p "$BACKUP_DIR"
    log_info "Backing up existing directory to $backup_path"
    mv "$CHEZMOI_PATH" "$backup_path"
    
    log_info "Cloning repository from $REPO_URL..."
    git clone "$REPO_URL" "$CHEZMOI_PATH"
}

function is_correct_repo() {
    [ ! -d "$CHEZMOI_PATH/.git" ] && return 1
    
    local current_remote=$(git -C "$CHEZMOI_PATH" remote get-url origin 2>/dev/null || echo "")
    [ "$current_remote" = "$REPO_URL" ] || [ "$current_remote" = "${REPO_URL}.git" ]
}

# ==========================================
# 1. Startup and Dependencies
# ==========================================
log_info "Starting Nyx's dotfiles setup..."

log_info "Updating system and installing base tools..."
sudo pacman -Syu --needed --noconfirm git base-devel unzip wget curl

# ==========================================
# 2. Clone and Setup Chezmoi Repository
# ==========================================
log_info "Checking chezmoi repository..."

if ! exists chezmoi; then
    log_info "Installing chezmoi..."
    sudo pacman -S --needed --noconfirm chezmoi
fi

# If directory doesn't exist, clone and exit section
if [ ! -d "$CHEZMOI_PATH" ]; then
    log_info "Cloning repository from $REPO_URL..."
    git clone "$REPO_URL" "$CHEZMOI_PATH"
    cd "$CHEZMOI_PATH" || exit 1
    log_info "Working directory changed to $CHEZMOI_PATH"
    # Continue to next section
elif is_correct_repo; then
    # Correct repository already exists, just update
    log_info "Correct repository already cloned. Updating..."
    git -C "$CHEZMOI_PATH" pull
    cd "$CHEZMOI_PATH" || exit 1
    log_info "Working directory changed to $CHEZMOI_PATH"
else
    # Wrong repository or not a git directory - backup and clone
    if [ -d "$CHEZMOI_PATH/.git" ]; then
        current_remote=$(git -C "$CHEZMOI_PATH" remote get-url origin 2>/dev/null || echo "unknown")
        log_warn "Found different chezmoi repository at $CHEZMOI_PATH"
        log_warn "Current remote: $current_remote"
    else
        log_warn "Found non-git directory at $CHEZMOI_PATH"
    fi
    
    backup_and_clone_repo
    cd "$CHEZMOI_PATH" || exit 1
    log_info "Working directory changed to $CHEZMOI_PATH"
fi

# ==========================================
# 3. Bootstrapping Yay
# ==========================================
if ! exists yay; then
    log_info "Installing Yay..."
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin || exit
    makepkg -si --noconfirm
    cd "$CHEZMOI_PATH" || exit 1
    rm -rf /tmp/yay-bin
fi

# ==========================================
# 4. Package Installation
# ==========================================
if [ -f "$PKGLIST" ]; then
    log_info "Installing official packages..."
    sudo pacman -S --needed --noconfirm - < <(sed 's/#.*//; /^[[:space:]]*$/d' "$PKGLIST")
fi

if [ -f "$AURLIST" ]; then
    log_info "Installing AUR packages..."
    aur_list=$(grep -vE "^\s*#" "$AURLIST" | tr '\n' ' ')
    if [ ! -z "$aur_list" ]; then
        yay -S --needed --noconfirm $aur_list
    fi
fi

# ==========================================
# 5. Git Configuration
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
# 6. Verify Repository is Ready
# ==========================================
log_info "Verifying repository files..."

if [ ! -f "$PKGLIST" ]; then
    log_error "pkglist file not found at $PKGLIST"
    exit 1
fi

if [ ! -f "$AURLIST" ]; then
    log_error "aurlist file not found at $AURLIST"
    exit 1
fi

log_info "Repository files verified successfully"

# ==========================================
# 7. Automatic Backup
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
# 8. Apply Changes
# ==========================================
log_info "Applying dotfiles with Chezmoi..."
chezmoi apply

log_info "Installation completed successfully!"
