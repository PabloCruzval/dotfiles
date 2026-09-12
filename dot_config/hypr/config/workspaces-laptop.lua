local monitors = hl.get_monitors()

if monitors[1] then
	PRIMARY_MONITOR = monitors[1].name
end

hl.workspace_rule({ workspace = "name:gaming", monitor = PRIMARY_MONITOR, default = true })

for monitor_index, monitor in ipairs(monitors) do
	for workspace_offset = 1, NUM_WPM do
		local workspace = (monitor_index - 1) * NUM_WPM + workspace_offset
		hl.workspace_rule({
			workspace = tostring(workspace),
			monitor = monitor.name,
			persistent = true,
		})
	end
end

-- Re-evaluate workspace groups after a display is connected.
hl.on("monitor.added", function()
	hl.exec_cmd("hyprctl reload")
end)
