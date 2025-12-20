return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		opts = {
			ensure_installed = { "typescript", "javascript", "rust", "python" },
			highlight = { enable = true },
		},
	},
}
