return {
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "1.*",
        build = function()
            require("typst-preview").update()
        end,
        opts = require("config.plugins").typst_preview,
        keys = {
            { "<leader>tp", "<cmd>TypstPreviewToggle<cr>", mode = { "n" }, desc = "Typst: Toggle preview" },
        },
    },
    {
        "skwee357/nvim-prose",
        ft = { "typst", "markdown", "asciidoc" },
        opts = require("config.plugins").nvim_prose,
    },
}
