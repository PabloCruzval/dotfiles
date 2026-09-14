local o = vim.opt

o.wrap = true
o.linebreak = true
o.tabstop = 4
o.shiftwidth = 4
o.signcolumn = "yes"
o.swapfile = false
o.fillchars = { eob = "." }
o.relativenumber = true
o.number = true
o.termguicolors = true
o.winborder = "rounded"
o.ignorecase = true
o.smartcase = true

vim.filetype.add({
    extension = {
        typ = "typst",
    },
})

require("config.lazy")
require("config.map")
require("config.diagnostic")
require("config.jsonls")
require("utils.tinymist_status")
require("utils.wordcount")

vim.lsp.enable("ruby_lsp")

local function set_transparent_bg()
	vim.api.nvim_set_hl(0, "Normal", { bg = nil })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = nil })
end

vim.cmd [[colorscheme catppuccin-mocha]]
set_transparent_bg()

vim.api.nvim_set_hl(0, "LineNr", { fg = "#9399b2" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#b4befe", bold = true })
