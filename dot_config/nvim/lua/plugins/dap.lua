return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<leader>Db", require("config.keys").dap_toggle_breakpoint, desc = "DAP: Toggle breakpoint" },
            { "<leader>DB", require("config.keys").dap_conditional_breakpoint, desc = "DAP: Breakpoint condicional" },
            { "<leader>Dc", require("config.keys").dap_continue, desc = "DAP: Continuar" },
            { "<leader>Do", require("config.keys").dap_step_over, desc = "DAP: Step over" },
            { "<leader>Di", require("config.keys").dap_step_into, desc = "DAP: Step into" },
            { "<leader>DO", require("config.keys").dap_step_out, desc = "DAP: Step out" },
            { "<leader>Dr", require("config.keys").dap_repl, desc = "DAP: Abrir REPL" },
            { "<leader>Du", require("config.keys").dap_toggle_ui, desc = "DAP: Toggle UI" },
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
