local plugins = require("config.plugins")

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        priority = 1000,
        opts = plugins.catppuccin,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        priority = 1000,
        opts = plugins.rose_pine,
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        opts = plugins.tokyonight,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000,
        opts = plugins.kanagawa,
    },
    {
        "sainnhe/gruvbox-material",
        lazy = true,
        priority = 1000,
        config = plugins.gruvbox_material,
    },
    {
        "datsfilipe/vesper.nvim",
        lazy = true,
        priority = 1000,
        opts = plugins.vesper,
    },
}
