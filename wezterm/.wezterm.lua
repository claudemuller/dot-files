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
	-- Default TMUX profile
	tmux = {
		default_prog = {
			"run-tmux",
		},
		set_environment_variables = {},
		font = wezterm.font("JetBrainsMono Nerd Font"),
	},
	-- Visual Studio Developer Command Prompt profile
	vsdev = {
		default_prog = {
			"cmd.exe",
			"/k",
			"C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\Common7\\Tools\\VsDevCmd.bat",
		},
		set_environment_variables = {},
		font = wezterm.font("JetBrainsMono NF"),

		-- TMUX leader
		leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2001 },
	},
	-- Manjaro in WSL profile
	manjaro = {
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

local default_profile = function()
	local is_windows = package.config:sub(1, 1) == "\\"
	print(is_windows)
	if is_windows then
		return "vsdev"
	end
	return "tmux"
end
local profile = os.getenv("WEZTERM_PROFILE") or default_profile()

return mergeTables(profiles[profile], {
	-- Appearance
	font_size = 9,
	line_height = 1.1,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	color_scheme = "Catppuccin Mocha",
	hide_tab_bar_if_only_one_tab = true,

	-- Layout
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 0,
	},

	-- Key overrides
	keys = {
		-- Passthrough keys
		{ key = "S", mods = "CTRL|SHIFT", action = wezterm.action.SendString("\x1b:w\n") },
		-- TODO: fix this ...
		{
			key = "7",
			mods = "CTRL",
			action = wezterm.action.SendString("\x1b:lua require('functions').switch_c_h()\n"),
		},
		-- { key = "7", mods = "CTRL", action = wezterm.action.SendString("\x1b[31;7~") },

		-- TMUX emulation
		{
			key = '"',
			mods = "LEADER|SHIFT",
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "%",
			mods = "LEADER|SHIFT",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
		{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	},
})