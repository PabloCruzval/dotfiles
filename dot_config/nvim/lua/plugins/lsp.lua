return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = require("config.plugins").lspconfig,
    },
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonLog" },
        build = ":MasonUpdate",
        opts = require("config.plugins").mason,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = require("config.plugins").mason_lspconfig,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = "VeryLazy",
        cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
        opts = require("config.plugins").mason_tool_installer,
        dependencies = { "mason-org/mason.nvim" },
    },
    {
        "pmizio/typescript-tools.nvim",
        ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = require("config.plugins").typescript_tools,
    },
    {
        "b0o/schemastore.nvim",
        lazy = true,
        module = "schemastore",
    },
    {
        "p00f/clangd_extensions.nvim",
        ft = { "c", "cpp" },
        opts = require("config.plugins").clangd_extensions,
    },
    {
        "saghen/blink.cmp",
        version = "v1.*",
        event = "InsertEnter",
        dependencies = {
            "rafamadriz/friendly-snippets",
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
                config = require("config.plugins").luasnip,
            },
        },
        opts = require("config.plugins").blink_cmp,
    },
}
