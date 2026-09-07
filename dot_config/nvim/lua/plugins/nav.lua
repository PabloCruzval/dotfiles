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
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = require("config.plugins").telescope,
        keys = {
            { "<leader>pf", require("config.keys").telescope_files, desc = "Telescope: Buscar archivos" },
            { "<leader>pr", require("config.keys").telescope_recent_files, desc = "Telescope: Buscar archivos recientes" },
            { "<leader>ph", require("config.keys").telescope_help, desc = "Telescope: Buscar ayuda" },
            { "<leader>pb", require("config.keys").telescope_buffers, desc = "Telescope: Buscar buffers" },
            { "<leader>gl", require("config.keys").telescope_live_grep, desc = "Telescope: Buscar texto en vivo" },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
}
