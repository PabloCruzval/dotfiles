#!/bin/bash

export DOTFILES_DIR="$HOME/.local/share/chezmoi"
export INSTALL_DIR="$DOTFILES_DIR/install"
export REPO_URL="https://github.com/PabloCruzval/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "\033[1;34m[INFO]\033[0m Cloning dotfiles repository..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

source "$INSTALL_DIR/utils.sh"

echo ""
info "CachyOS Dotfiles Setup"
echo ""

if ask "Install extra packages?" "Y"; then
    source "$INSTALL_DIR/packages.sh"
fi

if ask "Configure Git?" "Y"; then
    source "$INSTALL_DIR/git.sh"
fi

if ask "Apply dotfiles with chezmoi?" "Y"; then
    source "$INSTALL_DIR/chezmoi.sh"
fi

if ask "Install Noctalia base config?" "Y"; then
    source "$INSTALL_DIR/noctalia.sh"
fi

if ask "Install Funnel Display font?" "Y"; then
    source "$INSTALL_DIR/font.sh"
fi

if ask "Install SDDM Theme?" "Y"; then
    source "$INSTALL_DIR/sddm.sh"
fi

echo ""
ok "Setup completed."
