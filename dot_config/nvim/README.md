<div align="center">

# Neovim Configuration

**Modern development environment powered by lazy.nvim**

</div>

Personal Neovim configuration for web development featuring modular lazy-loading, native LSP, blink.cmp completion, and Kanagawa aesthetics.

## ✨ Features

- **⚡ Lazy Loading** - Plugins load only when needed via lazy.nvim for fast startup
- **🔧 Native LSP** - Zero-overhead language server integration (vtsls, tailwindcss, lua_ls, astro, more)
- **🧠 blink.cmp** - Performant autocompletion with ghost text, auto-brackets, and signature help
- **📐 conform.nvim** - Manual multi-formatter orchestration (prettierd, stylua, ruff\_format)
- **🏷️ nvim-ts-autotag** - Treesitter-powered auto-closing and renaming of HTML/JSX tags
- **🔗 nvim-autopairs** - Smart bracket, quote, and HTML tag pair completion
- **🔍 Git Signs** - Inline git change indicators, hunk staging, preview, and blame
- **🗂️ Oil + Mini.pick** - Edit filesystem as a buffer + fuzzy picker for files/grep/buffers
- **📦 JSON Schema Validation** - Automatic schema detection via SchemaStore for `package.json`, `tsconfig.json`, etc.
- **🎨 Kanagawa Theme** - Warm, vibrant color scheme with rounded borders and transparent statusline
- **📋 Diagnostic Signs** - Custom Nerd Font icons for errors, warnings, info, and hints
- **🖥️ Integrated Terminal** - Toggle floating/split terminal with session persistence

## 📁 Structure

```
nvim/
├── init.lua                        # Entry point & core options
├── lua/
│   ├── config/
│   │   ├── lazy.lua                # lazy.nvim bootstrap & setup
│   │   ├── map.lua                 # Global keymaps & LspAttach handlers
│   │   ├── diagnostic.lua          # Diagnostic display configuration
│   │   ├── plugins.lua             # Centralized plugin option definitions
│   │   └── lsp.lua                 # (reserved)
│   ├── plugins/
│   │   ├── lsp.lua                 # LSP, Mason, blink.cmp, SchemaStore
│   │   ├── nav.lua                 # oil.nvim, mini.pick
│   │   ├── syntax.lua              # nvim-treesitter, guess-indent
│   │   ├── editing.lua             # nvim-autopairs, nvim-ts-autotag, conform.nvim
│   │   ├── git.lua                 # gitsigns.nvim
│   │   ├── theme.lua               # kanagawa.nvim
│   │   └── ui.lua                  # (reserved)
│   └── utils/
│       └── terminal.lua            # Toggle terminal utility
└── after/
    └── lsp/
        ├── vtsls.lua               # TypeScript/JavaScript LSP config
        ├── astro.lua               # Astro LSP config
        ├── jsonls.lua              # JSON LSP with SchemaStore
        ├── tailwindcss.lua         # Tailwind CSS LSP config
        └── emmet_language_server.lua # Emmet LSP config
```

---

## 🧩 Plugin Overview

<details>
<summary><b>Completion & Intelligence</b></summary>

<br>

