local M = {}

function M.setup()
  local dap = require("dap")

  dap.adapters.codelldb = function(cb, config)
    if config.preLaunchTaskDap then
      local output = vim.fn.system(config.preLaunchTaskDap)

      if vim.v.shell_error ~= 0 then
        vim.notify(output, "error", {
          title = "Task Failed",
          -- timeout = 3000,
        })
      else
        vim.notify(output, "info", {
          title = "Task Success",
        })
      end
    end

    local adapter = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }
    cb(adapter)
  end
end

return M
