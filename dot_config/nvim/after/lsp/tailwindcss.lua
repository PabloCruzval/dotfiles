return {
    settings = {
        tailwindCSS = {
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
