return {
    {
        "neovim/nvim-lspconfig",
    },
    {
        "mason-org/mason.nvim",
        opts = require("config.plugins").mason,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = require("config.plugins").mason_lspconfig,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = require("config.plugins").mason_tool_installer,
        dependencies = { "mason-org/mason.nvim" },
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
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        opts = require("config.plugins").blink_cmp,
    },
}
