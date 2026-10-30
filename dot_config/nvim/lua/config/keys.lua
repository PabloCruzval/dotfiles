local M = {}

-- DAP
M.dap_toggle_breakpoint = function()
    require("dap").toggle_breakpoint()
end

M.dap_conditional_breakpoint = function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end

M.dap_continue = function()
    require("dap").continue()
end

M.dap_step_over = function()
    require("dap").step_over()
end

M.dap_step_into = function()
    require("dap").step_into()
end

M.dap_step_out = function()
    require("dap").step_out()
end

M.dap_repl = function()
    require("dap").repl.open()
end

M.dap_toggle_ui = function()
    require("dapui").toggle()
end

-- Test (neotest)
M.test_nearest = function()
    require("neotest").run.run()
end

M.test_file = function()
    require("neotest").run.run(vim.fn.expand("%"))
end

M.test_debug = function()
    require("neotest").run.run({ strategy = "dap" })
end

M.test_output = function()
    require("neotest").output.open({ enter = true })
end

M.test_summary = function()
    require("neotest").summary.toggle()
end

-- Oil
M.oil_open = function()
    require("oil").open()
end

M.oil_open_root = function()
    local root = vim.g.root_cwd or vim.fn.getcwd()
    vim.cmd({ cmd = "cd", args = { root } })
    require("oil").open(root)
    vim.notify(string.format("CWD: %s", root), vim.log.levels.INFO)
end

M.oil_set_root = function()
    local ok, oil = pcall(require, "oil")
    local dir = ok and oil.get_current_dir()
    if not dir or dir == "" then
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname and bufname ~= "" then
            dir = vim.fs.dirname(bufname)
        else
            dir = vim.fn.getcwd()
        end
    end
    dir = vim.fs.normalize(dir)
    vim.g.root_cwd = dir
    vim.cmd({ cmd = "cd", args = { dir } })
    vim.notify(string.format("Root CWD: %s", dir), vim.log.levels.INFO)
end

-- Snacks picker
M.snacks_files = function()
    Snacks.picker.files()
end

M.snacks_recent_files = function()
    Snacks.picker.recent({ filter = { cwd = true } })
end

M.snacks_buffers = function()
    Snacks.picker.buffers()
end

M.snacks_help = function()
    Snacks.picker.help()
end

M.snacks_live_grep = function()
    Snacks.picker.grep()
end

M.snacks_colorschemes = function()
    require("utils.theme").pick()
end

return M

