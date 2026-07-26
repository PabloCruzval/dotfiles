-- Desktop workspace rules (t-nyx)
-- Global fixed model: 1-5 on DP-1, 6-10 on HDMI-A-1

for i = 1, 5 do
	hl.workspace_rule({ workspace = i, monitor = "DP-1" })
end
for i = 6, 10 do
	hl.workspace_rule({ workspace = i, monitor = "HDMI-A-1" })
end

hl.workspace_rule({ workspace = "3", layout = "scrolling" })
