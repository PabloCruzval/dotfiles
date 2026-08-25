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
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "VeryLazy",
        config = require("config.plugins").indent_blankline,
    },
}
