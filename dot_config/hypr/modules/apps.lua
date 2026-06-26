-- -----------------------------------------------------
-- ▄▀█ █▀█ █▀█ █▀▀
-- █▀█ █▀▀ █▀▀ ▄█
-- -----------------------------------------------------
-- Shared application definitions.
-- Change apps in one place — keybindings and window rules
-- pick up cmd, title matching, and workspace assignments.

return {
	browser = {
		cmd = "librewolf",
		title = ".*LibreWolf.*",
		workspace = 2,
	},
	terminal = {
		cmd = "kitty",
	},
	fileManager = {
		cmd = "nautilus",
		title = ".*Nautilus.*",
		workspace = 5,
	},
	obsidian = {
		cmd = "obsidian",
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
		cmd = "emote",
	},
}
