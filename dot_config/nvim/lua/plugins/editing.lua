return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = require("config.plugins").autopairs,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = require("config.plugins").autotag,
    },
    {
        "kylechui/nvim-surround",
        version = "^3.0.0",
        event = "VeryLazy",
        opts = require("config.plugins").surround,
    },
    {
        "stevearc/conform.nvim",
        cmd = { "ConformInfo" },
        opts = require("config.plugins").conform,
        keys = {
            {
                "<leader>ff",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
        },
    },
}
