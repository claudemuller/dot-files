local fn = require("functions")

vim.api.nvim_create_user_command("Run", function(opts)
  if opts.args == "" then
    print("Error: No command provided")
    return
  end

  fn.run_in_float(opts.args)
end, {
  nargs = "+", -- Requires one or more arguments
  complete = "shellcmd", -- Optional: tab-completion for shell commands
})
