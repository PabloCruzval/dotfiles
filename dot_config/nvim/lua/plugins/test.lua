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
            { "<leader>tn", function() require("neotest").run.run() end, desc = "Test: Run nearest" },
            { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: Run file" },
            { "<leader>tD", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: Debug nearest" },
            { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: Open output" },
            { "<leader>tS", function() require("neotest").summary.toggle() end, desc = "Test: Toggle summary" },
        },
        config = require("config.plugins").neotest,
    },
}
