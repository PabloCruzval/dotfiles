return {
    {
        "mfussenegger/nvim-dap",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = require("config.plugins").dap_ui,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        opts = require("config.plugins").dap_virtual_text,
    },
    {
        "suketa/nvim-dap-ruby",
        config = function()
            require("dap-ruby").setup()
        end,
    },
}