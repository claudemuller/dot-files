local session = require("luasnip.session")

local env = session.config.snip_env
local s = env["s"]
local t = env["t"]
local i = env["i"]
local uname = os.getenv("USER") or os.getenv("USERNAME")

return {
	s("todo", {
		t("// TODO(" .. uname .. "): "),
		i(1, "Snippet Description"),
	}),
}
