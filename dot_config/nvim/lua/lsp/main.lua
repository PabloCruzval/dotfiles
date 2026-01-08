local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {capabilities = capabilities,})

local servers = { "lua_ls", "tailwindcss", "qmlls", "ts_ls"}

vim.lsp.enable(servers)
