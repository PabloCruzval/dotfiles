return {
  cmd = { "emmet-language-server", "--stdio" },
  filetypes = { 
    "astro", 
    "css", 
    "html", 
    "javascriptreact", 
    "typescriptreact", 
    "less", 
    "sass", 
    "scss",
    "vue"
  },
  root_markers = { ".git", "package.json" },
  
  init_options = {
    jsx = {
      options = {
        ["jsx.enabled"] = true,
        ["markup.attributes"] = {
          ["class"] = "className",
          ["class*"] = "className",
          ["for"] = "htmlFor",
        },
        ["markup.valuePrefix"] = {
          ["class*"] = "styles",
        },
      },
    },
    showSuggestionsAsSnippets = true,
    showExpandedAbbreviation = "always",
  },
}
