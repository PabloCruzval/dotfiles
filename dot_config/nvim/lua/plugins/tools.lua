-- Utility and tool plugins
return {
	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		opts = {}
	},
	-- Markdown preview
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		}
	},
	-- Chezmoi template support
	{
		"xvzc/chezmoi.nvim",
		ft = "gotmpl",
		config = function()
			require("chezmoi").setup {
				edit = {
					watch = false,
					force = false,
				},
			}
		end,
	}
}
