return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = require("config.plugins").oil,
        keys = {
            { "<leader>e", require("config.keys").oil_open, desc = "Explorador de archivos" },
            { "<S-h>", require("config.keys").oil_toggle_hidden, desc = "Mostrar/ocultar archivos ocultos" },
        },
    },
    {
        "malewicz1337/oil-git.nvim",
        dependencies = { "stevearc/oil.nvim" },
        opts = require("config.plugins").oil_git,
    },
    {
        "echasnovski/mini.pick",
        opts = require("config.plugins").mini_pick,
        cmd = "Pick",
        keys = {
            { "<leader>pf", require("config.keys").pick_files, desc = "Buscar archivos" },
            { "<leader>ph", require("config.keys").pick_help, desc = "Buscar ayuda" },
            { "<leader>pb", require("config.keys").pick_buffers, desc = "Buscar buffers" },
            { "<leader>gl", require("config.keys").pick_grep_live, desc = "Buscar texto en vivo" },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
}
