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
            "tinymist",
            "codebook",
            "clangd",
            "pyright",
            "ruff",
            "rust_analyzer",
        },
        automatic_enable = {
            "vtsls",
            "astro",
            "emmet_language_server",
            "jsonls",
            "cssls",
            "html",
            "tailwindcss",
            "lua_ls",
            "tinymist",
            "codebook",
            "clangd",
            "pyright",
            "ruff",
            "rust_analyzer",
        },
    }
end

function M.mason_tool_installer()
    return {
        ensure_installed = {
            "eslint_d",
            "stylua",
            "prettierd",
            "ruff",
            "js-debug-adapter",
            "codelldb",
            "debugpy",
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
        snippets = { preset = "luasnip" },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        signature = {
            enabled = true,
        },
    }
end

function M.clangd_extensions()
    return {
        inlay_hints = {
            inline = false,
        },
    }
end

-----------
--  NAV  --
-----------

function M.oil()
    return {
		columns = {
			"icon",
		},
        win_options = {
            signcolumn = "auto:1",
        },
        keymaps = {
            ["<C-h>"] = false,
            ["<C-l>"] = false,
        },
    }
end

function M.oil_git()
    return {
        symbol_position = "signcolumn",
        show_ignored_files = true,
        show_ignored_directories = true,
    }
end

function M.snacks()
    return {
        picker = {
            enabled = true,
            ui_select = true,
        },
    }
end

--------------
--  SYNTAX  --
--------------

function M.treesitter()
    return function()
        require("nvim-treesitter").setup()
        require("nvim-treesitter").install({
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
            "typst",
            "ruby",
            "cpp",
        })

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("TreesitterNative", { clear = true }),
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
                pcall(function()
                    vim.bo[args.buf].indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"
                end)
            end,
        })
    end
end

function M.textobjects()
    return function()
        require("nvim-treesitter-textobjects").setup({
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]a"] = "@parameter.inner",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[a"] = "@parameter.inner",
                },
            },
        })
    end
end

function M.guess_indent()
	require('guess-indent').setup { auto_cmd = true, override_editorconfig = true}
end

----------
--  UI  --
----------

function M.ui()
    return {}
end

function M.which_key()
    return {
        preset = "helix",
        icons = {
            rules = false,
        },
    }
end

function M.indent_blankline()
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

    return {
        indent = {
            char = "│",
        },
        scope = {
            enabled = true,
            show_start = true,
            show_end = true,
            char = "│",
        },
    }
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
            python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
            rust = { "rustfmt", lsp_format = "fallback" },
            markdown = { "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = nil,
    }
end

----------
--  LINT  --
----------

function M.lint()
    return function()
        require("lint").linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            astro = { "eslint_d" },
            ruby = { "rubocop" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("LintAuto", { clear = true }),
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
end

---------
--  DAP  --
---------

function M.dap()
    return function()
        local dap = require("dap")

        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = {
                    vim.fn.stdpath("data")
                        .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
                    "${port}",
                },
            },
        }

        dap.adapters.codelldb = {
            type = "executable",
            command = "codelldb",
        }

        local js_config = {
            {
                name = "Launch file",
                type = "pwa-node",
                request = "launch",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
            {
                name = "Attach to process",
                type = "pwa-node",
                request = "attach",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
            },
        }
        dap.configurations.javascript = js_config
        dap.configurations.typescript = js_config
        dap.configurations.javascriptreact = js_config
        dap.configurations.typescriptreact = js_config
        dap.configurations.astro = js_config

        local cpp_config = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }
        dap.configurations.cpp = cpp_config
        dap.configurations.c = cpp_config
    end
end

function M.dap_ui()
    return function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end
end

function M.dap_virtual_text()
    return {
        enabled = true,
        virt_text_pos = "inline",
    }
end

----------
--  CMAKE  --
----------

function M.cmake_tools()
    return {
        cmake_regenerate_on_save = false,
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_compile_commands_options = {
            action = "soft_link",
            target = vim.uv.cwd,
        },
        cmake_executor = { name = "terminal" },
        cmake_runner = { name = "terminal" },
        cmake_dap_configuration = {
            name = "cpp",
            type = "codelldb",
            request = "launch",
            stopOnEntry = false,
            runInTerminal = true,
            console = "integratedTerminal",
        },
    }
end

--------------
--  TESTING  --
--------------

function M.neotest()
    return function()
        require("neotest").setup({
            adapters = {
                require("neotest-rspec")({
                    rspec_cmd = function()
                        return vim.tbl_flatten({ "bundle", "exec", "rspec" })
                    end,
                }),
            },
        })
    end
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

--------------
--  TYPST  --
--------------

function M.typst_preview()
    return {}
end

function M.nvim_prose()
    return {
        filetypes = { "markdown", "asciidoc" },
    }
end

return M
