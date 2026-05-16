-- Monitor configuration for Notebook
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1
})

for i = 1, 5 do
	hl.workspace_rule({workspace = i, monitor="eDP-1"})
end
for i = 5, 10 do
	hl.workspace_rule({workspace = i, monitor="HDMI-A-1"})
end
