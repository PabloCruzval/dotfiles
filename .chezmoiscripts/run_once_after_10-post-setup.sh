#!/bin/bash

set -euo pipefail

C_DEF='\033[0m'
C_BLU='\033[1;34m'
C_GRN='\033[1;32m'

info() { echo -e "${C_BLU}[INFO]${C_DEF} $1"; }
ok()   { echo -e "${C_GRN}[ OK ]${C_DEF} $1"; }

if command -v fc-cache >/dev/null 2>&1 && [ -d "$HOME/.local/share/fonts" ]; then
    info "Updating font cache..."
    fc-cache -f "$HOME/.local/share/fonts"
    ok "Font cache updated."
fi

if [ -t 0 ]; then
    echo -ne "${C_BLU}[ ?? ]${C_DEF} Install SDDM theme (qylock)? [y/N]: "
    read -r reply </dev/tty || reply="N"
    if [[ "$reply" =~ ^[Yy]$ ]]; then
        tmp_dir="$(mktemp -d -t sddm-theme-XXXXXX)"
        trap 'rm -rf "$tmp_dir"' EXIT
        git clone --depth=1 https://github.com/Darkkal44/qylock.git "$tmp_dir"
        chmod +x "$tmp_dir/sddm.sh"
        bash "$tmp_dir/sddm.sh"
    fi
fi
