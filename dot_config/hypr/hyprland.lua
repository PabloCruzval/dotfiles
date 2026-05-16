-- Hyprland configuration for Desktop PC
-- Import modular configurations
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
    
    return "archtower"
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

local hostname = get_hostname()

if (hostname == "archtower") then
	require("modules.monitors-desktop")
elseif (hostname == "lnyx")  then
	require("modules.monitors-laptop")
end
