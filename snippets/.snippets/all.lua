local session = require("luasnip.session")

local env = session.config.snip_env
local s = env["s"]
local t = env["t"]
local i = env["i"]
local uname = os.getenv("USER") or os.getenv("USERNAME")

return {
	s("todo", {
		t("// TODO:(" .. uname .. ") "),
		i(1, "the todo description"),
	}),
	s("bug", {
		t("// BUG:(" .. uname .. ") "),
		i(1, "the bug description"),
	}),
	s("note", {
		t("// NOTE:(" .. uname .. ") "),
		i(1, "the note description"),
	}),
	s("perf", {
		t("// PERF:(" .. uname .. ") "),
		i(1, "the perf description"),
	}),
	s("hack", {
		t("// HACK:(" .. uname .. ") "),
		i(1, "the hack description"),
	}),
	s("warning", {
		t("// WARNING:(" .. uname .. ") "),
		i(1, "the warning description"),
	}),
	s("fix", {
		t("// FIX:(" .. uname .. ") "),
		i(1, "the note description"),
	}),
}
