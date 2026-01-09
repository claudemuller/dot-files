-- Autocmds ---------------------------------------------------------------------------------------

local fn = require("functions")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Spell check markdown files",
  pattern = "*.md",
  group = vim.api.nvim_create_augroup("markdown-group", { clear = true }),
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en_gb"
  end,
})

vim.api.nvim_create_autocmd("FocusLost", {
  desc = "Auto save all buffers when Vim loses focus",
  group = vim.api.nvim_create_augroup("saving-group", { clear = true }),
  callback = fn.save_all_buffers,
})

vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), "info", {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and " " or
            spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
