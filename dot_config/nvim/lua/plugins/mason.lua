return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "rust_analyzer", "tailwindcss", "qmlls", "ts_ls", "astro", "emmet_ls"}
		}
	},
}
