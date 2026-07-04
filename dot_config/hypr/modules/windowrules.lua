-- Window rules

local apps = require("modules.apps")

-- Center all floating windows by default. This prevents them from spawning
-- at global coordinates (0,0) when opened from a workspace different from
-- their target workspace (e.g. Discord updater opened while on HDMI-A-1).
hl.window_rule({ match = { float = true }, center = true })

-- Auto-assign windows to workspaces defined in apps.lua
for _, app in pairs(apps) do
    if app.workspace and app.title and not app.class then
        hl.window_rule({
            workspace = tostring(app.workspace),
            match = { title = app.title },
        })
    end
	if app.workspace and app.class then
		hl.window_rule({
			workspace = tostring(app.workspace),
			match = { class = app.class }
		})
	end
end

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
