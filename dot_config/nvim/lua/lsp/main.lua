local capabilities = require "cmp_nvim_lsp".default_capabilities()

local lsps = { "lua_ls", "rust_analyzer", "tailwindcss", "qmlls", "ts_ls" }

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
})

for i = 1, #lsps do
	vim.lsp.config(lsps[i], {capabilities = capabilities})
	vim.lsp.enable(lsps[i])
end
