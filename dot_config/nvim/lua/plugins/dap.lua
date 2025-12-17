return {
	"mfussenegger/nvim-dap",
	keys = {
		{ "<leader>dt", function() require("dap").toggle_breakpoint() end },
		{ "<leader>dc", function() require("dap").continue() end }
	},
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim"
	},
	config = function()
		require("mason-nvim-dap").setup({
			ensure_installed = { "debugpy", "js-debug", "codelldb" },
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		local dap = require "dap"
		local dapui = require "dapui"
		local map = vim.keymap.set

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}
