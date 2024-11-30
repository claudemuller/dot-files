local M = {}

function M.setup()
  require('dap-go').setup()

  local dap = require 'dap'

  dap.adapters.go = {
    type = 'server',
    port = '${port}',
    executable = {
      command = 'dlv',
      args = { 'dap', '-l', '127.0.0.1:${port}' },
    },
  }
end

return M
