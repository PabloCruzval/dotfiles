local LoadPlugins = function()
	local Config = require("lazy.core.config")
	local disabled_plugins = {}

	for name, data in pairs(Config.plugins) do
		if data and data._ and not data._.loaded then
			table.insert(disabled_plugins, name)
		end
	end

	table.sort(disabled_plugins)

	MiniPick.start({
		source = {
			items = disabled_plugins,
			name = "Cargar Plugin (Lazy)",
			choose = function(item)
				if item then
					require("lazy").load({ plugins = { item } })
					vim.notify("Plugin cargado: " .. item, vim.log.levels.INFO)

					return true
				end
			end
		}
	})
end

return LoadPlugins
