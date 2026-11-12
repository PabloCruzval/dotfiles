require("config.variables")
require("config.monitors")
require("config.animations")
require("config.autostart")
require("config.colors")
require("config.decorations")
require("config.inputs")
require("config.binds")
require("config.misc")
require("config.workspaces")
require("config.windowrules")

local ok, noctalia = pcall(function() return require("noctalia") end)
if ok then
	noctalia.apply_theme()
end
