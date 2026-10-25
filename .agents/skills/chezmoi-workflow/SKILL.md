---
name: chezmoi-workflow
description: >-
  Use this skill when adding new dotfiles, managing templates (.tmpl),
  working with executable scripts, or understanding chezmoi workflows in this repository.
---

# Chezmoi Workflow Guide

Este repositorio contiene los dotfiles gestionados mediante [chezmoi](https://chezmoi.io). El directorio de trabajo (`~/.local/share/chezmoi`) es directamente el origen de chezmoi.

## Convenciones de Nombres

- **`dot_`**: Se convierte en un punto (`.`) en el destino.
  - `dot_config/kitty/kitty.conf` -> `~/.config/kitty/kitty.conf`
  - `dot_gtkrc-2.0` -> `~/.gtkrc-2.0`
- **`executable_`**: Marca el archivo con permisos de ejecución (`chmod +x`).
  - `dot_local/bin/executable_mux` -> `~/.local/bin/mux`
- **`.tmpl`**: Plantilla de Go ejecutada por chezmoi al aplicar.
  - `dot_config/sioyek/prefs_user.config.tmpl` genera `~/.config/sioyek/prefs_user.config` evaluando variables como `{{ .chezmoi.hostname }}`.
- **`.chezmoiignore`**: Lista patrones excluidos del despliegue (como `.agents/`, `setup.sh`, `install/`, `**/*.md`).

## Incorporar Nuevos Archivos o Apps

Para agregar un archivo existente del sistema a chezmoi:
```bash
chezmoi add ~/.config/nueva-app/config.json
```
O si deseas crearlo manualmente en el repositorio:
- Si va en `~/.config/app/`, créalo en `dot_config/app/`.
- Si es un script en `~/.local/bin/`, nómbralo `dot_local/bin/executable_scriptname`.

## Inspección y Despliegue de Cambios

Antes de aplicar cualquier cambio, revisa la diferencia exacta con respecto al sistema real:
```bash
chezmoi diff
```

Para aplicar cambios localmente:
- Todo el repositorio:
  ```bash
  chezmoi apply
  ```
- Solo un subdirectorio o archivo específico (más rápido y seguro):
  ```bash
  chezmoi apply ~/.config/nvim
  chezmoi apply ~/.config/hypr
  ```

## Manejo de Plantillas

Para probar el renderizado de una plantilla `.tmpl` sin aplicarla:
```bash
chezmoi execute-template < dot_config/sioyek/prefs_user.config.tmpl
```

## Reglas Críticas

- **Nunca hagas commit a menos que el usuario lo solicite expresamente.**
- Si el usuario pide hacer commit, sigue el formato de `AGENTS.md`:
  ```bash
  git commit --author="<agent_name>-<username> <agent_name+user_email>" -m "<tipo>: <mensaje>"
  ```
- No toques archivos en `.gitignore` (`.env`, `.ArchConf/`, `.backup/`, etc.).
