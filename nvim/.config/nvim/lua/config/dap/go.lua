local M = {}

function M.setup()
  require("dap-go").setup()

  local dap = require("dap")

  dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  }

  -- dap.adapters.go = {
  --   type = 'server',
  --   host = '127.0.0.1',
  --   port = 2345, -- Match the port used in headless Delve
  -- }
  --
  -- dap.configurations.go = {
  --   {
  --     type = 'go',
  --     name = 'Attach to Headless Delve',
  --     request = 'attach',
  --     mode = 'remote',
  --     remotePath = '', -- Set if debugging remote code
  --     port = 2345,
  --     host = '127.0.0.1',
  --     substitutePath = {}, -- optional path remapping
  --   },
  -- }
end

return M
