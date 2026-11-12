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
            { "<leader>e", function() require("oil").open() end, desc = "File explorer" },
            { "<leader>or", require("utils.oil").open_root, desc = "Oil: Open in root directory (root CWD)" },
            { "<leader>oR", require("utils.oil").set_root, desc = "Oil: Set current directory as root CWD" },
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = require("config.plugins").snacks,
        keys = {
            { "<leader>pf", function() Snacks.picker.files() end, desc = "Snacks: Find files" },
            { "<leader>pr", function() Snacks.picker.recent({ filter = { cwd = true } }) end, desc = "Snacks: Find recent files" },
            { "<leader>ph", function() Snacks.picker.help() end, desc = "Snacks: Find help" },
            { "<leader>pb", function() Snacks.picker.buffers() end, desc = "Snacks: Find buffers" },
            { "<leader>pc", function() require("utils.theme").pick() end, desc = "Snacks: Change colorscheme" },
            { "<leader>gl", function() Snacks.picker.grep() end, desc = "Snacks: Live grep" },
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
