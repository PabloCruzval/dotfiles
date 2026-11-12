return {
    filetypes = { "json", "jsonc" },
    before_init = function(_, config)
        config.settings.json.schemas = config.settings.json.schemas or {}
        local ok, schemastore = pcall(require, "schemastore")
        if ok then
            vim.list_extend(
                config.settings.json.schemas,
                schemastore.json.schemas({ ignore = { ".eslintrc" } })
            )
        end
    end,
    settings = {
        json = {
            validate = { enable = true },
        },
    },
}
