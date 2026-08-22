-- Shared application definitions.
-- Change apps in one place — keybindings and window rules
-- pick up cmd, title matching, and workspace assignments.

return {
	browser = {
		cmd = "uwsm app -- brave",
		title = ".*Brave.*",
		workspace = 2,
	},
	terminal = {
		cmd = "uwsm app -- " .. TERMINAL,
	},
	fileManager = {
		cmd = "uwsm app -- dolphin",
		class = "org.gnome.Nautilus",
		workspace = 5,
	},
	obsidian = {
		cmd = "uwsm app -- obsidian",
		title = ".*Obsidian.*",
		workspace = 4,
	},
	vscode = {
		title = ".*Visual Studio.*",
		workspace = 3,
	},
	discord = {
		title = ".*Discord.*",
		workspace = 5,
	},
	telegram = {
		title = ".*Telegram.*",
		workspace = 5,
	},
	emote = {
		cmd = "uwsm app -- emote",
	},
}
