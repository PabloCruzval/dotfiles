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
	hl.exec_cmd("QT_QPA_PLATFORMTHEME=gtk3 qs -c noctalia-shell")

	-- User applications
	hl.exec_cmd("syncthing --no-browser")

	-- GTK & cursor theme
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'volantes-cursors'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 34")
	hl.exec_cmd("hyprctl setcursor volantes_cursors 34")
end)

