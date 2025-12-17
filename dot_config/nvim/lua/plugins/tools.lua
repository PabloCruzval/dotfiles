return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {}
	},
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		opts = {}
	},
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
