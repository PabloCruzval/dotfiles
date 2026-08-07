return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = require("config.plugins").treesitter,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = require("config.plugins").textobjects,
    },
    {
        "NMAC427/guess-indent.nvim",
        event = "InsertEnter",
        config = require("config.plugins").guess_indent,
    },
}
