return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = require("config.plugins").which_key,
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer keymaps",
            },
        },
    },
    {
        "brenoprata10/nvim-highlight-colors",
        event = { "BufReadPost", "BufNewFile" },
        opts = require("config.plugins").highlight_colors,
    },
}
