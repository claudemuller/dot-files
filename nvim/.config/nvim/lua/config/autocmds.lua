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

local parse_fn_str = function(arg)
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

-- nvim foo.lua:10     # open foo.lua and go to line 10
-- nvim foo.lua(10)    # open foo.lua and go to line 10
-- nvim foo.lua:12:5   # open foo.lua and go to line 12, column 5
-- nvim foo.lua(12:5)

local parse_fllenames = function(fns)
  for i, fn in ipairs(fns) do
    print(vim.inspect(fn))

    local file, line, col = parse_fn_str(fn)

    if not file then return end

    -- TODO: check that line and col are valid

    -- TODO: if more than one file, open other files in tabs
    vim.cmd.edit(vim.fn.fnameescape(file))

    if line then
      vim.api.nvim_win_set_cursor(0, {
        (line or 1),
        ((col - 1) or 1),
      })
    end
  end
end

-- vim.api.nvim_create_autocmd('VimEnter', {
--   pattern = '*',
--   callback = function() parse_fllenames(vim.fn.argv()) end,
-- })
