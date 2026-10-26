local M = {}

-----------
--  LSP  --
-----------

function M.lspconfig()
    local ok, wf = pcall(require, "vim.lsp._watchfiles")
    if ok then
        wf._watchfunc = function()
            return function() end
        end
    end

    vim.lsp.config("*", {
        capabilities = {
            workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = false,
                },
            },
        },
    })
    vim.lsp.enable("ruby_lsp")
end

function M.mason()
    return {}
end

function M.mason_lspconfig()
    local servers = {
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
    }
    return {
        ensure_installed = servers,
        automatic_enable = servers,
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

function M.typescript_tools()
    return {
        settings = {
            separate_diagnostic_server = true,
            publish_diagnostic_on = "insert_leave",
            tsserver_max_memory = 4096,
            tsserver_file_preferences = {
                includeInlayParameterNameHints = "none",
                includeCompletionsForModuleExports = true,
                includePackageJsonAutoImports = "auto",
            },
        },
    }
end

function M.luasnip()
    require("luasnip.loaders.from_vscode").lazy_load()
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
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<Esc>"] = {
                "cancel",
                function()
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n")
                end,
            },
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
            menu = {
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if ctx.item.source_name == "LSP" then
                                    local ok, hc = pcall(require, "nvim-highlight-colors")
                                    if ok then
                                        local color_item = hc.format(ctx.item.documentation, { kind = ctx.kind })
                                        if color_item and color_item.abbr ~= "" then
                                            icon = color_item.abbr
                                        end
                                    end
                                end
                                return icon .. ctx.icon_gap
                            end,
                            highlight = function(ctx)
                                local highlight = "BlinkCmpKind" .. ctx.kind
                                if ctx.item.source_name == "LSP" then
                                    local ok, hc = pcall(require, "nvim-highlight-colors")
                                    if ok then
                                        local color_item = hc.format(ctx.item.documentation, { kind = ctx.kind })
                                        if color_item and color_item.abbr_hl_group then
                                            highlight = color_item.abbr_hl_group
                                        end
                                    end
                                end
                                return highlight
                            end,
                        },
                    },
                },
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

function M.oil_init()
    if vim.fn.argc() > 0 then
        local arg = vim.fn.argv(0)
        local stat = (vim.uv or vim.loop).fs_stat(arg)
        if stat and stat.type == "directory" then
            require("oil")
        end
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
            if not (_G.Snacks and Snacks.rename) then
                return
            end
            for _, action in ipairs(event.data and event.data.actions or {}) do
                if action.type == "move" then
                    Snacks.rename.on_rename_file(action.src_url, action.dest_url)
                end
            end
        end,
    })
end

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
            ["<S-h>"] = "actions.toggle_hidden",
        },
    }
end

function M.oil_git()
    return {
        symbol_position = "signcolumn",
        show_ignored_files = false,
        show_ignored_directories = true,
        ignore_gitsigns_update = true,
    }
end

function M.snacks()
    return {
        bigfile = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true, timeout = 3000 },
        words = { enabled = false },
        terminal = { enabled = true },
        indent = {
            enabled = true,
            animate = { enabled = false },
            scope = { enabled = true },
        },
        picker = {
            enabled = true,
            ui_select = true,
            exclude = {
                ".git",
                "node_modules",
                ".next",
                ".turbo",
                "dist",
                "build",
            },
            sources = {
                buffers = {
                    win = {
                        list = {
                            keys = {
                                ["d"] = "bufdelete",
                            },
                        },
                    },
                },
            },
        },
    }
end

--------------
--  SYNTAX  --
--------------

function M.treesitter()
    local ts = require("nvim-treesitter")
    ts.setup()

    local wanted = {
        "astro",
        "bash",
        "cpp",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "ruby",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
        "yaml",
    }

    local installed = {}
    for _, lang in ipairs(ts.get_installed("parsers")) do
        installed[lang] = true
    end

    local missing = {}
    for _, lang in ipairs(wanted) do
        if not installed[lang] then
            table.insert(missing, lang)
        end
    end

    if #missing > 0 then
        ts.install(missing)
    end

    local function attach_ts(buf)
        if
            not vim.api.nvim_buf_is_valid(buf)
            or vim.bo[buf].buftype ~= ""
            or vim.treesitter.highlighter.active[buf]
        then
            return
        end
        if pcall(vim.treesitter.start, buf) then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end

    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterNative", { clear = true }),
        callback = function(args)
            attach_ts(args.buf)
        end,
    })

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
            attach_ts(buf)
        end
    end
