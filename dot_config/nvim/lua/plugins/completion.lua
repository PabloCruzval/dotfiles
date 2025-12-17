-- Code completion plugins
return {
	-- Autocompletion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			local cmp = require "cmp"
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end
				},
				window = {
					completion = require("cmp.config.window").bordered(),
					documentation = require("cmp.config.window").bordered()
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" }
				}, {
					{ name = "buffer" }
				}),
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true })
				})
			})
		end
	},
	-- GitHub Copilot
	{
		"github/copilot.vim",
		lazy = true,
		dependencies = "CopilotC-Nvim/CopilotChat.nvim",
		opts = {}
	}
}
