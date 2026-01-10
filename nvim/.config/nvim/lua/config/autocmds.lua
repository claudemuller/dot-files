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

local parse_file_str = function(arg)
  local file, line, col

  -- foo.lua:12:5
  file, line, col = arg:match('^(.-):(%d+):(%d+)$')
  if file then return file, tonumber(line), tonumber(col) end

  -- foo.lua:10
  file, line = arg:match('^(.-):(%d+)$')
  if file then return file, tonumber(line), 0 end

  -- foo.lua(12:5)
  file, line, col = arg:match('^(.-)%((%d+):(%d+)%)$')
  if file then return file, tonumber(line), tonumber(col) end

  -- foo.lua(10)
  file, line = arg:match('^(.-)%((%d+)%)$')
  if file then return file, tonumber(line), 0 end

  -- plain filename
  return arg, 0, 0
end

local parse_file_loc = function(filenames)
  for _, filename in ipairs(filenames) do
    local file, line, col = parse_file_str(filename)
    if not file then return end

    -- TODO: if more than one file, open other files in tabs
    vim.cmd.edit(vim.fn.fnameescape(file))

    local start_line = (line <= 0) and 1 or line
    start_line = math.min(line, vim.api.nvim_buf_line_count(0))
    local start_col = ((col - 1) <= 0) and 1 or (col - 1)

    return start_line, start_col
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    local start_line, start_col = parse_file_loc(vim.fn.argv())
    vim.api.nvim_win_set_cursor(0, {
      start_line,
      start_col,
    })
    vim.cmd.filetype('detect')
  end,
})
