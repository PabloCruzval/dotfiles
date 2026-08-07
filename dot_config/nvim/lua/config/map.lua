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

-- Variable global o local para rastrear el estado del toggle
local line_wrap_navigation_active = false

local function toggle_wrap_navigation()
  local modes = { 'n', 'v' }
  
  if line_wrap_navigation_active then
    -- Si está activo, eliminamos los mapeos para regresar al comportamiento nativo
    for _, mode in ipairs(modes) do
      pcall(vim.keymap.del, mode, 'k')
      pcall(vim.keymap.del, mode, 'j') -- Por si decides usar j también
    end
    line_wrap_navigation_active = false
    print("Navegación por líneas físicas (k/j estándar)")
  else
    -- Si está inactivo, activamos tus mapeos condicionales con expr = true
    vim.keymap.set(modes, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set(modes, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    line_wrap_navigation_active = true
    print("Navegación por líneas visuales (gk/gj activo)")
  end
end

-- Asignamos el atajo para activar/desactivar la función (ejemplo con <leader>tw)
vim.keymap.set('n', '<leader>tw', toggle_wrap_navigation, { desc = "Toggle wrap navigation (gk/gj)" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        local function lsp_map(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        lsp_map("<leader>lf", vim.lsp.buf.format, "Formatear buffer con LSP")
        lsp_map("<leader>la", function()
            vim.lsp.buf.code_action({
                filter = function(a)
                    return not a.disabled
                end,
            })
        end, "Acciones de código")
        lsp_map("<leader>lD", vim.diagnostic.open_float, "Abrir diagnóstico flotante")

        lsp_map("<leader>ld", vim.lsp.buf.definition, "Ir a definición")
        lsp_map("<leader>lr", vim.lsp.buf.rename, "Renombrar símbolo")
        lsp_map("<leader>lh", vim.lsp.buf.hover, "Mostrar documentación")
    end,
})

-- DAP
map('n', '<leader>db', function() require("dap").toggle_breakpoint() end, { desc = "DAP: Toggle breakpoint" })
map('n', '<leader>dB', function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Breakpoint condicional" })
map('n', '<leader>dc', function() require("dap").continue() end, { desc = "DAP: Continuar" })
map('n', '<leader>do', function() require("dap").step_over() end, { desc = "DAP: Step over" })
map('n', '<leader>di', function() require("dap").step_into() end, { desc = "DAP: Step into" })
map('n', '<leader>dO', function() require("dap").step_out() end, { desc = "DAP: Step out" })
map('n', '<leader>dr', function() require("dap").repl.open() end, { desc = "DAP: Abrir REPL" })
map('n', '<leader>du', function() require("dapui").toggle() end, { desc = "DAP: Toggle UI" })

-- Test
map('n', '<leader>tn', function() require("neotest").run.run() end, { desc = "Test: Ejecutar más cercano" })
map('n', '<leader>tf', function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Test: Ejecutar archivo" })
map('n', '<leader>tD', function() require("neotest").run.run({ strategy = "dap" }) end, { desc = "Test: Debug más cercano" })
map('n', '<leader>to', function() require("neotest").output.open({ enter = true }) end, { desc = "Test: Abrir output" })
map('n', '<leader>tS', function() require("neotest").summary.toggle() end, { desc = "Test: Toggle summary" })
