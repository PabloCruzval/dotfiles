vim.filetype.add({
	extension = {
		tmpl = function(path, bufnr)
			local filename = vim.fn.fnamemodify(path, ":t")
			local real_extension = filename:match(".*%.(.*)%.tmpl$")

			if real_extension then
				if real_extension == "conf" then
					if filename:match("hyprland") then
						return "hyprlang"
					end
					return "conf"
				end

				return real_extension
			end

			return "gotmpl"
		end,
	},
})
