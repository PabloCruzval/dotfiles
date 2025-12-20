local states = {
	buff = nil,
	win = nil
}

local SplitTerminal = function()
	local buf_is_valid = states.buff ~= nil and vim.api.nvim_buf_is_valid(states.buff) or false
	local win_is_valid = states.win ~= nil and vim.api.nvim_win_is_valid(states.win) or false
	if win_is_valid and buf_is_valid then
		vim.api.nvim_win_close(states.win, true)
		states.win = nil
	elseif buf_is_valid then
		vim.cmd "botright split"
		vim.api.nvim_set_current_buf(states.buff)
		states.win = vim.api.nvim_get_current_win()
		vim.cmd "startinsert"
	else
		vim.cmd "botright split"
		vim.cmd "terminal"
		states.buff = vim.api.nvim_get_current_buf()
		states.win = vim.api.nvim_get_current_win()
		vim.cmd "startinsert"
	end
end

return SplitTerminal
