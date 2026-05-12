#!/bin/bash

set -euo pipefail

FUNNEL_DISPLAY_URL="https://gwfh.mranftl.com/api/fonts/funnel-display?download=zip&subsets=latin&variants=300,500,600,700,800,regular&formats=woff2"
FONT_DIR="$HOME/.local/share/fonts"

for cmd in curl unzip fc-cache; do
    if ! command -v "$cmd" &> /dev/null; then
        err "Falta el comando: $cmd. Por favor, instálalo."
        exit 1
    fi
done

if [ ! -d "$FONT_DIR" ]; then
    mkdir -p "$FONT_DIR"
    info "Directorio de fuentes creado: $FONT_DIR"
fi

tmp_zip=$(mktemp)
trap 'rm -f "$tmp_zip"' EXIT

info "Descargando fuente..."
curl -sL "$FUNNEL_DISPLAY_URL" -o "$tmp_zip"
ok "Descarga completada con éxito."

info "Extrayendo en $FONT_DIR..."
unzip -qo "$tmp_zip" -d "$FONT_DIR"
ok "Archivos extraídos."

info "Actualizando la caché de fuentes..."
fc-cache -f "$FONT_DIR"
ok "Tipografía instalada y lista para usar."
