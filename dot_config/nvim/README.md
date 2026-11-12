# Neovim

Neovim 0.12 configuration focused on web development, with Typst and LaTeX support. Uses lazy.nvim for plugins and native Neovim LSP (`vim.lsp.config`).

`init.lua` sets core options (relative line numbers, wrap with linebreak, persistent undo, no swapfile, rounded borders) and basic autocommands. The rest is modular inside `lua/`:
- `plugins/` has one file per area (lsp, navigation, editing, git, dap, test, typst, latex).
- `config/plugins.lua` concentrates plugin option tables so specs stay concise.
- Global keymaps live in `config/map.lua`, plugin bindings in each plugin spec under `lua/plugins/` (`keys = {}`). Leader is `Space`.

## Keymaps

Leader is `Space`. The ones I use most:

- `<leader>e`: file explorer (Oil)
- `<leader>pf` / `<leader>gl`: find files / live grep (Snacks)
- `<leader>tt`: toggle terminal
- `gd`, `gr`, `<leader>lr`, `<leader>la`: definition, references, rename, code actions (when the server supports them)
- `<leader>Db`, `<leader>Dc`: DAP breakpoint and continue
- `<leader>tn`, `<leader>tf`: run nearest test / current file

Global ones are in `config/map.lua`. Plugin ones sit next to each plugin in `lua/plugins/`.

## Languages

Mason manages most language servers: astro, emmet, jsonls, cssls, html, tailwindcss, lua_ls, tinymist, codebook, clangd, pyright, ruff, rust_analyzer, and texlab. Server overrides live in `after/lsp/`. For instance, clangd starts with clang-tidy and `--header-insertion=iwyu`. `ruby-lsp` isn't installed through Mason: `config/plugins.lua` enables it with `vim.lsp.enable("ruby_lsp")` and `after/lsp/ruby_lsp.lua` sets `mason = false`.

TypeScript uses typescript-tools.nvim rather than standard lspconfig. It looks for `tsserver.js` in local `node_modules` or `.yarn/sdks` and allocates 4 GB of memory.

Formatting is manual via conform.nvim (prettierd/prettier for web, stylua for Lua, ruff for Python, rustfmt for Rust, latexindent or tex-fmt for LaTeX). Linting runs through nvim-lint.

## Writing

For Typst, tinymist and typst-preview.nvim handle editing (`<leader>tp` toggles preview). `codebook` checks spelling for Typst files at `hint` severity so it doesn't clutter diagnostics. `:WordCount` provides a quick word count and reading time estimate.

For LaTeX, vimtex and texlab handle compilation and forward/inverse search into Zathura via SyncTeX.

## Workarounds

In `config/plugins.lua`, `vim.lsp._watchfiles._watchfunc` is overridden with an empty function and `didChangeWatchedFiles` is disabled across servers to prevent file-watching overhead. It's wrapped in `pcall` since it touches an internal Neovim module.

Theme choice persists in `stdpath("state")/theme.txt` (default is catppuccin-mocha with transparency). `utils/theme.lua` manages supported themes across sessions.

## Dependencies

Requires Neovim 0.12+, git, ripgrep, node, npm, and a Nerd Font. Run `:checkhealth` or `:Lazy sync` if setup needs troubleshooting on a fresh install.
