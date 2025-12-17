# Neovim Keybindings

Complete reference for all keybindings in this Neovim configuration.

**Leader key**: `Space`

> **Note**: Some plugins with lazy loading define their keybindings within their own plugin files (e.g., completion keybinds in [lua/plugins/completion.lua](lua/plugins/completion.lua)). This document focuses on global keybindings defined in [lua/map.lua](lua/map.lua).

## Core Actions

| Key | Mode | Action |
|-----|------|--------|
| `<leader>w` | Normal | Save current file |
| `<leader>so` | Normal | Save and source current file |
| `<leader>h` | Normal/Visual/Select | Clear search highlighting |
| `<leader>s` | Normal/Visual/Select | Switch to alternate buffer |
| `<leader>y` | Normal/Visual/Select | Yank to system clipboard |
| `<leader>d` | Normal/Visual/Select | Delete to system clipboard |
| `<A-j>` | Normal/Insert | Move current line down |
| `<A-k>` | Normal/Insert | Move current line up |
| `<A-j>` | Visual/Select | Move selected lines down |
| `<A-k>` | Visual/Select | Move selected lines up |

## Window Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<C-h>` | Normal | Move to left window |
| `<C-j>` | Normal | Move to window below |
| `<C-k>` | Normal | Move to window above |
| `<C-l>` | Normal | Move to right window |

## File Navigation & Search

| Key | Mode | Action |
|-----|------|--------|
| `<leader>f` | Normal | Find files (Mini.pick) |
| `<leader>gl` | Normal | Live grep search |
| `<leader>ph` | Normal | Search help documentation |
| `<leader>e` | Normal | Open Oil file explorer |
| `<S-h>` | Normal | Toggle hidden files (in Oil) |

## Buffer Management

| Key | Mode | Action |
|-----|------|--------|
| `<leader>bn` | Normal | Next buffer |
| `<leader>bp` | Normal | Previous buffer |
| `<leader>bx` | Normal | Delete/close current buffer |

## Code Editing

| Key | Mode | Action |
|-----|------|--------|
| `<leader>/` | Normal | Toggle line comment |
| `<leader>/` | Visual | Toggle comment for selection |

## LSP (Language Server Protocol)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>lf` | Normal | Format document |
| `<leader>ld` | Normal | Go to definition |
| `<leader>lr` | Normal | Rename symbol |
| `<leader>lD` | Normal | Open diagnostic float window |

## Git Integration (Gitsigns)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gh` | Normal | Preview hunk under cursor |
| `<leader>gr` | Normal | Reset hunk under cursor |
| `<leader>gs` | Visual | Stage selected hunk |

## Copilot

| Key | Mode | Action |
|-----|------|--------|
| `<leader>cc` | Normal | Open Copilot Chat |
| `<leader>cC` | Normal | Generate commit message with Copilot |

## Plugin Management

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ll` | Normal | Open lazy.nvim plugin picker |

## Plugin-Specific Keybindings

These keybindings are defined within their respective plugin configuration files:

### Completion (nvim-cmp)
Defined in: [lua/plugins/completion.lua](lua/plugins/completion.lua)

| Key | Mode | Action |
|-----|------|--------|
| `<C-k>` | Insert | Select previous completion item |
| `<C-j>` | Insert | Select next completion item |
| `<CR>` | Insert | Confirm selection |

### DAP (Debug Adapter Protocol)
Defined in: [lua/plugins/dap.lua](lua/plugins/dap.lua)

Check the plugin file for debugging-specific keybindings.

## Customizing Keybindings

To modify or add keybindings, edit [lua/map.lua](lua/map.lua):

```lua
local map = vim.keymap.set

-- Example: Add a new keybinding
map('n', '<leader>new', ':YourCommand<CR>', { desc = "Description" })
```

### Keymap Function Signature

```lua
vim.keymap.set(mode, command, opts)
```

- **mode**: `'n'` (normal), `'i'` (insert), `'v'` (visual), `'x'` (select), or table of modes
- **command**: Command to execute.
- **opts**: Optional table with `desc`, `remap`, `silent`, etc.

## Tips

- Use `:map` to list all current mappings
- Use `:map <leader>` to see all leader key mappings
- Use `:verbose map <key>` to see where a mapping was defined
- Most plugins use `<leader>` to avoid conflicts with default Vim mappings
