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

-- Enanble treesitter highlight
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    
    local max_filesize = 500 * 1024 -- 500 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size > max_filesize then
      return
    end

    if lang then
      pcall(vim.treesitter.start, bufnr, lang)
    end
  end,
})

o.winborder = "rounded"
vim.cmd([[colorscheme kanagawa]])

require("lsp.main")
require("map")
require("utils.tmpl_files")

