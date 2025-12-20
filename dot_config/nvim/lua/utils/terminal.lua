local split_win = function()
	local actual_window = vim.api.nvim_get_current_win()
	vim.cmd "split"
	vim.api.nvim_set_current_win(actual_window)
end

local SplitTerminal = function()
	local buf_is_valid = vim.g.terminal_saved_buffer ~= nil and vim.api.nvim_buf_is_valid(vim.g.terminal_saved_buffer) or false
	local win_is_valid = vim.g.terminal_saved_win ~= nil and vim.api.nvim_win_is_valid(vim.g.terminal_saved_win) or false
	if win_is_valid and buf_is_valid then
		vim.api.nvim_win_close(vim.g.terminal_saved_win, true)
		vim.g.terminal_saved_win = nil
	elseif buf_is_valid then
		split_win()
		vim.api.nvim_set_current_buf(vim.g.terminal_saved_buffer)
		vim.g.terminal_saved_win = vim.api.nvim_get_current_win()
	else
		split_win()
		vim.cmd "terminal"
		vim.g.terminal_saved_buffer = vim.api.nvim_get_current_buf()
		vim.g.terminal_saved_win = vim.api.nvim_get_current_win()
	end
end

return SplitTerminal
