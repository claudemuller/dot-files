local wezterm = require("wezterm")

local function mergeTables(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" and type(t1[k]) == "table" then
			mergeTables(t1[k], v)
		else
			t1[k] = v
		end
	end
	return t1
end

local profiles = {
	tmux = {
		-- Default TMUX profile
		-- default_prog = {
		-- 	"run-tmux",
		-- },
		set_environment_variables = {},
		font = wezterm.font("JetBrainsMono Nerd Font"),
	},
	vsdev = {
		-- Visual Studio Developer Command Prompt profile
		default_prog = {
			"cmd.exe",
			"/k",
			"C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\Common7\\Tools\\VsDevCmd.bat",
		},
		set_environment_variables = {},
		font = wezterm.font("JetBrainsMono NF"),
	},
	manjaro = {
		-- Manjaro in WSL profile
		default_prog = {
			"wsl.exe",
			"-u",
			"dief",
			"-d",
			"Manjaro",
		},
		set_environment_variables = {},
		font = wezterm.font("JetBrainsMono Nerd Font"),
	},
}

return mergeTables(profiles.vsdev, {
	-- Appearance
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
})
