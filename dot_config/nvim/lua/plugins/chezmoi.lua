return {
  "xvzc/chezmoi.nvim",
  ft = "gotmpl",
  config = function()
    require("chezmoi").setup {
      -- Esto ayuda a editar los archivos
      edit = {
        watch = false,
        force = false,
      },
    }
  end,
}
