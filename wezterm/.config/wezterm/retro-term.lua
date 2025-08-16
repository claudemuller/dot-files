local wezterm = require("wezterm")

local palettes = {
	base = {
		foreground = "#c09048", -- base05
		background = "#120f09", -- base00
		cursor_bg = "#c09048",
		cursor_fg = "#120f09",
		cursor_border = "#c09048",
		selection_bg = "#2a2018",
		selection_fg = "#c09048",
		split = "#5a4632",
		ansi = { "#120f09", "#ffb000", "#c09048", "#e0b060", "#d8a860", "#e0b060", "#a67840", "#c09048" },
		brights = { "#ffd060", "#ffb000", "#c09048", "#e0b060", "#d8a860", "#e0b060", "#a67840", "#c09048" },
	},
	muted = {
		foreground = "#c0a179", -- base05
		background = "#120f09", -- base00
		cursor_bg = "#c0a179",
		cursor_fg = "#120f09",
		cursor_border = "#c0a179",
		selection_bg = "#35291d",
		selection_fg = "#c0a179",
		split = "#66553f",
		ansi = { "#120f09", "#887254", "#927a60", "#c0a179", "#d6b891", "#a28662", "#a28662", "#c0a179" },
		brights = { "#292016", "#887254", "#927a60", "#c0a179", "#d6b891", "#a28662", "#a28662", "#c0a179" },
	},
	original = {
		foreground = "#ffb000", -- base05
		background = "#000000", -- base00
		cursor_bg = "#ffb000",
		cursor_fg = "#000000",
		cursor_border = "#ffb000",
		selection_bg = "#332000",
		selection_fg = "#ffb000",
		split = "#664400",
		ansi = { "#000000", "#ffb000", "#ffb000", "#ffb000", "#ffb000", "#ffb000", "#ffb000", "#ffb000" },
		brights = { "#ffd060", "#ffb000", "#ffb000", "#ffb000", "#ffb000", "#ffb000", "#ffb000", "#ffb000" },
	},
}

-- Palettes: "base", "muted", or "original"
return function(palette)
	return palettes[palette or "base"]
end
