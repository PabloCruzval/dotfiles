#!/bin/bash

export DOTFILES_DIR="$HOME/.local/share/chezmoi"
export INSTALL_DIR="$DOTFILES_DIR/install"
export REPO_URL="https://github.com/PabloCruzval/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "\033[1;34m[INFO]\033[0m Cloning base repository..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

source "$INSTALL_DIR/utils.sh"

echo ""
info "Welcome to the Nyx Dotfiles installation"
echo ""

if ask "Install packages (Official repos and AUR)?" "Y"; then
    source "$INSTALL_DIR/pkgs.sh" 
fi

if ask "Configure Nvidia?" "Y"; then
    source "$INSTALL_DIR/nvidia.sh"
fi

if ask "Enable system and user services (Bluetooth, Theme Timer)?" "Y"; then
    source "$INSTALL_DIR/services.sh"
    source "$INSTALL_DIR/sddm.sh"
fi

if ask "Apply dotfiles with Chezmoi (automatic backups will be made)?" "Y"; then
    source "$INSTALL_DIR/chezmoi.sh"
fi

echo ""
ok "Installation completed successfully!"
info "Check the guide at: $DOTFILES_DIR/troubleshoot.md if you have issues."