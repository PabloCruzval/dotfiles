#!/bin/bash

REPO="PabloCruzval/dotfiles"

if ! command -v chezmoi >/dev/null 2>&1; then
    echo "chezmoi is not installed. Run packages.sh first." >&2
    exit 1
fi

info "Initializing chezmoi from $REPO..."
chezmoi init --apply "$REPO"
ok "Dotfiles applied successfully."
