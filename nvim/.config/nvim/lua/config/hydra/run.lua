local Hydra = require("hydra")
-- local dap = require("dap")

local hint = [[
 _r_: run
 ^
 ^ ^              _q_: exit
]]

local run_hydra = Hydra({
  hint = hint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      position = "bottom",
      border = "rounded",
    },
  },
  name = "run",
  mode = { "n", "x" },
  body = "<leader>x",
  heads = {
    { "r", "<cmd>make<cr>", { silent = true } },
    { "q", nil, { exit = true, nowait = true } },
  },
})

Hydra.spawn = function(head)
  if head == "run-hydra" then
    run_hydra:activate()
  end
end
