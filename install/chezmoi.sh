#!/bin/bash

if ! command -v chezmoi >/dev/null 2>&1; then
    err "chezmoi is not installed. Run packages.sh first."
    exit 1
fi

info "Initializing chezmoi..."
chezmoi init --apply --source "$DOTFILES_DIR"
ok "Dotfiles applied successfully."
