local virtual_text = {
  prefix = "●",
  source = "if_many",
  spacing = 4,
}

vim.diagnostic.config({
  virtual_text = virtual_text,
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

local function set_virtual_text_highlights()
  for _, severity in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    vim.api.nvim_set_hl(0, "DiagnosticVirtualText" .. severity, {
      fg = vim.api.nvim_get_hl(0, { name = "Diagnostic" .. severity }).fg,
      bg = nil,
    })
  end
end

set_virtual_text_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_virtual_text_highlights,
})

local virtual_text_enabled = true

local function toggle_virtual_text()
  virtual_text_enabled = not virtual_text_enabled
  vim.diagnostic.config({ virtual_text = virtual_text_enabled and virtual_text or false })
  vim.notify("Texto virtual de diagnósticos: " .. (virtual_text_enabled and "activado" or "desactivado"))
end

vim.keymap.set("n", "<leader>lt", toggle_virtual_text, {
  desc = "LSP: Alternar texto virtual de diagnósticos",
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign".. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
