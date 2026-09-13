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
        "folke/snacks.nvim",
        lazy = false,
        opts = require("config.plugins").snacks,
        keys = {
            { "<leader>pf", require("config.keys").snacks_files, desc = "Snacks: Buscar archivos" },
            { "<leader>pr", require("config.keys").snacks_recent_files, desc = "Snacks: Buscar archivos recientes" },
            { "<leader>ph", require("config.keys").snacks_help, desc = "Snacks: Buscar ayuda" },
            { "<leader>pb", require("config.keys").snacks_buffers, desc = "Snacks: Buscar buffers" },
            { "<leader>gl", require("config.keys").snacks_live_grep, desc = "Snacks: Buscar texto en vivo" },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
}
