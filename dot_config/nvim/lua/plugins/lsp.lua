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
    },
    {
        "saghen/blink.cmp",
        version = "v1.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        opts = require("config.plugins").blink_cmp,
    },
}
