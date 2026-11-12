---@diagnostic disable: undefined-global

local map = vim.keymap.set

local last_terminal_esc = 0
local function terminal_esc()
    local now = vim.uv.hrtime() / 1e6
    local diff = now - last_terminal_esc
    last_terminal_esc = now

    if diff > 0 and diff < 700 then
        last_terminal_esc = 0
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
        return
    end

    local job_id = vim.b.terminal_job_id
    if job_id then
        vim.api.nvim_chan_send(job_id, "\27")
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    end
end

map('t', '<ESC>', terminal_esc, { nowait = true, desc = "ESC in terminal (hold or double-tap for normal mode)" })

map('n', '<leader>so', '<cmd>update<CR><cmd>source<CR>', { desc = "Save and reload file" })
map({ 'n', 'i' }, "<A-k>", '<cmd>m -2<CR>', { desc = "Move line up" })
map({ 'n', 'i' }, "<A-j>", '<cmd>m +1<CR>', { desc = "Move line down" })
map('x', "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map('x', "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
local function toggle_terminal()
    local visible = vim.iter(Snacks.terminal.list()):find(function(t)
        return t:valid()
    end)
    if visible then
        return visible:hide()
    end

    Snacks.terminal.toggle(nil, { cwd = require("utils.oil").visible_dir() })
end

map('n', '<leader>tt', toggle_terminal, { desc = "Open/close terminal" })

map('n', '<leader>/', "gcc", { remap = true, desc = "Comment line" })
map('x', '<leader>/', "gc", { remap = true, desc = "Comment selection" })

map('n', '<leader>w', '<cmd>write<CR>', { desc = "Save file" })
map('n', '<leader>bx', '<cmd>bdelete<CR>', { desc = "Close buffer" })
map('n', '<leader>bn', '<cmd>bnext<CR>', { desc = "Next buffer" })
map('n', '<leader>bp', '<cmd>bprevious<CR>', { desc = "Previous buffer" })
map({ 'n', 'x' }, '<leader>y', '"+y', { desc = "Copiar al portapapeles" })
map({ 'n', 'x' }, '<leader>d', '"+d', { desc = "Cortar al portapapeles" })
map({ 'n', 'x' }, '<leader>s', '<cmd>e #<CR>', { desc = "Switch to previous file" })
map({ 'n', 'x' }, '<leader>h', '<cmd>noh<CR>', { desc = "Clear search highlight" })

local line_wrap_navigation_active = false

local function toggle_wrap_navigation()
  local modes = { 'n', 'x' }

  if line_wrap_navigation_active then
    for _, mode in ipairs(modes) do
      pcall(vim.keymap.del, mode, 'k')
      pcall(vim.keymap.del, mode, 'j')
    end
    line_wrap_navigation_active = false
    print("Physical line navigation (standard k/j)")
  else
    vim.keymap.set(modes, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set(modes, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    line_wrap_navigation_active = true
    print("Visual line navigation (gk/gj active)")
  end
end

vim.keymap.set('n', '<leader>tw', toggle_wrap_navigation, { desc = "Toggle wrap navigation (gk/gj)" })
vim.keymap.set('n', '<leader>tb', function()
    require("utils.theme").toggle_transparency()
end, { desc = "Toggle transparent/opaque background" })

local lsp_nav = {
    definition = function() Snacks.picker.lsp_definitions() end,
    references = function() Snacks.picker.lsp_references() end,
    implementation = function() Snacks.picker.lsp_implementations() end,
    type_definition = function() Snacks.picker.lsp_type_definitions() end,
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end
        local bufnr = args.buf

        if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end

        local function lsp_map(keys, func, desc, scope)
            local prefix = scope and ("LSP(" .. scope .. "): ") or "LSP: "
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = prefix .. desc })
        end

        if client:supports_method("textDocument/formatting") then
            lsp_map("<leader>lf", function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end, "Format buffer with LSP")
        end
        if client:supports_method("textDocument/codeAction") then
            lsp_map("<leader>la", function()
                vim.lsp.buf.code_action({
                    filter = function(a)
                        return not a.disabled
                    end,
                })
            end, "Code actions")
        end
        lsp_map("<leader>lD", vim.diagnostic.open_float, "Open floating diagnostic")
        lsp_map("<leader>lx", function()
            Snacks.picker.diagnostics_buffer()
        end, "Buffer diagnostics")
        lsp_map("<leader>lX", function()
            Snacks.picker.diagnostics()
        end, "Project diagnostics")
        if client:supports_method("textDocument/documentSymbol") then
            lsp_map("<leader>ls", function()
                Snacks.picker.lsp_symbols()
            end, "Document symbols")
        end
        if client:supports_method("workspace/symbol") then
            lsp_map("<leader>lS", function()
                Snacks.picker.lsp_workspace_symbols()
            end, "Project symbols")
        end
        if client:supports_method("textDocument/documentHighlight") then
            lsp_map("<leader>lw", function()
                if Snacks.words.enabled then
                    Snacks.words.disable()
                    vim.notify("Reference highlight: disabled")
                else
                    Snacks.words.enable()
                    Snacks.words.update()
                    vim.notify("Reference highlight: enabled")
                end
            end, "Toggle reference highlight")
            lsp_map("]]", function()
                Snacks.words.jump(vim.v.count1)
            end, "Next reference")
            lsp_map("[[", function()
                Snacks.words.jump(-vim.v.count1)
            end, "Previous reference")
        end
        if client:supports_method("textDocument/definition") then
            lsp_map("<leader>ld", lsp_nav.definition, "Go to definition")
            lsp_map("gd", lsp_nav.definition, "Go to definition")
        end
        if client:supports_method("textDocument/references") then
            lsp_map("<leader>lR", lsp_nav.references, "Find references")
            lsp_map("gr", lsp_nav.references, "Find references")
        end
        if client:supports_method("textDocument/implementation") then
            lsp_map("<leader>li", lsp_nav.implementation, "Go to implementation")
            lsp_map("gi", lsp_nav.implementation, "Go to implementation")
        end
        if client:supports_method("textDocument/typeDefinition") then
            lsp_map("<leader>ly", lsp_nav.type_definition, "Go to type definition")
            lsp_map("gy", lsp_nav.type_definition, "Go to type definition")
        end
        if client:supports_method("textDocument/rename") then
            lsp_map("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
        end
        if client:supports_method("textDocument/hover") then
            lsp_map("<leader>lh", vim.lsp.buf.hover, "Show documentation")
        end

        if client.name == "typescript-tools" then
            lsp_map("<leader>lo", "<cmd>TSToolsOrganizeImports<CR>", "Organize imports", "TS")
            lsp_map("<leader>lu", "<cmd>TSToolsRemoveUnusedImports<CR>", "Remove unused imports", "TS")
            lsp_map("<leader>lm", "<cmd>TSToolsAddMissingImports<CR>", "Add missing imports", "TS")
            lsp_map("<leader>lF", "<cmd>TSToolsFixAll<CR>", "Fix all", "TS")
        elseif client.name == "clangd" then
            lsp_map("<leader>ch", "<cmd>ClangdSwitchSourceHeader<CR>", "Switch header/source", "C/C++")
        end
    end,
})

map("n", "<leader>fo", function()
  vim.ui.open(vim.fn.expand("%"))
end, { desc = "Open file in external app" })

map('n', '<leader>mg', '<cmd>CMakeGenerate<CR>', { desc = "CMake: Generate" })
map('n', '<leader>mb', '<cmd>CMakeBuild<CR>', { desc = "CMake: Build" })
map('n', '<leader>mr', '<cmd>CMakeRun<CR>', { desc = "CMake: Run target" })
map('n', '<leader>md', '<cmd>CMakeDebug<CR>', { desc = "CMake: Debug target" })
