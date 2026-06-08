local M = {}

-----------
--  LSP  --
-----------

function M.mason()
    return {}
end

function M.mason_lspconfig()
    return {
        ensure_installed = {
            "vtsls",
            "astro",
            "emmet_language_server",
            "jsonls",
            "cssls",
            "html",
            "tailwindcss",
            "lua_ls",
        },
    }
end

function M.blink_cmp()
    return {
        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
        },
        keymap = {
            preset = "default",
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
        },
        completion = {
            accept = {
                auto_brackets = { enabled = true },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                treesitter_highlighting = true,
                window = { border = "rounded" },
            },
            ghost_text = {
                enabled = true,
            },
            list = {
                selection = { preselect = true, auto_insert = false },
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        signature = {
            enabled = true,
        },
    }
end

-----------
--  NAV  --
-----------

function M.oil()
    return {}
end

function M.mini_pick()
    return {}
end

--------------
--  SYNTAX  --
--------------

function M.treesitter()
    return function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "astro",
                "css",
                "typescript",
                "tsx",
                "javascript",
                "html",
                "python",
                "rust",
                "lua",
                "vim",
                "vimdoc",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
        })
    end
end

function M.guess_indent()
    return function()
        require("guess-indent").setup({})
    end
end

----------
--  UI  --
----------

function M.ui()
    return {}
end

---------------
--  EDITING  --
---------------

function M.autopairs()
    return {
        check_ts = true,
    }
end

function M.autotag()
    return {
        opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = false,
        },
    }
end

function M.conform()
    return {
        formatters_by_ft = {
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "prettierd", "prettier", stop_after_first = true },
            css = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            jsonc = { "prettierd", "prettier", stop_after_first = true },
            astro = { "prettierd", "prettier", stop_after_first = true },
            lua = { "stylua" },
            python = { "ruff_format" },
            markdown = { "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = nil,
    }
end

---------
--  GIT --
---------

function M.gitsigns()
    return {
        signs = {
            add          = { text = "┃" },
            change       = { text = "┃" },
            delete       = { text = "_" },
            topdelete    = { text = "‾" },
            changedelete = { text = "~" },
            untracked    = { text = "┆" },
        },
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "Git: " .. desc })
            end
            map("]c", function() gs.nav_hunk("next") end, "Next hunk")
            map("[c", function() gs.nav_hunk("prev") end, "Prev hunk")
            map("<leader>gh", gs.preview_hunk, "Preview hunk")
            map("<leader>gr", gs.reset_hunk, "Reset hunk")
            map("<leader>gs", function() gs.stage_hunk() end, "Stage hunk")
        end,
    }
end

return M
