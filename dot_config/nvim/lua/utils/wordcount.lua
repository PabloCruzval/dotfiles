local WPM = 200

local PROSE_PATTERNS = { "*.md", "*.adoc" }
local TYPST_PATTERN = "*.typ"

local M = {}

local function builtin_count()
    local wc = vim.fn.wordcount()
    local rt = math.ceil(wc.words / WPM)
    return string.format("%d words | ~%d min", wc.words, rt)
end

local function prose_count()
    local ok, prose = pcall(require, "nvim-prose")
    if ok then
        return string.format("%s | %s", prose.word_count(), prose.reading_time())
    end
    return nil
end

local function typst_count(bufnr)
    local ok, ts = pcall(require, "utils.tinymist_status")
    if not ok then
        return nil, "tinymist_status module unavailable"
    end
    local wc = ts.get_word_count(bufnr)
    if not wc then
        return nil, "Compiling... wait and try again"
    end
    local rt = math.ceil(wc.words / WPM)
    return string.format("%d words | %d chars | ~%d min", wc.words, wc.chars, rt), nil
end

vim.api.nvim_create_user_command("WordCount", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.bo[bufnr].filetype
    local msg
    local level = vim.log.levels.INFO
    local title = "Word count"

    if ft == "typst" then
        local err_msg
        msg, err_msg = typst_count(bufnr)
        if not msg then
            msg = err_msg
            level = vim.log.levels.WARN
        end
        title = "Typst"
    else
        msg = prose_count() or builtin_count()
    end

    vim.notify(msg, level, { title = title })
end, {})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { TYPST_PATTERN },
    callback = function()
        local msg, _ = typst_count()
        if msg then
            vim.api.nvim_echo({ { msg, "Comment" } }, false, {})
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = PROSE_PATTERNS,
    callback = function()
        local msg = prose_count()
        if msg then
            vim.api.nvim_echo({ { msg, "Comment" } }, false, {})
        end
    end,
})

return M
