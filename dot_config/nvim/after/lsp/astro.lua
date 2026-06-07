return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  init_options = {
    typescript = {
      tsdk = "node_modules/typesscript/lib"
    },
  },
}
