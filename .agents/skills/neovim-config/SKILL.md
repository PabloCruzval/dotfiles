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
├── after/
│   └── lsp/                   # Configuraciones nativas por servidor LSP (jsonls, tailwindcss, etc.)
├── lua/
│   ├── config/
│   │   ├── lazy.lua           # Bootstrap de Lazy.nvim (importa 'plugins')
│   │   ├── plugins.lua        # Módulo central de opciones (tabla M con funciones opts/config)
│   │   ├── map.lua            # Atajos generales y navegación de ventanas/buffers
│   │   ├── keys.lua           # Tabla adicional de keymaps
│   │   └── diagnostic.lua     # Configuración de signos y mensajes de diagnóstico
│   ├── plugins/               # Especificaciones declarativas para Lazy.nvim
│   │   ├── lsp.lua            # LSP, Mason, typescript-tools, Blink.cmp y LuaSnip
│   │   ├── dap.lua            # Depuración (nvim-dap)
│   │   ├── nav.lua            # Navegación (Snacks, Oil, vim-tmux-navigator)
│   │   ├── ui.lua             # Interfaz visual (Which-key, nvim-highlight-colors)
│   │   ├── editing.lua        # Autopairs, autotag, nvim-surround, conform
│   │   ├── syntax.lua         # Treesitter, textobjects e indentación
│   │   ├── test.lua           # Neotest
│   │   ├── lint.lua           # nvim-lint
│   │   ├── git.lua            # Gitsigns
│   │   ├── typst.lua          # Soporte y previsualización para Typst
│   │   ├── cmake.lua          # Herramientas para CMake
│   │   └── theme.lua          # Esquemas de colores con lazy loading (Catppuccin, Rose Pine, Tokyo Night, Kanagawa, Gruvbox Material, Vesper, Cyberdream, OneDarkPro)
│   └── utils/
│       ├── theme.lua          # Gestión dinámica de temas, persistencia y toggle de transparencia
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
           "folke/snacks.nvim",
           opts = require("config.plugins").snacks,
       },
   }
   ```

2. **Configuración (`lua/config/plugins.lua`)**:
   - Contiene la tabla `M`.
   - Si se usa con `opts = require("config.plugins").foo`, la función retorna la tabla de opciones.
   - Si se usa con `config = require("config.plugins").foo`, la función ejecuta la configuración directamente (sin envolver en `return function()`).
   ```lua
   -- En lua/config/plugins.lua
   function M.snacks()
       return {
           picker = {
               enabled = true,
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
local servers = {
    "astro", "emmet_language_server", "jsonls", "cssls", "html", "tailwindcss",
    "lua_ls", "tinymist", "codebook", "clangd", "pyright", "ruff", "rust_analyzer",
}
```

Para activar un nuevo LSP:
1. Agrégalo a la lista `servers` de `M.mason_lspconfig`.
2. Si requiere configuración particular, crea un archivo `after/lsp/<servidor>.lua` que retorne la tabla de configuración para `vim.lsp.config`.

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
