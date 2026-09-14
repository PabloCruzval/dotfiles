return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<leader>db", require("config.keys").dap_toggle_breakpoint, desc = "DAP: Toggle breakpoint" },
            { "<leader>dB", require("config.keys").dap_conditional_breakpoint, desc = "DAP: Breakpoint condicional" },
            { "<leader>dc", require("config.keys").dap_continue, desc = "DAP: Continuar" },
            { "<leader>do", require("config.keys").dap_step_over, desc = "DAP: Step over" },
            { "<leader>di", require("config.keys").dap_step_into, desc = "DAP: Step into" },
            { "<leader>dO", require("config.keys").dap_step_out, desc = "DAP: Step out" },
            { "<leader>dr", require("config.keys").dap_repl, desc = "DAP: Abrir REPL" },
            { "<leader>du", require("config.keys").dap_toggle_ui, desc = "DAP: Toggle UI" },
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
            {
                "suketa/nvim-dap-ruby",
                lazy = true,
                config = function()
                    require("dap-ruby").setup()
                end,
            },
            {
                "mfussenegger/nvim-dap-python",
                lazy = true,
                config = function()
                    require("dap-python").setup("python3")
                end,
            },
        },
    },
}
