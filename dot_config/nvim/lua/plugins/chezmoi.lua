return {
  "xvzc/chezmoi.nvim",
  ft = "gotmpl",
  config = function()
    require("chezmoi").setup {
      edit = {
        watch = false,
        force = false,
      },
    }
  end,
}
