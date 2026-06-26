---@diagnostic disable: undefined-global

local map = vim.keymap.set

map('t', '<ESC>', "<C-\\><C-n>", { remap = true, desc = "Salir del modo terminal" })

-- Core
map('n', '<leader>so', ':update<CR> :source<CR>', { desc = "Guardar y recargar archivo" })
map({ 'n', 'i' }, "<A-k>", '<cmd>m -2<CR>', { desc = "Mover línea arriba" })
map({ 'n', 'i' }, "<A-j>", '<cmd>m +1<CR>', { desc = "Mover línea abajo" })
map({ 'x', 'v' }, "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Mover selección arriba" })
map({ 'x', 'v' }, "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Mover selección abajo" })
map('n', '<leader>ts', require "utils.terminal", { desc = "Abrir/cerrar terminal" })

-- Comment
map('n', '<leader>/', "gcc", { remap = true, desc = "Comentar línea" })
map('v', '<leader>/', "gc", { remap = true, desc = "Comentar selección" })

-- Pick files & Oil
local Oil = require "oil"
map('n', '<leader>pf', ':Pick files<CR>', { desc = "Buscar archivos" })
map('n', '<leader>ph', ':Pick help<CR>', { desc = "Buscar ayuda" })
map('n', '<leader>pb', ':Pick buffers<CR>', { desc = "Buscar buffers" })
map('n', '<leader>gl', ':Pick grep_live<CR>', { desc = "Buscar texto en vivo" })
map('n', '<leader>e', ':Oil<CR>', { desc = "Explorador de archivos" })
map('n', '<S-h>', Oil.toggle_hidden, { desc = "Mostrar/ocultar archivos ocultos" })

-- Write and buffer
map('n', '<leader>w', ':write<CR>', { desc = "Guardar archivo" })
map('n', '<leader>bx', ':bdelete<CR>', { desc = "Cerrar buffer" })
map('n', '<leader>bn', ':bnext<CR>', { desc = "Siguiente buffer" })
map('n', '<leader>bp', ':bprevious<CR>', { desc = "Buffer anterior" })
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', { desc = "Copiar al portapapeles" })
map({ 'n', 'v', 'x' }, '<leader>d', '"+y<CR>', { desc = "Copiar al portapapeles" })
map({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>', { desc = "Alternar al archivo previo" })
map({ 'n', 'v', 'x' }, '<leader>h', ':noh<CR>', { desc = "Limpiar resaltado de búsqueda" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        local function lsp_map(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        lsp_map("<leader>lf", vim.lsp.buf.format, "Formatear buffer con LSP")
        lsp_map("<leader>la", vim.lsp.buf.code_action, "Acciones de código")
        lsp_map("<leader>lD", vim.diagnostic.open_float, "Abrir diagnóstico flotante")

        lsp_map("<leader>ld", vim.lsp.buf.definition, "Ir a definición")
        lsp_map("<leader>lr", vim.lsp.buf.rename, "Renombrar símbolo")
        lsp_map("<leader>lh", vim.lsp.buf.hover, "Mostrar documentación")
    end,
})
