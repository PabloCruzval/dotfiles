#!/bin/bash

_saved_opts="$(set +o)"
set -euo pipefail

readonly TMP_DIR=$(mktemp -d -t sddm-theme-XXXXXX)
trap 'rm -rf "$TMP_DIR"' EXIT

git clone --depth=1 https://github.com/Darkkal44/qylock.git "$TMP_DIR"

chmod +x "$TMP_DIR/sddm.sh"
source "$TMP_DIR/sddm.sh"

eval "$_saved_opts"
