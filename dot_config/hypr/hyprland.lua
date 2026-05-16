-- Hyprland configuration for Desktop PC
-- Import modular configurations

local function get_hostname()
    local f = io.popen("hostname")
    local hostname = f:read("*a") or ""
    f:close()
    return hostname:gsub("%s+$", "")
end

print(get_hostname())


require("modules.env")
require("modules.general")
require("modules.inputs")
require("modules.decorations")
require("modules.animations")

-- Behavior
require("modules.windowrules")
require("modules.keybindings")
require("modules.autostart")

-- Monitor configuration (device-specific gestionado por chezmoi)
local hostname = get_hostname()

if (hostname == "archtower") then
	require("modules.monitors-desktop")
elseif (hostname == "lnyx")  then
	require("modules.monitors-laptop")
end
