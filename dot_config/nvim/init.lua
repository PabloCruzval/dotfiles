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

require("themes.noctalia").load()
