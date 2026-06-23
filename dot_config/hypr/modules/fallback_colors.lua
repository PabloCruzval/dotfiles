-- -----------------------------------------------------
-- █▀▀ ▄▀█ █   ▄▀█ █▄▀ █▀█ █   █▀▀   █▀▀ █▀█ █▄░█ █▀▀
-- █▀░ █▀█ █▄▄ █▀█ █░█ █▀█ █▄▄ ██▄   █▄▄ █▄█ █░▀█ ██▄
-- -----------------------------------------------------
--
-- Fallback Nord color palette used when Noctalia v5 theme
-- template is not available or has not been applied yet.
-- All Hyprland color values should be defined here so that
-- individual modules stay color-agnostic.

local colors = {
    -- Nord palette
    nord0  = "rgba(46,52,64,1.0)",    -- polar night darkest
    nord1  = "rgba(59,66,82,1.0)",    -- polar night darker
    nord2  = "rgba(67,76,94,1.0)",    -- polar night
    nord3  = "rgba(76,86,106,1.0)",    -- polar night light
    nord4  = "rgba(216,222,233,1.0)",  -- snow storm dark
    nord5  = "rgba(229,233,240,1.0)",  -- snow storm
    nord6  = "rgba(236,239,244,1.0)",  -- snow storm light
    nord7  = "rgba(143,188,187,1.0)",  -- frost aqua
    nord8  = "rgba(136,192,208,1.0)",  -- frost light blue
    nord9  = "rgba(129,161,193,1.0)",  -- frost blue
    nord10 = "rgba(94,129,172,1.0)",   -- frost dark blue
    nord11 = "rgba(191,97,106,1.0)",   -- aurora red
    nord12 = "rgba(208,135,112,1.0)",  -- aurora orange
    nord13 = "rgba(235,203,139,1.0)",  -- aurora yellow
    nord14 = "rgba(163,190,140,1.0)",  -- aurora green
    nord15 = "rgba(180,142,173,1.0)",  -- aurora purple

    -- Hyprland semantic colors
    active_border   = "rgba(136,192,208,1.0)",  -- nord8
    inactive_border = "rgba(59,66,82,1.0)",      -- nord1
    shadow          = "rgba(46,52,64,1.0)",      -- nord0
}

return colors
