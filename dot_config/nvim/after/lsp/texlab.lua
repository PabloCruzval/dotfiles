return {
    settings = {
        texlab = {
            build = {
                onSave = false,
                forwardSearchAfter = false,
            },
            forwardSearch = {
                executable = "zathura",
                args = {
                    "--synctex-forward",
                    "%l:1:%f",
                    "%p",
                },
            },
            chktex = {
                onOpenAndSave = false,
                onEdit = false,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false,
            },
            bibtexFormatter = "texlab",
        },
    },
}
