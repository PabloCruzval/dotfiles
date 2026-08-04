-- Input configuration

hl.config({
    input = {
        kb_layout = "us",
        kb_options = "caps:escape",
        numlock_by_default = true,
        accel_profile = "flat",
        force_no_accel = true,
        follow_mouse = 1,

        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            drag_lock = false,
        },

        tablet = {
            output = "DP-1",
        },
    },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down",       action = "close" })
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left",       action = "float" })
