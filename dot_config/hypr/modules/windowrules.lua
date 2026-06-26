-- Window rules

-- Center all floating windows by default. This prevents them from spawning
-- at global coordinates (0,0) when opened from a workspace different from
-- their target workspace (e.g. Discord updater opened while on HDMI-A-1).
hl.window_rule({ match = { float = true }, center = true })

hl.window_rule({workspace = "2", match = {title = ".*Brave.*"}})
hl.window_rule({workspace = "3", match = {title = ".*Visual Studio.*"}})
hl.window_rule({workspace = "4", match = {title = ".*Obsidian.*"}})
hl.window_rule({workspace = "5", match = {title = ".*Nautilus.*"}})
hl.window_rule({workspace = "5", match = {title = ".*Discord.*"}})
hl.window_rule({workspace = "5", match = {title = ".*Telegram.*"}})

-- Workspace 3 uses scrolling layout
hl.workspace_rule({ workspace = "3", layout = "scrolling" })

hl.layer_rule({
  name = "noctalia",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$",
  },
  no_anim = true,
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})
