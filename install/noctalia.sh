#!/bin/bash

_saved_opts="$(set +o)"
set -euo pipefail

NOCTALIA_DIR="$HOME/.config/noctalia"
NOCTALIA_ASSET="$INSTALL_DIR/assets/noctalia/config.toml"

if [ ! -f "$NOCTALIA_ASSET" ]; then
    err "Noctalia base config not found: $NOCTALIA_ASSET"
    exit 1
fi

mkdir -p "$NOCTALIA_DIR"

if [ -f "$NOCTALIA_DIR/config.toml" ]; then
    cp "$NOCTALIA_DIR/config.toml" "$NOCTALIA_DIR/config.toml.bak"
    ok "Backed up existing config to $NOCTALIA_DIR/config.toml.bak"
fi

cp "$NOCTALIA_ASSET" "$NOCTALIA_DIR/config.toml"
ok "Noctalia base config installed at $NOCTALIA_DIR/config.toml"

eval "$_saved_opts"
