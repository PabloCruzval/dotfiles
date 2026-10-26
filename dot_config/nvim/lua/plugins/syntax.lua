return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdate", "TSInstall", "TSUninstall" },
        build = ":TSUpdate",
        config = require("config.plugins").treesitter,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = require("config.plugins").textobjects,
    },
    {
        "NMAC427/guess-indent.nvim",
        event = "InsertEnter",
        config = require("config.plugins").guess_indent,
    },
}
