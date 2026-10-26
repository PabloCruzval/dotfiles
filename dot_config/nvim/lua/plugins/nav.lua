return {
    {
        "stevearc/oil.nvim",
        cmd = "Oil",
        init = require("config.plugins").oil_init,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            {
                "malewicz1337/oil-git.nvim",
                opts = require("config.plugins").oil_git,
            },
        },
        opts = require("config.plugins").oil,
        keys = {
            { "<leader>e", require("config.keys").oil_open, desc = "Explorador de archivos" },
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
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
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
}
