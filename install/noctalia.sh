#!/bin/bash

_saved_opts="$(set +o)"
set -euo pipefail

NOCTALIA_DIR="$HOME/.config/noctalia"
NOCTALIA_ASSET="$INSTALL_DIR/assets/noctalia/config.toml"

if [ ! -f "$NOCTALIA_ASSET" ]; then
    err "Noctalia base config not found: $NOCTALIA_ASSET"
    exit 1
fi

if [ -f "$NOCTALIA_DIR/config.toml" ]; then
    warn "Noctalia config already exists at $NOCTALIA_DIR/config.toml. Skipping."
else
    mkdir -p "$NOCTALIA_DIR"
    cp "$NOCTALIA_ASSET" "$NOCTALIA_DIR/config.toml"
    ok "Noctalia base config installed at $NOCTALIA_DIR/config.toml"
fi

eval "$_saved_opts"
