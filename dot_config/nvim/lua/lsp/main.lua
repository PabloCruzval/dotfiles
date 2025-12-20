local capabilities = require "cmp_nvim_lsp".default_capabilities()

local lsps = { "lua_ls", "rust_analyzer", "tailwindcss", "qmlls", "ts_ls" }

for i = 1, #lsps do
	vim.lsp.config(lsps[i], {capabilities = capabilities})
	vim.lsp.enable(lsps[i])
end
