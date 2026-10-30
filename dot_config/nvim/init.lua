local o = vim.opt

vim.g.root_cwd = vim.fn.getcwd()

o.wrap = true
o.linebreak = true
o.tabstop = 4
o.shiftwidth = 4
o.signcolumn = "yes"
o.swapfile = false
o.undofile = true
o.updatetime = 250
o.splitright = true
o.splitbelow = true
o.scrolloff = 8
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

local core_group = vim.api.nvim_create_augroup("CoreAutocmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = core_group,
    callback = function()
        vim.hl.on_yank({ timeout = 150 })
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = core_group,
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local lcount = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= lcount and vim.bo[args.buf].filetype ~= "gitcommit" then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = core_group,
    pattern = { "help", "qf", "man", "checkhealth", "lspinfo" },
    callback = function(args)
        vim.bo[args.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = args.buf, silent = true })
    end,
})

vim.api.nvim_create_autocmd("User", {
    group = core_group,
    pattern = "VeryLazy",
    once = true,
    callback = function()
        require("utils.tinymist_status")
        require("utils.wordcount")
    end,
})

require("utils.theme").setup()
