# Neovim Configuration

Modern, minimal Neovim setup focused on efficiency and language support, managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Overview

This configuration emphasizes:
- **Lazy loading** for fast startup times
- **Modular plugin organization** by functionality
- **LSP-first approach** with native Neovim LSP
- **Minimal keybindings** centered around Space leader key
- **Clean aesthetics** with Nord theme and transparency

## Structure

```
nvim/
├── init.lua                    # Entry point and core settings
├── lazy-lock.json              # Plugin version lock file
├── lua/
│   ├── lazy_config.lua         # Lazy.nvim setup
│   ├── map.lua                 # All keybindings
│   ├── lsp/
│   │   └── main.lua            # LSP configuration
│   ├── plugins/                # Plugin specifications
│   │   ├── completion.lua      # nvim-cmp + Copilot
│   │   ├── dap.lua             # Debug Adapter Protocol
│   │   ├── dependencies.lua    # Plugin dependencies
│   │   ├── editing.lua         # Autopairs + autotag
│   │   ├── mason.lua           # LSP server installer
│   │   ├── navigation.lua      # Oil + Mini.pick
│   │   ├── nvim-treesitter.lua # Syntax highlighting
│   │   ├── rustaceanvim.lua    # Rust tooling
│   │   ├── tools.lua           # Git, Markdown, Chezmoi
│   │   └── ui.lua              # Theme + transparency
│   └── utils/
│       ├── lazy_picker.lua     # Plugin picker utility
│       └── tmpl_files.lua      # Template file handling
└── readme.md                   # This file
```

## Features

### Core Functionality
- **Line numbers**: Relative with absolute current line
- **Tabs**: 4 spaces, no swap files
- **Sign column**: Always visible for diagnostics
- **Status line**: Transparent background

### Plugins by Category

#### Completion & AI
- **nvim-cmp**: Autocompletion with LSP, buffer, and path sources
- **GitHub Copilot**: AI-powered code suggestions
- **CopilotChat**: Interactive Copilot conversations

#### Navigation
- **Oil.nvim**: Edit filesystem like a buffer
- **Mini.pick**: Fuzzy finder for files, grep, help

#### Language Support
- **Native LSP**: Lua, Rust, TypeScript, QML, Tailwind, Astro
- **Mason**: Automatic LSP server management
- **Treesitter**: Advanced syntax highlighting
- **Rustaceanvim**: Enhanced Rust development

#### Editing
- **nvim-autopairs**: Auto-close brackets and quotes
- **nvim-ts-autotag**: Auto-close/rename HTML/JSX tags
- **Mini.comment**: Smart code commenting

#### Tools
- **Gitsigns**: Inline Git status and actions
- **Markview**: Enhanced Markdown preview
- **Chezmoi**: Template syntax support for .tmpl files

#### UI
- **Nord**: Clean, dark color scheme
- **Transparent.nvim**: Background transparency

## Keybindings

**Leader key**: `Space`

For a complete reference of all keybindings, see [keybindings.md](keybindings.md).

Quick reference for most common actions:
- `<leader>w` - Save file
- `<leader>f` - Find files
- `<leader>e` - File explorer (Oil)
- `<leader>gl` - Live grep
- `<leader>lf` - Format code
- `<leader>/` - Toggle comment

> **Note**: Some plugin-specific keybindings (like completion shortcuts) are defined within their respective plugin files due to lazy loading.

## Installation

### Prerequisites

```bash
# Neovim 0.10+ (using bob version manager)
yay -S bob
bob install stable
bob use stable

# Node.js (for some LSP servers)
sudo pacman -S nodejs npm

# Ripgrep (for grep functionality)
sudo pacman -S ripgrep

# Clipboard support
sudo pacman -S wl-clipboard  # Wayland
# or
sudo pacman -S xclip         # X11
```

### Language Servers

The configuration auto-installs these LSP servers via Mason:
- `lua_ls` - Lua
- `rust_analyzer` - Rust
- `ts_ls` - TypeScript/JavaScript
- `tailwindcss` - Tailwind CSS
- `qmlls` - QML
- `astro` - Astro
- `emmet_ls` - Emmet

### First Launch

1. Open Neovim - plugins will auto-install:
   ```bash
   nvim
   ```

2. Wait for lazy.nvim to install all plugins

3. Restart Neovim if needed

4. LSP servers will be installed automatically via Mason

## Customization

### Adding Plugins

Create a new file in `lua/plugins/` or add to an existing category:

```lua
return {
    {
        "author/plugin-name",
        opts = {},
        config = function()
            -- setup code
        end
    }
}
```

### Changing Theme

Edit [lua/plugins/ui.lua](lua/plugins/ui.lua):
```lua
return {
    {
        "your-preferred-theme/theme-name"
    }
}
```

Update [init.lua](init.lua):
```lua
vim.cmd([[colorscheme your-theme]])
```

### Adding LSP Servers

Edit [lua/plugins/mason.lua](lua/plugins/mason.lua) to add to `ensure_installed`:
```lua
opts = {
    ensure_installed = { "lua_ls", "your_new_server" }
}
```

Edit [lua/lsp/main.lua](lua/lsp/main.lua) to enable the server:
```lua
local lsps = { "lua_ls", "your_new_server" }
```

### Modifying Keybindings

All keybindings are centralized in [lua/map.lua](lua/map.lua). Edit that file to customize shortcuts.

## Troubleshooting

### Plugins Not Loading
```vim
:Lazy sync
```

### LSP Not Working
```vim
:Mason
```
Check if the LSP server is installed. If not, press `i` to install.

### Check LSP Status
```vim
:LspInfo
```

### Clear Plugin Cache
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```

## License

Part of the [Nyx dotfiles](../../README.md) project. Open source under MIT License.
