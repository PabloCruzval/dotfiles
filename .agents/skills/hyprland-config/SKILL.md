---
name: hyprland-config
description: >-
  Use this skill when modifying Hyprland configuration, keybindings, window rules,
  animations, monitor layouts, workspaces, or autostart applications in this CachyOS dotfiles repo.
---

# Hyprland Configuration Guide

Esta configuración de Hyprland para CachyOS no usa la sintaxis tradicional de `hyprland.conf`. Está escrita completamente en **Lua** a través de la API global `hl`.

## Ubicación de Archivos

Todos los archivos viven en `dot_config/hypr/` y chezmoi los despliega en `~/.config/hypr/`.

```text
dot_config/hypr/
├── hyprland.lua              # Punto de entrada principal y detección de máquina
├── noctalia.lua              # Generado en runtime por Noctalia (ignorado en git)
├── .luarc.json               # Configuración del LSP de Lua para reconocer 'hl'
└── config/
    ├── apps.lua              # Diccionario de apps con workspace y clases
    ├── autostart.lua         # Procesos iniciados con hl.on("hyprland.start")
    ├── animations.lua        # Curvas Bézier y árbol de animaciones
    ├── binds.lua             # Atajos de teclado y mouse
    ├── colors.lua            # Definiciones de colores base
    ├── decorations.lua       # Bordes, sombras, blur y redondeo de esquinas
    ├── inputs.lua            # Teclado, mouse, touchpad y sensibilidad
    ├── misc.lua              # Opciones misceláneas de Hyprland
    ├── monitors-desktop.lua  # Monitores y tasas de refresco para el escritorio (t-nyx)
    ├── monitors-laptop.lua   # Monitores para laptop (eDP-1)
    ├── variables.lua         # Variables globales (TERMINAL, EDITOR, etc.)
    ├── windowrules.lua       # Reglas de ventanas, flotantes y gaming
    └── workspaces.lua        # Asignación de espacios de trabajo a monitores
```

## Detección de Hostname

El archivo [hyprland.lua](file:///home/nyx/.local/share/chezmoi/dot_config/hypr/hyprland.lua) lee `/etc/hostname`:

- Si es `t-nyx`, carga `config.monitors-desktop`.
- En cualquier otro caso, asume laptop, define `MONITOR1 = "eDP-1"` y carga `config.monitors-laptop`.

Al agregar monitores o cambiar layouts, mantén esta separación para evitar romper el entorno móvil o de escritorio.

## Sintaxis de la API `hl`

### Atajos (`config/binds.lua`)
Usa `hl.bind(keys, dispatcher)`.
```lua
local mainMod = "SUPER"
local launchPrefix = "uwsm app -- "

-- Lanzar aplicación vía uwsm
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(launchPrefix .. TERMINAL))

-- Dispatchers comunes de ventana
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))

-- Noctalia IPC
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("noctalia msg session lock"))
```

### Reglas de Ventana (`config/windowrules.lua`)
Usa `hl.window_rule(table)`.
```lua
hl.window_rule({
    match = { class = "^(steam)$", title = "^(Friends List)$" },
    float = true,
})

-- Soporte para gaming
local gamingWorkspace = "name:gaming"
hl.window_rule({
    match = { class = "^(steam_app.*|gamescope)$" },
    workspace = gamingWorkspace,
    fullscreen_state = 2,
    sync_fullscreen = true,
})
```

### Autostart (`config/autostart.lua`)
```lua
hl.on("hyprland.start", function ()
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("syncthing --no-browser")
end)
```

## Flujo de Trabajo y Validación

1. **Editar**: Modifica el archivo correspondiente en `dot_config/hypr/config/`.
2. **Aplicar cambios con chezmoi**:
   ```bash
   chezmoi apply ~/.config/hypr
   ```
3. **Recargar Hyprland**:
   ```bash
   hyprctl reload
   ```
4. **Verificar errores**:
   ```bash
   hyprctl messages
   ```
   O revisar el log en vivo si una regla falla:
   ```bash
   tail -n 30 ~/.local/share/hyprland/hyprland.log
   ```

## Reglas Críticas

- No agregues archivos `.conf` estándar de Hyprland a menos que se importen explícitamente desde Lua. Todo se gestiona en Lua.
- Recuerda que `noctalia.lua` se genera dinámicamente; no lo sobreescribas a mano en git.
- **Nunca hagas commit a menos que el usuario lo solicite expresamente.**
