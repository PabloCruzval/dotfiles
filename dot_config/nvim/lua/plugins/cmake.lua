return {
    {
        "Civitasv/cmake-tools.nvim",
        ft = { "c", "cpp", "objc", "objcpp", "cmake" },
        opts = require("config.plugins").cmake_tools,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}