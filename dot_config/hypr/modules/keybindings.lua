-- ----------------------------------------------------- 
 -- █▄▀ ██▀ █▄█ █▄▄ █ █▄ █ █▀▄ █ █▄ █ ▄▀  █▀ 
 -- █ █ ██▄  █  █▄█ █ █ ▀█ █▄▀ █ █ ▀█ ▀▄█ ▄█ 
 -- ----------------------------------------------------- 

local mainMod = "SUPER"

local ipc = "noctalia msg"
local programs = {
	browser = "librewolf",
	terminal = "kitty",
	fileManager = "nautilus",
	launcher = ipc .. " panel-toggle launcher",
	menu = ipc .. " panel-toggle control-center"
}
--  ----------------------------------------------------- 
--  █▀ █▄█ █▀ ▀█▀ ██▀ █▀▄▀█ 
--  ▄█  █  ▄█  █  ██▄ █ ▀ █ 
--  ----------------------------------------------------- 

hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + M",         hl.dsp.window.fullscreen({action="toggle"}))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("hyprshutdown"))

--  ----------------------------------------------------- 
--  ▄▀█ █▀█ █▀█ █   █ ▄▀▀ ▄▀█ ▀█▀ █ █▀█ █▄ █ █▀ 
--  █▀█ █▀▀ █▀▀ █▄▄ █ ▀▄▄ █▀█  █  █ █▄█ █ ▀█ ▄█ 
--  ----------------------------------------------------- 

hl.bind(mainMod .. " + Return",    hl.dsp.exec_cmd(programs["terminal"]))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(programs["fileManager"]))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(ipc .. " panel-toggle clipboard"))
hl.bind(mainMod .. " + SUPER_L",   hl.dsp.exec_cmd(programs["menu"]))
hl.bind(mainMod .. " + SPACE",         hl.dsp.exec_cmd(programs["launcher"]))
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(programs["browser"]))
hl.bind(mainMod .. " + ALT + period", hl.dsp.exec_cmd("emote"))
hl.bind(mainMod .. " + O",         hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))

--  ----------------------------------------------------- 
--  █░█░█ █ █▄ █ █▀▄ █▀█ █░█░█   █▀▄▀█ ▄▀█ █▄ █ ▄▀█ ▄▀  ██▀ █▀▄▀█ ██▀ █▄ █ ▀█▀ 
--  ▀▄▀▄▀ █ █ ▀█ █▄▀ █▄█ ▀▄▀▄▀   █ ▀ █ █▀█ █ ▀█ █▀█ ▀▄█ ██▄ █ ▀ █ ██▄ █ ▀█  █  
--  ----------------------------------------------------- 

-- Move focus with arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction ="left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move focus with vim keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move/resize windows with mouse (Asumiendo que la API tiene 'bindm' para eventos de mouse)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- ----------------------------------------------------- 
-- █░█░█ █▀█ █▀▄ █▄▀ █▀ █▀█ ▄▀█ ▄▀▀ ██▀ █▀ 
-- ▀▄▀▄▀ █▄█ █▀▄ █ █ ▄█ █▀▀ █▀█ ▀▄▄ ██▄ ▄█ 
-- ----------------------------------------------------- 

-- Switch workspaces and Move active window to workspace [1-9]
for i = 1, 10 do
	local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i}))
end

-- Switch to previous workspace
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Scroll through existing workspaces with mainMod + scroll

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- -----------------------------------------------------
-- █▀▄ █▀▀ █▄ █ █▀▄ █▀▀ █   █▄░█ █▀▄▀█
-- █▄▀ ██▄ █ ▀█ █▄▀ ██▄ █   █ ▀█ █ ▀ █
-- -----------------------------------------------------

-- Scrolling layout controls (workspace 3)
hl.bind(mainMod .. " + comma",       hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + period",      hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + semicolon",   hl.dsp.layout("fit active"))
hl.bind(mainMod .. " + colon", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.layout("expel"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.layout("consume"))

-- -----------------------------------------------------
-- █▀▄▀█ █▄█ █▀▄ █▄ ▄█ █▀▀ █▀▄▀█
-- █ ▀ █ █ █ █▄▀ █ ▀ █ ██▄ █ ▀ █
-- -----------------------------------------------------

-- Master layout controls (Vim-style)
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.layout("swapwithmaster master"))
hl.bind(mainMod .. " + SHIFT + I",    hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + SHIFT + D",    hl.dsp.layout("removemaster"))
hl.bind(mainMod .. " + SHIFT + J",    hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + SHIFT + K",    hl.dsp.layout("cycleprev"))

hl.bind(mainMod .. " + ALT + h",      hl.dsp.layout("mfact -0.05"))
hl.bind(mainMod .. " + ALT + l",      hl.dsp.layout("mfact +0.05"))
hl.bind(mainMod .. " + ALT + j",      hl.dsp.layout("orientationprev"))
hl.bind(mainMod .. " + ALT + k",      hl.dsp.layout("orientationnext"))

-- -----------------------------------------------------
-- █▀▄▀█ ██▀ █▀▄ █ ▄▀█   ▄▀▀ █▀█ █▄ █ ▀█▀ █▀▄ █▀█ █   █▀
-- █ ▀ █ ██▄ █▄▀ █ █▀█   ▀▄▄ █▄█ █ ▀█  █  █▀▄ █▄█ █▄▄ ▄█
-- -----------------------------------------------------

-- Audio controls (Sin modificador = enviamos el nombre de la tecla directamente)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"))

-- Brightness controls
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))
