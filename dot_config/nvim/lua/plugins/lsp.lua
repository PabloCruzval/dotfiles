return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {"prettierd"}
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "tailwindcss", "qmlls", "ts_ls", "astro", "emmet_ls" },
		},
	},
	{
		"folke/lazydev.nvim",
		ft = { "lua" },
		opts = {},
	},
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		config = function()
			local null_ls = require "null-ls"
			local opts = {
				sources = {
					null_ls.builtins.formatting.prettierd,
				}
			}
			return opts
		end
		
	},
}
