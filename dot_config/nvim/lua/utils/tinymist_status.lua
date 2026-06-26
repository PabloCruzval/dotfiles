local M = {}

M.buffer = {}

vim.lsp.handlers["tinymist/compileStatus"] = function(err, result, ctx)
    if err or not result then
        return
    end
    local bufnr = ctx.bufnr or vim.api.nvim_get_current_buf()
    M.buffer[bufnr] = result
end

function M.get_word_count(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local status = M.buffer[bufnr]
    if status and status.wordsCount then
        return {
            words = status.wordsCount.words or 0,
            chars = status.wordsCount.chars or 0,
            spaces = status.wordsCount.spaces or 0,
            status = status.status,
        }
    end
    return nil
end

return M
