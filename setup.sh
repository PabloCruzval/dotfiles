#!/bin/bash

# ==========================================
# Configuración y Variables
# ==========================================
readonly CHEZMOI_PATH="$HOME/.local/share/chezmoi"
readonly PKGLIST="pkglist"
readonly AURLIST="aurlist"
readonly REPO_URL="https://github.com/PabloCruzval/dotfiles"
readonly BACKUP_DIR="$HOME/.backups_dotfiles/$(date +%Y%m%d_%H%M%S)"

# Colores
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

# ==========================================
# Funciones
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
        log_warn "Detectado conflicto en '$path'. Moviendo a backup..."
        mv "$path" "$BACKUP_DIR/$name"
    fi
}

# ==========================================
# 1. Inicio y Dependencias
# ==========================================
log_info "Iniciando setup de Nyx's dotfiles..."

log_info "Actualizando sistema e instalando herramientas base..."
sudo pacman -Syu --needed --noconfirm git base-devel unzip wget curl

# ==========================================
# 2. Bootstrapping Yay
# ==========================================
if ! exists yay; then
    log_info "Instalando Yay..."
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin || exit
    makepkg -si --noconfirm
    cd - || exit
    rm -rf /tmp/yay-bin
fi

# ==========================================
# 3. Instalación de Paquetes
# ==========================================
if [ -f "$PKGLIST" ]; then
    log_info "Instalando paquetes oficiales..."
    sudo pacman -S --needed --noconfirm - < <(sed 's/#.*//; /^[[:space:]]*$/d' "$PKGLIST")
fi

if [ -f "$AURLIST" ]; then
    log_info "Instalando paquetes AUR..."
    yay -S --needed --noconfirm - < <(sed 's/#.*//; /^[[:space:]]*$/d' "$AURLIST")
fi

# ==========================================
# 4. Inicialización de Chezmoi
# ==========================================
if ! exists chezmoi; then
    sudo pacman -S --needed --noconfirm chezmoi
fi

log_info "Sincronizando repositorio de dotfiles..."

if [ ! -d "$CHEZMOI_PATH" ]; then
    chezmoi init "$REPO_URL"
else
    log_info "Actualizando repo local..."
    git -C "$CHEZMOI_PATH" pull
fi

# ==========================================
# 5. BACKUP AUTOMÁTICO (Lógica recuperada)
# ==========================================
log_info "Verificando conflictos y realizando backups..."

for dir in "$CHEZMOI_PATH"/dot_config/*; do
    config_name=$(basename "$dir")
    target_path="$HOME/.config/$config_name"
    
    backup_config "$target_path"
done

if [ -f "$CHEZMOI_PATH/dot_zshrc" ]; then
    backup_config "$HOME/.zshrc"
fi

if [ -d "$BACKUP_DIR" ]; then
    log_info "Se han guardado copias de seguridad en: ${yellow}$BACKUP_DIR${reset}"
fi

# ==========================================
# 6. Aplicar Cambios
# ==========================================
log_info "Aplicando dotfiles con Chezmoi..."
chezmoi apply

log_info "¡Instalación completada correctamente!"