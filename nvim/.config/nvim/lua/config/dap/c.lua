local M = {}

function M.setup()
  require('dap-go').setup()
  local dap = require 'dap'

  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = 'codelldb',
      args = { '--port', '${port}' },
    },
  }
end

return M
