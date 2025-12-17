return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "typescript", "javascript", "rust", "python" },
			highlight = { enable = true },
		},
	},
}
