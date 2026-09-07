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

-- Write and buffer
map('n', '<leader>w', ':write<CR>', { desc = "Guardar archivo" })
map('n', '<leader>bx', ':bdelete<CR>', { desc = "Cerrar buffer" })
map('n', '<leader>bn', ':bnext<CR>', { desc = "Siguiente buffer" })
map('n', '<leader>bp', ':bprevious<CR>', { desc = "Buffer anterior" })
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', { desc = "Copiar al portapapeles" })
map({ 'n', 'v', 'x' }, '<leader>d', '"+y<CR>', { desc = "Copiar al portapapeles" })
map({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>', { desc = "Alternar al archivo previo" })
map({ 'n', 'v', 'x' }, '<leader>h', ':noh<CR>', { desc = "Limpiar resaltado de búsqueda" })

local line_wrap_navigation_active = false

local function toggle_wrap_navigation()
  local modes = { 'n', 'v' }

  if line_wrap_navigation_active then
    for _, mode in ipairs(modes) do
      pcall(vim.keymap.del, mode, 'k')
      pcall(vim.keymap.del, mode, 'j')
    end
    line_wrap_navigation_active = false
    print("Navegación por líneas físicas (k/j estándar)")
  else
    vim.keymap.set(modes, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set(modes, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    line_wrap_navigation_active = true
    print("Navegación por líneas visuales (gk/gj activo)")
  end
end

vim.keymap.set('n', '<leader>tw', toggle_wrap_navigation, { desc = "Toggle wrap navigation (gk/gj)" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end

        local function lsp_map(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        if client:supports_method("textDocument/formatting") then
            lsp_map("<leader>lf", function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end, "Formatear buffer con LSP")
        end
        if client:supports_method("textDocument/codeAction") then
            lsp_map("<leader>la", function()
                vim.lsp.buf.code_action({
                    filter = function(a)
                        return not a.disabled
                    end,
                })
            end, "Acciones de código")
        end
        lsp_map("<leader>lD", vim.diagnostic.open_float, "Abrir diagnóstico flotante")
        if client:supports_method("textDocument/definition") then
            lsp_map("<leader>ld", vim.lsp.buf.definition, "Ir a definición")
        end
        if client:supports_method("textDocument/rename") then
            lsp_map("<leader>lr", vim.lsp.buf.rename, "Renombrar símbolo")
        end
        if client:supports_method("textDocument/hover") then
            lsp_map("<leader>lh", vim.lsp.buf.hover, "Mostrar documentación")
        end
    end,
})

-- Open the current file in the OS default application
map("n", "<leader>fo", function()
  vim.ui.open(vim.fn.expand("%"))
end, { desc = "Open file in external app" })


-- C/C++
map('n', '<leader>ch', '<cmd>ClangdSwitchSourceHeader<CR>', { desc = "C/C++: Switch header/source" })

-- CMake
map('n', '<leader>mg', '<cmd>CMakeGenerate<CR>', { desc = "CMake: Generate" })
map('n', '<leader>mb', '<cmd>CMakeBuild<CR>', { desc = "CMake: Build" })
map('n', '<leader>mr', '<cmd>CMakeRun<CR>', { desc = "CMake: Run target" })
map('n', '<leader>md', '<cmd>CMakeDebug<CR>', { desc = "CMake: Debug target" })