end

function M.textobjects()
    require("nvim-treesitter-textobjects").setup({
        select = {
            lookahead = true,
        },
        move = {
            set_jumps = true,
        },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")

    local select_maps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
    }

    for key, query in pairs(select_maps) do
        vim.keymap.set({ "x", "o" }, key, function()
            select.select_textobject(query, "textobjects")
        end, { desc = "Treesitter: Select " .. query })
    end

    vim.keymap.set({ "n", "x", "o" }, "]f", function()
        move.goto_next_start("@function.outer", "textobjects")
    end, { desc = "Treesitter: Next function" })
    vim.keymap.set({ "n", "x", "o" }, "]a", function()
        move.goto_next_start("@parameter.inner", "textobjects")
    end, { desc = "Treesitter: Next parameter" })
    vim.keymap.set({ "n", "x", "o" }, "[f", function()
        move.goto_previous_start("@function.outer", "textobjects")
    end, { desc = "Treesitter: Previous function" })
    vim.keymap.set({ "n", "x", "o" }, "[a", function()
        move.goto_previous_start("@parameter.inner", "textobjects")
    end, { desc = "Treesitter: Previous parameter" })
end

function M.guess_indent()
    require("guess-indent").setup({ auto_cmd = true, override_editorconfig = true })
end

----------
--  UI  --
----------

function M.catppuccin()
    return {
        flavour = "mocha",
        transparent_background = true,
        default_integrations = false,
        integrations = {
            blink_cmp = true,
            dap = true,
            dap_ui = true,
            gitsigns = true,
            mason = true,
            neotest = true,
            semantic_tokens = true,
            snacks = true,
            treesitter = true,
            which_key = true,
        },
        custom_highlights = function()
            return {
                LineNr = { fg = "#9399b2" },
                CursorLineNr = { fg = "#b4befe", style = { "bold" } },
            }
        end,
    }
end

function M.which_key()
    return {
        preset = "helix",
        icons = {
            rules = false,
        },
        disable = {
            ft = {
                "snacks_picker_list",
                "snacks_picker_input",
                "snacks_picker_preview",
            },
        },
    }
end

function M.highlight_colors()
    return {
        render = "virtual",
        virtual_symbol = "■",
        enable_tailwind = true,
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

function M.surround()
    return {}
end

function M.conform()
    local web_fmt = { "biome-check", "prettierd", "prettier", stop_after_first = true }
    return {
        formatters_by_ft = {
            javascript = web_fmt,
            typescript = web_fmt,
            javascriptreact = web_fmt,
            typescriptreact = web_fmt,
            css = web_fmt,
            html = { "prettierd", "prettier", stop_after_first = true },
            json = web_fmt,
            jsonc = web_fmt,
            astro = { "prettierd", "prettier", stop_after_first = true },
            lua = { "stylua" },
            python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
            rust = { "rustfmt", lsp_format = "fallback" },
            markdown = { "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
        },
        formatters = {
            ["biome-check"] = {
                require_cwd = true,
            },
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
    require("lint").linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        astro = { "eslint_d" },
        ruby = { "rubocop" },
    }

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("LintAuto", { clear = true }),
        callback = function()
            if vim.bo.modifiable then
                require("lint").try_lint()
            end
        end,
    })
end

---------
--  DAP  --
---------

function M.dap()
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

    require("dap-ruby").setup()
    require("dap-python").setup("python3")
end

function M.dap_ui()
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
    require("neotest").setup({
        adapters = {
            require("neotest-rspec")({
                rspec_cmd = function()
                    return { "bundle", "exec", "rspec" }
                end,
            }),
        },
    })
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
            local map = function(mode, keys, func, desc)
                vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "Git: " .. desc })
            end
            map("n", "]c", function() gs.nav_hunk("next") end, "Next hunk")
            map("n", "[c", function() gs.nav_hunk("prev") end, "Prev hunk")
            map("n", "<leader>gh", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
            map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
            map("v", "<leader>gr", function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Reset selected hunk")
            map("v", "<leader>gs", function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Stage selected hunk")
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
