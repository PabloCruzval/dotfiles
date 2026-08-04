return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = require("config.plugins").treesitter,
    },
    {
        "NMAC427/guess-indent.nvim",
        event = "InsertEnter",
        config = require("config.plugins").guess_indent,
    },
}
