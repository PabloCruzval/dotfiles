-- Environment variables
local ipc = "qs -c noctalia-shell ipc call"

hl.env("XDG_CURRENT_DESKTOP","Hyprland")
hl.env("XDG_SESSION_DESKTOP","Hyprland")
hl.env("XCURSOR_SIZE","34")
hl.env("HYPRCURSOR_SIZE","34")
hl.env("XCURSOR_THEME","volantes_cursors")
hl.env("XCURSOR_PATH","/usr/share/icons:/home/nyx/.local/share/icons")
hl.env("QT_QPA_PLATFORM","wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME","qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION","1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR","1")
hl.env("XDG_MENU_PREFIX","arch-")