| Plugin | Purpose |
|--------|---------|
| [blink.cmp](https://github.com/saghen/blink.cmp) | Performant autocompletion with LSP, path, buffer, and snippet sources |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Pre-built snippet collection |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP server configuration |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP/formatter/linter package manager |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Bridge between Mason and lspconfig |

</details>

<details>
<summary><b>Editing & Formatting</b></summary>

<br>

| Plugin | Purpose |
|--------|---------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets, quotes, and HTML tags |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Treesitter-based HTML/JSX tag renaming |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Multi-formatter runner (manual trigger) |
| [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) | Automatic indent detection |

</details>

<details>
<summary><b>Navigation & UI</b></summary>

<br>

| Plugin | Purpose |
|--------|---------|
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer as an editable buffer |
| [mini.pick](https://github.com/echasnovski/mini.pick) | Fuzzy picker (files, buffers, grep, help) |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Advanced syntax highlighting & parsing |
| [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | Warm, inspired color scheme |

</details>

<details>
<summary><b>Git Integration</b></summary>

<br>

| Plugin | Purpose |
|--------|---------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Inline git decorations, hunk ops, blame |

</details>

<details>
<summary><b>Tooling</b></summary>

<br>

| Plugin | Purpose |
|--------|---------|
| [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim) | Auto-detect JSON/YAML schemas from the SchemaStore catalog |

</details>

---

## 🧠 Language Servers

Installed automatically via Mason. Configured in [`after/lsp/`](after/lsp/):

| Server | Config | Purpose |
|--------|--------|---------|
| **vtsls** | [`after/lsp/vtsls.lua`](after/lsp/vtsls.lua) | TypeScript/JavaScript — inlay hints, auto-imports, server-side fuzzy |
| **astro** | [`after/lsp/astro.lua`](after/lsp/astro.lua) | Astro framework LSP |
| **emmet\_language\_server** | [`after/lsp/emmet_language_server.lua`](after/lsp/emmet_language_server.lua) | Emmet abbreviation expansion in HTML/CSS/JSX |
| **jsonls** | [`after/lsp/jsonls.lua`](after/lsp/jsonls.lua) | JSON/JSONC with SchemaStore validation |
| **cssls** | — | CSS/SCSS/Less language support |
| **html** | — | HTML language support |
| **tailwindcss** | [`after/lsp/tailwindcss.lua`](after/lsp/tailwindcss.lua) | Tailwind CSS class completion |
| **lua\_ls** | — | Lua language server (for config editing) |

---

## ⌨️ Keybindings

**Leader key**: `Space`

<details>
<summary><b>Core Actions</b></summary>

<br>

| Key | Mode | Action |
|-----|------|--------|
| `<leader>w` | Normal | Save file |
| `<leader>so` | Normal | Save and source current file |
| `<leader>y` | Normal/Visual/Select | Yank to system clipboard |
| `<leader>d` | Normal/Visual/Select | Delete to system clipboard |
| `<leader>s` | Normal/Visual/Select | Switch to alternate buffer |
| `<leader>h` | Normal/Visual/Select | Clear search highlighting |
| `<A-j>` / `<A-k>` | Normal/Insert | Move line down/up |
| `<A-j>` / `<A-k>` | Visual/Select | Move selected lines down/up |
| `<ESC>` | Terminal | Exit terminal mode |

</details>

<details>
<summary><b>Window Navigation</b></summary>

<br>

| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to window below |
| `<C-k>` | Move to window above |
| `<C-l>` | Move to right window |

</details>

<details>
<summary><b>LSP Actions</b></summary>

<br>

| Key | Action |
|-----|--------|
| `<leader>lf` | Format buffer (LSP) |
| `<leader>fm` | Format buffer (conform.nvim, manual) |
| `<leader>ld` | Go to definition |
| `<leader>lr` | Rename symbol |
| `<leader>lh` | Show hover documentation |
| `<leader>lD` | Open diagnostic float |

</details>

<details>
<summary><b>File Navigation & Search</b></summary>

<br>

| Key | Action |
|-----|--------|
| `<leader>pf` | Find files (Mini.pick) |
| `<leader>pb` | Find buffers (Mini.pick) |
| `<leader>gl` | Live grep search |
| `<leader>ph` | Search help documentation |
| `<leader>e` | Open Oil file explorer |
| `<S-h>` | Toggle hidden files (Oil) |

</details>

<details>
<summary><b>Buffer Management</b></summary>

<br>

| Key | Action |
|-----|--------|
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>bx` | Delete/close current buffer |

</details>

<details>
<summary><b>Editing</b></summary>

<br>

| Key | Mode | Action |
|-----|------|--------|
| `<leader>/` | Normal | Toggle line comment |
| `<leader>/` | Visual | Toggle comment for selection |

**Completion (Insert mode)**:
| Key | Action |
|-----|--------|
| `<Tab>` | Select next / fallback |
| `<S-Tab>` | Select previous / fallback |
| `<CR>` | Accept selected item |

</details>

<details>
<summary><b>Git (Gitsigns)</b></summary>

<br>

| Key | Action |
|-----|--------|
| `<leader>gh` | Preview hunk under cursor |
| `<leader>gr` | Reset hunk under cursor |
| `<leader>gs` | Stage selected hunk (visual) |
| `]c` | Next hunk |
| `[c` | Previous hunk |

</details>

<details>
<summary><b>Terminal</b></summary>

<br>

| Key | Action |
|-----|--------|
| `<leader>ts` | Toggle terminal |

</details>

---

## 🎨 Visual Design

<details>
<summary><b>Appearance</b></summary>

<br>

- **Theme**: [Kanagawa](https://github.com/rebelot/kanagawa.nvim) — warm, vibrant color palette inspired by the classic ukiyo-e painting
- **Borders**: Rounded (`winborder = "rounded"`)
- **Statusline**: Transparent background (`guibg=NONE`)
- **Line Numbers**: Relative with absolute current line
- **Sign Column**: Always visible for diagnostics and git signs
- **Diagnostic Icons**: Nerd Font symbols — ` ` Error, ` ` Warning, ` ` Hint, ` ` Info

</details>

<details>
<summary><b>Diagnostic Configuration</b></summary>

<br>

Configured in [`lua/config/diagnostic.lua`](lua/config/diagnostic.lua):

- Virtual text with dot prefix and source indicator
- Rounded floating windows with source always shown
- Severity-sorted diagnostics
- Signs defined for `Error`, `Warn`, `Hint`, `Info`

</details>

---

## 🔧 Core Options

Configured in [`init.lua`](init.lua):

```lua
wrap = true              -- Soft line wrapping
tabstop = 4              -- Tab width
shiftwidth = 4           -- Indentation width
signcolumn = "yes"       -- Always show sign column
swapfile = false         -- No swap files
relativenumber = true    -- Relative line numbers
number = true            -- Show absolute current line
termguicolors = true     -- True color support
winborder = "rounded"    -- Rounded window borders
```

---

## 📦 Dependencies

<details>
<summary><b>Required</b></summary>

<br>

- **Neovim 0.10+** (0.11 recommended for native LSP config support)
- **Git** — plugin management and gitsigns
- **Nerd Font** — diagnostic and UI icons
- **Ripgrep** — live grep search (`:Pick grep_live`)
- **npm/node** — LSP server installation via Mason

</details>

<details>
<summary><b>Recommended Packages (via Mason)</b></summary>

<br>

Open `:Mason` inside Neovim or they auto-install on first file open:

**LSP Servers**:
```bash
# Installed automatically via mason-lspconfig ensure_installed
@vtsls/language-server    # TypeScript/JavaScript
astro-ls                   # Astro framework
emmet-language-server      # Emmet abbreviations
vscode-langservers-extracted # HTML, CSS, JSON
@tailwindcss/language-server # Tailwind CSS
lua-language-server        # Lua
```

**Formatters** (install manually if needed):
```bash
:MasonInstall prettierd    # JavaScript, TypeScript, CSS, HTML, JSON
:MasonInstall stylua       # Lua
:MasonInstall ruff         # Python (includes ruff_format)
```

</details>

---

## 🔍 Troubleshooting

<details>
<summary><b>Plugins Not Loading</b></summary>

<br>

```vim
:Lazy sync    " Sync and update all plugins
:Lazy         " Open lazy.nvim UI to check plugin status
```

</details>

<details>
<summary><b>LSP Not Working</b></summary>

<br>

```vim
:Mason          " Check if LSP server is installed
:LspInfo        " Check LSP client status for current buffer
:checkhealth    " Run Neovim health check
```

Press `i` in Mason to install a server.

</details>

<details>
<summary><b>Treesitter Parsers</b></summary>

<br>

```vim
:TSInstall {language}   " Install a parser manually
:TSInstallInfo          " List installed parsers
```

</details>

<details>
<summary><b>Formatter Not Working</b></summary>

<br>

```vim
:ConformInfo    " Check available formatters for current filetype
```

Install missing formatters via Mason or system package manager.

</details>

<details>
<summary><b>Full Reset</b></summary>

<br>

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```

Then restart Neovim to reinstall everything.

</details>

---

## 💡 Tips

- **Save without formatting**: Use `:w` directly (no auto-format on save)
- **Manual format**: `<leader>fm` in normal or visual mode
- **Quick file tree**: `<leader>e` opens oil.nvim — edit paths like a buffer
- **Find files**: `<leader>pf` uses Mini.pick with fuzzy matching
- **Stage hunks**: Select lines visually, then `<leader>gs`
- **Preview git changes**: `<leader>gh` shows hunk diff inline
- **Toggle terminal**: `<leader>ts` opens a persistent split terminal
- **Config editing**: Changes to `init.lua` or any config file — use `<leader>so` to source
- **JSON validation**: Opening `package.json` or `tsconfig.json` auto-loads the correct schema

---

## 🔗 Related Configurations

- **[Hyprland](../hypr/README.md)** — Wayland compositor
- **[Kitty](../kitty/kitty.conf)** — Terminal emulator
- **[Quickshell](../quickshell/README.md)** — Status bar
- **[Main Dotfiles](../../README.md)** — Complete dotfiles documentation

---

<div align="center">

Part of **[Nyx's Dotfiles](../../README.md)**

Open source under GPLv3 License

</div>
