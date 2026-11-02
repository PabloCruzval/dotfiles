hl.config({
    general = {
        layout = "master",
    },
    dwindle = {
        preserve_split = true,
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
        middle_click_paste = false,
        enable_swallow = true,
        swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
        vrr = 3,
    },
    xwayland = {
        force_zero_scaling = true,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
    cursor = {
        zoom_detached_camera = false,
        zoom_rigid = false,
    },
})

if hl.plugin and hl.plugin.macos_zoom ~= nil then
    hl.config({
        plugin = {
            macos_zoom = {
                raw_scroll = true,
                modifier = "CTRL + SHIFT",
                sensitivity = 0.01,
                consume_scroll = true,
                step = 1.20,
                min_factor = 1.0,
                max_factor = 10.0,
                snap_threshold = 1.05,
                toggle_factor = 2.0,
                independent_displays = true,
            },
        },
    })
end

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})
