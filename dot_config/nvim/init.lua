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

vim.filetype.add({
    extension = {
        typ = "typst",
    },
})

require("config.lazy")
require("config.map")
require("config.diagnostic")
require("utils.tinymist_status")
require("utils.wordcount")

local function set_transparent_bg()
	vim.api.nvim_set_hl(0, "Normal", { bg = nil })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = nil })
end

require("themes.noctalia").load()
set_transparent_bg()

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("TransparentBg", { clear = true }),
	callback = set_transparent_bg,
})
