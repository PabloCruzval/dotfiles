-- CachyOS Hyprland Configuration

local function get_hostname()
	local f = io.open("/etc/hostname", "r")
	if f then
		local host = f:read("*l")
		f:close()
		return host
	end
	local handle = io.popen("hostname")
	if handle then
		local host = handle:read("*l")
		handle:close()
		return host
	end
	return "t-nyx"
end

HOSTNAME = get_hostname()

require("config.animations")
require("config.autostart")
require("config.colors")
require("config.decorations")
require("config.variables")
require("config.environment")
require("config.inputs")

-- Laptop: override monitor variables for auto-detection
if HOSTNAME ~= "t-nyx" then
	MONITOR1 = ""
	MONITOR2 = ""
	MONITOR3 = ""
	PRIMARY_MONITOR = MONITOR1
end

require("config.binds")
require("config.misc")

if HOSTNAME == "t-nyx" then
	require("config.monitors-desktop")
	require("config.workspaces-desktop")
else
	require("config.monitors-laptop")
	require("config.workspaces-laptop")
end

require("config.windowrules")

-- Noctalia color templates
require("noctalia").apply_theme()
