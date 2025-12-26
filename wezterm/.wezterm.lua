local wezterm = require("wezterm")
local act = wezterm.action

local noir = dofile(wezterm.config_dir .. "/.config/wezterm/noir.lua")

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
	-- Bare
	bare = {
		set_environment_variables = {},
		font = wezterm.font("JetBrainsMono Nerd Font"),
	},
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
		set_environment_variables = {},
		font = wezterm.font("JetBrainsMono NF"),

		-- TMUX leader
		leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
		keys = {
			{ key = "7", mods = "CTRL", action = wezterm.action.SendString("\x1b[31;7~") },
			{ key = "6", mods = "CTRL", action = wezterm.action.SendString("\x1b[31;6~") },
			{ key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },

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
		mouse_bindings = {
			{
				event = { Down = { streak = 3, button = "Left" } },
				action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
				mods = "NONE",
			},
			{
				event = { Down = { streak = 1, button = "Right" } },
				mods = "NONE",
				action = wezterm.action_callback(function(window, pane)
					local has_selection = window:get_selection_text_for_pane(pane) ~= ""
					if has_selection then
						window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
						window:perform_action(act.ClearSelection, pane)
					else
						window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
					end
				end),
			},
		},
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
	ubuntu = {
		default_prog = {
			"wsl.exe",
			"-u",
			"claude",
			"-d",
			"Ubuntu-24.04",
		},
		set_environment_variables = {},
		font = wezterm.font("JetBrainsMono Nerd Font"),
	},
}

local default_profile = function()
	local is_windows = package.config:sub(1, 1) == "\\"
	if is_windows then
		return "vsdev"
	end
	return "tmux"
end
local profile_name = os.getenv("WEZTERM_PROFILE") or default_profile()
local profile = profiles[profile_name]

if profile_name == "vsdev" then
	local handle = io.popen("hostname")
	local machine_name = handle:read("*a")
	handle:close()
	machine_name = machine_name:gsub("%s+", "")

	if machine_name == "es-cmuller2" then
		profile = mergeTables(profile, {
			default_prog = {
				"cmd.exe",
				"/k",
				"C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\VC\\Auxiliary\\Build\\vcvarsall.bat",
				"x64",
			},
		})
	else
		profile = mergeTables(profile, {
			default_prog = {
				"cmd.exe",
				"/k",
				-- "C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Auxiliary\\Build\\vcvarsall.bat",
				"C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\VC\\Auxiliary\\Build\\vcvarsall.bat",
				"x64",
			},
		})
	end
end

return mergeTables(profile, {
	-- Appearance
	font_size = 9,
	line_height = 1.1,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	-- color_scheme = noir.color_scheme,
	colors = noir.colors,
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
		-- {
		-- 	key = "7",
		-- 	mods = "CTRL",
		-- 	action = wezterm.action.SendString("\x1b:lua require('functions').switch_c_h()\n"),
		-- },
	},
})
