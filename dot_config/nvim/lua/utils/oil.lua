local M = {}

--- Directorio del primer buffer de Oil visible en el tab actual
--- (prioriza la ventana activa). Retorna nil si no hay ninguno.
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

return M
