-- Desktop monitor configuration (t-nyx)
-- DP-1: primary 144Hz, HDMI-A-1: secondary 75Hz

hl.monitor({
	output   = "DP-1",
	mode     = "1920x1080@144",
	position = "0x0",
	scale    = 1,
})

hl.monitor({
	output   = "HDMI-A-1",
	mode     = "1920x1080@75",
	position = "-1920x0",
	scale    = 1,
})
