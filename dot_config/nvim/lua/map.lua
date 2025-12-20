local map = vim.keymap.set

vim.g.mapleader = " "
map('t', '<ESC>', "<C-\\><C-n>", {remap = true})

-- Core
map('n', '<leader>so', ':update<CR> :source<CR>')
map({ 'n', 'i' }, "<A-k>", '<cmd>m -2<CR>')
map({ 'n', 'i' }, "<A-j>", '<cmd>m +1<CR>')
map({ 'x', 'v' }, "<A-k>", ":m '<-2<CR>gv=gv")
map({ 'x', 'v' }, "<A-j>", ":m '>+1<CR>gv=gv")
map('n', '<C-h>', '<C-w>h', { desc = "Move to left window" })
map('n', '<C-j>', '<C-w>j', { desc = "Move to window below" })
map('n', '<C-k>', '<C-w>k', { desc = "Move to window above" })
map('n', '<C-l>', '<C-w>l', { desc = "Move to right window" })
map('n', '<leader>ll', require "utils.lazy_picker")
map('n', '<leader>ts', require "utils.terminal")
-- Comment
map('n', '<leader>/', "gcc", {remap = true})
map('v', '<leader>/', "gc", {remap = true})

-- Pick files & Oil
local Oil = require "oil"
map('n', '<leader>f', ':Pick files<CR>')
map('n', '<leader>ph', ':Pick help<CR>')
map('n', '<leader>gl', ':Pick grep_live<CR>')
map('n', '<leader>e', ':Oil<CR>')
map('n', '<S-h>', Oil.toggle_hidden)

-- Write and buffer
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>bx', ':bdelete<CR>')
map('n', '<leader>bn', ':bnext<CR>')
map('n', '<leader>bp', ':bprevious<CR>')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
map({ 'n', 'v', 'x' }, '<leader>d', '"+y<CR>')
map({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>')
map({ 'n', 'v', 'x' }, '<leader>h', ':noh<CR>')


-- Lsp
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>lD', vim.diagnostic.open_float)
map('n', '<leader>ld', vim.lsp.buf.definition)
map('n', '<leader>lr', vim.lsp.buf.rename)

-- Git
local gitsigns = require "gitsigns"
map('n', '<leader>gh', gitsigns.preview_hunk)
map('n', '<leader>gr', gitsigns.reset_hunk)
map("v", "<leader>gs", function()
	gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end)

-- Copilot
map('n', '<leader>cc', ':CopilotChat<CR>')
map('n', '<leader>cC', ':CopilotChatCommit<CR>')
