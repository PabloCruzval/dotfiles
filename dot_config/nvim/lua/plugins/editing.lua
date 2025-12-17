-- Code editing enhancement plugins
return {
	-- Auto-close pairs like (), {}, []
	{
		"windwp/nvim-autopairs",
		opts = {}
	},
	-- Auto-close and rename HTML/JSX tags
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true
				}
			})
		end
	}
}
