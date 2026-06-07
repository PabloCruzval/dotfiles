---@diagnostic disable: undefined-global

local map = vim.keymap.set

map('t', '<ESC>', "<C-\\><C-n>", { remap = true })

-- Core
map('n', '<leader>so', ':update<CR> :source<CR>')
map({ 'n', 'i' }, "<A-k>", '<cmd>m -2<CR>')
map({ 'n', 'i' }, "<A-j>", '<cmd>m +1<CR>')
map({ 'x', 'v' }, "<A-k>", ":m '<-2<CR>gv=gv")
map({ 'x', 'v' }, "<A-j>", ":m '>+1<CR>gv=gv")
map('n', '<leader>ts', require "utils.terminal")

-- Comment
map('n', '<leader>/', "gcc", { remap = true })
map('v', '<leader>/', "gc", { remap = true })

-- Pick files & Oil
local Oil = require "oil"
map('n', '<leader>pf', ':Pick files<CR>')
map('n', '<leader>ph', ':Pick help<CR>')
map('n', '<leader>pb', ':Pick buffers<CR>')
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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        local function lsp_map(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        lsp_map("<leader>lf", vim.lsp.buf.format, "Formatear buffer con LSP")
        lsp_map("<leader>lD", vim.diagnostic.open_float, "Abrir diagnóstico flotante")

        lsp_map("<leader>ld", vim.lsp.buf.definition, "Ir a definición")
        lsp_map("<leader>lr", vim.lsp.buf.rename, "Renombrar símbolo")
        lsp_map("<leader>lh", vim.lsp.buf.hover, "Mostrar documentación")
    end,
})
