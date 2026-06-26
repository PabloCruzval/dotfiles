local M = {}

local nord = {
	base00 = "#2e3440",
	base01 = "#3b4252",
	base02 = "#434c5e",
	base03 = "#4c566a",
	base04 = "#d8dee9",
	base05 = "#e5e9f0",
	base06 = "#eceff4",
	base07 = "#8fbcbb",
	base08 = "#bf616a",
	base09 = "#d08770",
	base0A = "#ebcb8b",
	base0B = "#a3be8c",
	base0C = "#88c0d0",
	base0D = "#81a1c1",
	base0E = "#b48ead",
	base0F = "#5e81ac",
}

function M.load()
	local ok, matugen = pcall(require, "matugen")

	if ok and matugen and matugen.setup then
		vim.notify("Noctalia: applying generated palette", vim.log.levels.INFO)
		matugen.setup()
	else
		vim.notify("Noctalia: generated palette not found, using Nord fallback", vim.log.levels.WARN)
		local ok2, base16 = pcall(require, "base16-colorscheme")
		if ok2 then
			base16.setup(nord)
		else
			vim.cmd.colorscheme("default")
		end
	end
end

return M
