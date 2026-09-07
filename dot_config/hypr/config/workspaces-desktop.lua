for i = 1, 5 do
	hl.workspace_rule({ workspace = i, monitor = "DP-1" })
end
for i = 6, 10 do
	hl.workspace_rule({ workspace = i, monitor = "HDMI-A-1" })
end

hl.workspace_rule({ workspace = "3", layout = "scrolling" })
