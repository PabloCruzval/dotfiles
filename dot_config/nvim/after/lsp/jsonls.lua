local schemastore_status, schemastore = pcall(require, "schemastore")
if not schemastore_status then
  return {}
end

return {
  settings = {
    json = {
      schemas = schemastore.json.schemas({
        ignore = {
          '.eslintrc',
        },
      }),
      validate = { enable = true },
    },
  },
  filetypes = { "json", "jsonc" },
}
