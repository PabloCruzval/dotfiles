---
name: neovim-config
description: >-
  Use this skill when modifying Neovim settings, plugins, LSP, Mason tools,
  themes, keybindings, or utility scripts in this dotfiles repository.
---

# Neovim Configuration Guide

La configuración de Neovim utiliza **Lazy.nvim** como gestor de plugins con una separación clara entre la declaración de plugins y la lógica de configuración de cada uno.

## Ubicación de Archivos

Todos los archivos residen en `dot_config/nvim/` y chezmoi los despliega en `~/.config/nvim/`.

```text
dot_config/nvim/
├── init.lua                   # Opciones básicas (vim.opt), colorscheme y arranque
├── lua/
│   ├── config/
│   │   ├── lazy.lua           # Bootstrap de Lazy.nvim (importa 'plugins')
│   │   ├── plugins.lua        # Módulo central de opciones (tabla M con funciones opts)
│   │   ├── map.lua            # Atajos generales y navegación de ventanas/buffers
│   │   ├── keys.lua           # Tabla adicional de keymaps
│   │   ├── diagnostic.lua     # Configuración de signos y mensajes de diagnóstico
│   │   └── jsonls.lua         # Integración de esquemas JSON
│   ├── plugins/               # Especificaciones declarativas para Lazy.nvim
│   │   ├── lsp.lua            # LSP, Mason, Blink.cmp y LuaSnip
│   │   ├── dap.lua            # Depuración (nvim-dap)
│   │   ├── nav.lua            # Navegación (Telescope, Oil, etc.)
│   │   ├── ui.lua             # Interfaz visual (Lualine, Trouble, etc.)
│   │   ├── editing.lua        # Auto-completado de pares, surround, comentarios
│   │   ├── syntax.lua         # Treesitter e indentación
│   │   ├── test.lua           # Neotest
│   │   ├── lint.lua           # nvim-lint
│   │   ├── git.lua            # Gitsigns y herramientas git
│   │   ├── typst.lua          # Soporte y previsualización para Typst
│   │   ├── cmake.lua          # Herramientas para CMake
│   │   └── theme.lua          # Configuración de temas
│   └── utils/
│       ├── tinymist_status.lua# Estado del compilador de Typst
│       └── wordcount.lua      # Contador de palabras
```

## Arquitectura de Plugins: La Regla de Oro

El proyecto mantiene una separación estricta:

1. **Declaración (`lua/plugins/*.lua`)**:
   - Cada archivo retorna una lista de plugins para Lazy.
   - Para las opciones de configuración, delega en `lua/config/plugins.lua`.
   ```lua
   -- En lua/plugins/nav.lua
   return {
       {
           "nvim-telescope/telescope.nvim",
           opts = require("config.plugins").telescope,
       },
   }
   ```

2. **Configuración (`lua/config/plugins.lua`)**:
   - Contiene la tabla `M`.
   - Cada función retorna la tabla de opciones o la función de configuración.
   ```lua
   -- En lua/config/plugins.lua
   function M.telescope()
       return {
           defaults = {
               -- opciones aquí
           },
       }
   end
   ```

Al añadir un plugin nuevo o modificar uno existente:
- Agrega la especificación de Lazy en el archivo adecuado dentro de `lua/plugins/`.
- Coloca sus opciones detalladas dentro de la función respectiva en `lua/config/plugins.lua`.

## Gestión de LSPs y Herramientas

Los servidores LSP instalados automáticamente están definidos en `lua/config/plugins.lua` bajo `M.mason_lspconfig`:

```lua
ensure_installed = {
    "vtsls", "jsonls", "lua_ls", "tinymist", "clangd", "pyright", "ruff", "rust_analyzer", ...
}
```

Para activar un nuevo LSP:
1. Agrégalo a la lista `ensure_installed` de `M.mason_lspconfig`.
2. Si requiere configuración particular de `lspconfig`, configúralo en `M.lspconfig` dentro de `lua/config/plugins.lua`.

## Flujo de Trabajo y Validación

1. **Editar**: Modifica el archivo correspondiente en `dot_config/nvim/`.
2. **Aplicar cambios con chezmoi**:
   ```bash
   chezmoi apply ~/.config/nvim
   ```
3. **Validar sintaxis sin entorno gráfico**:
   Ejecuta Neovim en modo headless para capturar errores de Lua o dependencias rotas:
   ```bash
   nvim --headless "+quit"
   ```
4. **Sincronizar plugins (si añadiste o removiste uno)**:
   ```bash
   nvim --headless "+Lazy! sync" +qa
   ```

## Reglas Críticas

- No agregues código de configuración extenso dentro de los archivos en `lua/plugins/`; trasládalo a `lua/config/plugins.lua`.
- Mapeos globales van en `lua/config/map.lua`; mapeos exclusivos de un plugin van en su respectiva configuración o en el campo `keys` de la especificación de Lazy.
- **Nunca hagas commit a menos que el usuario lo solicite expresamente.**
