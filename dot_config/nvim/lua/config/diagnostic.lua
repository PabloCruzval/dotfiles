vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign".. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
