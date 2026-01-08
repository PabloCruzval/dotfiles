return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ':TSUpdate',
		config = function()
            require('nvim-treesitter').setup({
                ensure_installed = { "typescript", "tsx", "javascript", "html", "rust", "python" },
                highlight = { 
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end
	},
}
