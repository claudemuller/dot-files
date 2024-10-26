local wezterm = require("wezterm")

return {
	-- Visual Studio Developer Command Prompt profile
	default_prog = {
		"cmd.exe",
		"/k",
		"C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\Common7\\Tools\\VsDevCmd.bat",
	},
	set_environment_variables = {},
	-- Appearance
	font = wezterm.font("JetBrainsMono NF"),
	font_size = 9.5,
	line_height = 1.2,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	color_scheme = "Omni (Gogh)",
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
