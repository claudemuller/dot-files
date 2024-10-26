local wezterm = require("wezterm")

return {
	default_profile = "tmux-default",
	profiles = {
		["tmux-default"] = {
			-- Default TMUX profile
			-- default_prog = {
			-- 	"run-tmux",
			-- },
			set_environment_variables = {},
		},
		["VSDev"] = {
			-- Visual Studio Developer Command Prompt profile
			-- default_prog = {
			-- 	"cmd.exe",
			-- 	"/k",
			-- 	"C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\Common7\\Tools\\VsDevCmd.bat",
			-- },
			set_environment_variables = {},
		},
		["WSL"] = {
			-- WSL profile
			-- default_prog = {
			-- 	"wsl.exe",
			-- 	"-u",
			-- 	"dief",
			-- 	"-d",
			-- 	"Manjaro",
			-- },
			set_environment_variables = {},
		},
	},

	-- Appearance
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 9,
	line_height = 1.2,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	color_scheme = "Catppuccin Mocha",
	hide_tab_bar_if_only_one_tab = true,

	-- Layout
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 4,
	},

	-- Key overrides
	keys = {
		{
			key = "S",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SendString("\x1b:w\n"), -- Sends the ":w" command to save
		},
	},
}
