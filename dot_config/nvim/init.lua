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

require("config.lazy")
require("config.map")
require("config.diagnostic")
-- require("config.lsp")

vim.cmd.colorscheme('oc-2')

vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi NormalFloat guibg=NONE ctermbg=NONE")
vim.cmd("hi StatusLine guibg=NONE ctermbg=NONE")
vim.cmd("hi StatusLineNC guibg=NONE ctermbg=NONE")
