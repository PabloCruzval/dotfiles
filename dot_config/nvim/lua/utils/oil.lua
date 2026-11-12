local M = {}

---@return string|nil
function M.visible_dir()
    local ok, oil = pcall(require, "oil")
    if not ok then
        return nil
    end

    local wins = vim.api.nvim_tabpage_list_wins(0)
    table.insert(wins, 1, vim.api.nvim_get_current_win())

    for _, win in ipairs(wins) do
        local dir = oil.get_current_dir(vim.api.nvim_win_get_buf(win))
        if dir and dir ~= "" then
            return vim.fs.normalize(dir)
        end
    end
end

function M.open_root()
    local root = vim.g.root_cwd or vim.fn.getcwd()
    vim.cmd({ cmd = "cd", args = { root } })
    require("oil").open(root)
    vim.notify(string.format("CWD: %s", root), vim.log.levels.INFO)
end

function M.set_root()
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

return M
