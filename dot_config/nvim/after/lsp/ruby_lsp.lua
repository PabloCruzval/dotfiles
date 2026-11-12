return {
    mason = false,
    root_markers = { "Gemfile", ".ruby-version", ".git" },
    init_options = {
        formatter = "rubocop_internal",
        linters = { "rubocop_internal" },
    },
}
