local o = vim.opt

o.wrap = false
o.tabstop = 4
o.shiftwidth = 4
o.signcolumn = "yes"
o.swapfile = false
o.fillchars = { eob = "." }
o.relativenumber = true
o.number = true
vim.cmd(":hi statusline guibg=NONE")

require("lazy_config")

o.winborder = "rounded"
vim.cmd([[colorscheme nord]])

require("lsp.main")
require("map")
require("utils.tmpl_files")

