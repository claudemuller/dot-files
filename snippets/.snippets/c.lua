-- DOCS:
-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#snippets
--
-- GLOBAL VARS:
-- https://github.com/L3MON4D3/LuaSnip/blob/69cb81cf7490666890545fef905d31a414edc15b/lua/luasnip/config.lua#L82-L104§

local session = require("luasnip.session")

local env = session.config.snip_env
local s = env["s"]
local t = env["t"]
local i = env["i"]
local parse = env["parse"]
local rep = require("luasnip.extras").rep

return {
	s({ trig = "ifn", name = "Header Guard", dscr = "Insert a C header guard Pattern" }, {
		t("#ifndef "),
		i(1, "HEADER_H_"),
		t({ "", "#define " }),
		rep(1),
		t({ "", "", "" }),
		i(0),
		t({ "", "", "#endif // " }),
		rep(1),
	}),

	parse(
		{ trig = "clang", name = "Clang Format off", dscr = "Insert a clang-format off block" },
		[[
    // clang-format off
    $0
    // clang-format on
	 ]]
	),
}
