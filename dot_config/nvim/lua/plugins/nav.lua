return {
    {
        "stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = require("config.plugins").oil,
    },
    {
        "echasnovski/mini.pick",
        opts = require("config.plugins").mini_pick,
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
}
