---
name: tmux-config
description: >-
  Use this skill when modifying tmux configuration, keybindings, status line,
  plugins, or the custom session manager script (mux) in this dotfiles repository.
---

# Tmux Configuration Guide

La configuración de Tmux combina `tmux.conf` con un gestor interactivo de proyectos y layouts llamado `mux`, ubicado en scripts de usuario.

## Ubicación de Archivos

- Configuración principal: `dot_config/tmux/tmux.conf` (desplegado en `~/.config/tmux/tmux.conf`)
- Script gestor de sesiones: `dot_local/bin/executable_mux` (desplegado en `~/.local/bin/mux`)
- Scripts auxiliares: `dot_local/bin/executable_tmux-*`

## Convenciones Principales

- **Prefijo**: `C-Space` (reemplaza el `C-b` por defecto).
- **División de paneles**: `|` o `\` para vertical, `-` para horizontal (abren en el directorio actual con `-c "#{pane_current_path}"`).
- **Navegación e interfaz**: Modo vi (`setw -g mode-keys vi`), redimensionamiento con `Shift + vim keys` (`H`, `J`, `K`, `L`).
- **Recarga rápida**: `Prefix + r` recarga la configuración activa.
- **Selector de proyectos (`mux`)**: Atajo `Prefix + o`.

## Gestor de Sesiones (`mux`)

El script `mux` maneja layouts por proyecto y almacena su estado en `$HOME/.cache/tmux-workspace/projects.json`.
Permite crear sesiones preconfiguradas con ventanas específicas (como `dev` con ventanas `zsh`, `opencode`, `nvim`).

Al editar `dot_local/bin/executable_mux`:
- Asegúrate de mantener la compatibilidad con `jq` y los comandos de bash en `set -euo pipefail`.
- El prefijo de archivo chezmoi `executable_` garantiza los permisos `+x` al aplicarse.

## Flujo de Trabajo y Validación

1. **Editar**: Modifica `dot_config/tmux/tmux.conf` o el script en `dot_local/bin/`.
2. **Aplicar cambios con chezmoi**:
   ```bash
   chezmoi apply ~/.config/tmux ~/.local/bin
   ```
3. **Validar sintaxis en tmux**:
   Si tmux está corriendo, recarga sin reiniciar el servidor:
   ```bash
   tmux source-file ~/.config/tmux/tmux.conf
   ```
   Si el script `mux` fue modificado, valida su sintaxis con bash:
   ```bash
   bash -n dot_local/bin/executable_mux
   ```

## Reglas Críticas

- Los scripts en `dot_local/bin` deben llevar el prefijo `executable_` en chezmoi.
- **Nunca hagas commit a menos que el usuario lo solicite expresamente.**
