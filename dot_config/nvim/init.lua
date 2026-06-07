local o = vim.opt

o.wrap = true
o.tabstop = 4
o.shiftwidth = 4
o.signcolumn = "yes"
o.swapfile = false
o.fillchars = { eob = "." }
o.relativenumber = true
o.number = true
o.termguicolors = true
o.winborder = "rounded"

vim.cmd(":hi statusline guibg=NONE")

require("config.lazy")
require("config.map")
require("config.diagnostic")
-- require("config.lsp")

vim.cmd([[colorscheme kanagawa]])
