return {
    cmd = { "ruby-lsp" },
    filetypes = { "ruby" },
    root_markers = { "Gemfile", ".ruby-version", ".git" },
    init_options = {
        formatter = "rubocop",
        linters = { "rubocop" },
    },
}