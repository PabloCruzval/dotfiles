return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "rust_analyzer", "tailwindcss", "qmlls", "ts_ls", "astro", "emmet_ls" },
		},
	},
	{
		"folke/lazydev.nvim",
		ft = { "lua" },
		opts = {},
	},
}
