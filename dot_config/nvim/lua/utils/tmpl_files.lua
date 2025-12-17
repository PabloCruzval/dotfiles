vim.filetype.add({
	extension = {
		tmpl = function(path, _bufnr)
			local filename = vim.fn.fnamemodify(path, ":t")
			
			local real_extension = filename:match("%.([^%.]+)%.tmpl$")
			
			if not real_extension then
				return "gotmpl"
			end
			
			if real_extension == "conf" and filename:match("hypr") then
				return "hyprlang"
			end
			
			return real_extension
		end,
	},
})
