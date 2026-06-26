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
}
