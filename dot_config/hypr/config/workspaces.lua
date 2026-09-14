local monitors = hl.get_monitors()
local assigned = {}
local next_workspace = NUM_WPM + 1

-- Reserve the first group for the primary monitor; distribute later groups
-- to connected secondary displays in their reported order.
for _, monitor in ipairs(monitors) do
	if monitor.name ~= PRIMARY_MONITOR then
		for _ = 1, NUM_WPM do
			if next_workspace > 10 then
				break
			end

			assigned[next_workspace] = monitor.name
			next_workspace = next_workspace + 1
		end
	end
end

for workspace = 1, 10 do
	hl.workspace_rule({
		workspace = tostring(workspace),
		monitor = assigned[workspace] or PRIMARY_MONITOR,
		persistent = true,
	})
end

hl.workspace_rule({ workspace = "name:gaming", monitor = PRIMARY_MONITOR, default = true })
hl.workspace_rule({ workspace = "3", layout = "scrolling" })

-- Re-evaluate the secondary monitor groups when a display is connected.
hl.on("monitor.added", function()
	hl.exec_cmd("hyprctl reload")
end)
