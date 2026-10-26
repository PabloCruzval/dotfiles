return {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = false,
            },
        },
    },
    settings = {
        tailwindCSS = {
            files = {
                exclude = {
                    "**/.git/**",
                    "**/node_modules/**",
                    "**/.next/**",
                    "**/dist/**",
                    "**/build/**",
                    "**/.turbo/**",
                },
            },
            includeLanguages = {
                astro = "html",
                javascript = "jsx",
                javascriptreact = "jsx",
                typescript = "tsx",
                typescriptreact = "tsx",
            },
            experimental = {
                classRegex = {
                    { "clsx\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                    { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                },
            },
        },
    },
}
