local schemas
local function get_schemas()
    if not schemas then
        local ok, schemastore = pcall(require, "schemastore")
        schemas = ok and schemastore.json.schemas({ ignore = { ".eslintrc" } }) or {}
    end
    return schemas
end

local configured = false

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc" },
    callback = function()
        if configured then
            return
        end
        configured = true

        vim.lsp.config("jsonls", {
            filetypes = { "json", "jsonc" },
            settings = {
                json = {
                    validate = { enable = true },
                    schemas = get_schemas(),
                },
            },
        })
        vim.lsp.enable("jsonls")
    end,
})