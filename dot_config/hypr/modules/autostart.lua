-------------------------------------------------------- 
-- ▄▀█ █ █ ▀█▀ █▀█ █▀ ▀█▀ ▄▀█ █▀▄ ▀█▀ 
-- █▀█ █▄█  █  █▄█ ▄█  █  █▀█ █▀▄  █  
-------------------------------------------------------- 

hl.on("hyprland.start", function()
	-- System services
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("noctalia")

	-- User applications
	hl.exec_cmd("syncthing --no-browser")

	-- Cursor theme (GTK is handled by Noctalia v5 templates)
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'volantes-cursors'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 34")
	hl.exec_cmd("hyprctl setcursor volantes_cursors 34")
end)

