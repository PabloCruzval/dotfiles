---
name: fish-config
description: >-
  Use this skill when modifying Fish shell configurations, environment variables,
  aliases, tool integrations (fzf, zoxide), or custom functions in this dotfiles repository.
---

# Fish Shell Configuration Guide

La configuración de Fish shell está estructurada en módulos numerados dentro de `conf.d/`, manteniendo `config.fish` al mínimo.

## Ubicación de Archivos

- Base: `dot_config/fish/config.fish` (desplegado en `~/.config/fish/config.fish`)
- Módulos: `dot_config/fish/conf.d/` (desplegado en `~/.config/fish/conf.d/`)

```text
dot_config/fish/
├── config.fish               # Carga la base de CachyOS y alias básico de ls (eza)
└── conf.d/
    ├── 01-env.fish           # Variables de entorno (EDITOR, BROWSER, PATH con bun/pnpm/bob)
    ├── 02-aliases.fish       # Alias comunes (dot, nv, navegación, confirmación en rm/cp/mv)
    ├── 03-tools.fish         # Integración de utilidades (fzf, zoxide, bat, fd, rg)
    └── 04-functions.fish     # Funciones de utilidad de shell (clipcat, devstart)
```

## Convenciones de Modificación

- **Nuevas variables de entorno o rutas**: Agrégalas en `01-env.fish` usando `set -gx` o `fish_add_path`.
- **Nuevos alias**: Agrégalos en `02-aliases.fish`. Si dependen de una herramienta que podría no estar instalada, agrégala con `if command -q <tool>` en `03-tools.fish`.
- **Nuevas integraciones CLI**: Usa `03-tools.fish`.
- **Nuevas funciones**: Agrégalas en `04-functions.fish` o crea un archivo `05-*.fish` si es un bloque funcional independiente.

## Flujo de Trabajo y Validación

1. **Editar**: Modifica el archivo correspondiente en `dot_config/fish/`.
2. **Validar sintaxis**:
   Usa el flag `-n` de fish para verificar errores de sintaxis antes de aplicar:
   ```bash
   fish -n dot_config/fish/conf.d/01-env.fish
   ```
3. **Aplicar cambios con chezmoi**:
   ```bash
   chezmoi apply ~/.config/fish
   ```
4. **Probar**: Inicia una subshell de fish para confirmar que cargue sin warnings ni errores:
   ```bash
   fish -c "echo 'Fish cargó correctamente'"
   ```

## Reglas Críticas

- `dot_config/fish/fish_variables` está en `.chezmoiignore`; no intentes versionar variables universales dinámicas allí.
- **Nunca hagas commit a menos que el usuario lo solicite expresamente.**
