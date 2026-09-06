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

M.oil_toggle_hidden = function()
    require("oil").toggle_hidden()
end

-- Mini.pick
M.pick_files = function()
    vim.cmd("Pick files")
end

M.pick_buffers = function()
    vim.cmd("Pick buffers")
end

M.pick_help = function()
    vim.cmd("Pick help")
end

M.pick_grep_live = function()
    vim.cmd("Pick grep_live")
end

return M
