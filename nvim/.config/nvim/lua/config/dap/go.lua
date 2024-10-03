local M = {}

function M.setup()
  require('dap-go').setup()
  local dap = require 'dap'

  vim.api.nvim_create_autocmd('DirChanged', {
    pattern = '*',
    callback = function()
      local project_nvim_lua = vim.fn.getcwd() .. '/.nvim.lua'
      if vim.fn.filereadable(project_nvim_lua) == 1 then
        dofile(project_nvim_lua)
      end
      -- Or load .vscode/launch.json
      require('dap.ext.vscode').load_launchjs()
    end,
  })

  dap.adapters.go = {
    -- type = 'executable',
    -- command = os.getenv 'GOBIN' .. '/dlv',
    -- args = {},
    type = 'server',
    port = '${port}',
    executable = {
      command = 'dlv',
      args = { 'dap', '-l', '127.0.0.1:${port}' },
    },
  }
end

return M
