return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "olimorris/neotest-rspec",
        },
        keys = {
            { "<leader>tn", require("config.keys").test_nearest, desc = "Test: Ejecutar más cercano" },
            { "<leader>tf", require("config.keys").test_file, desc = "Test: Ejecutar archivo" },
            { "<leader>tD", require("config.keys").test_debug, desc = "Test: Debug más cercano" },
            { "<leader>to", require("config.keys").test_output, desc = "Test: Abrir output" },
            { "<leader>tS", require("config.keys").test_summary, desc = "Test: Toggle summary" },
        },
        config = require("config.plugins").neotest,
    },
}
