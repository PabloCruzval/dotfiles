return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<leader>Db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
            { "<leader>DB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "DAP: Breakpoint condicional" },
            { "<leader>Dc", function() require("dap").continue() end, desc = "DAP: Continue" },
            { "<leader>Do", function() require("dap").step_over() end, desc = "DAP: Step over" },
            { "<leader>Di", function() require("dap").step_into() end, desc = "DAP: Step into" },
            { "<leader>DO", function() require("dap").step_out() end, desc = "DAP: Step out" },
            { "<leader>Dr", function() require("dap").repl.open() end, desc = "DAP: Open REPL" },
            { "<leader>Du", function() require("dapui").toggle() end, desc = "DAP: Toggle UI" },
        },
        config = require("config.plugins").dap,
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                config = require("config.plugins").dap_ui,
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = require("config.plugins").dap_virtual_text,
            },
            { "suketa/nvim-dap-ruby", lazy = true },
            { "mfussenegger/nvim-dap-python", lazy = true },
        },
    },
}
