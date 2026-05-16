-- Monitor configuration for Desktop PC

hl.monitor({
	output = "DP-1",
	mode = "1920x1080@144",
	position = "0x0",
	scale = 1
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@75",
	position = "-1920x0",
	scale = 1
})

-- Workspace bindings for multi-monitor setup
for i = 1, 5 do
	hl.workspace_rule({workspace = i, monitor="DP-1"})
end
for i = 5, 10 do
	hl.workspace_rule({workspace = i, monitor="HDMI-A-1"})
end
