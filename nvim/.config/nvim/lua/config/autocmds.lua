-- Autocmds ---------------------------------------------------------------------------------------

local fn = require("functions")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local md_group = vim.api.nvim_create_augroup("markdown-group", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  desc = "Spell check markdown files",
  pattern = "*.md",
  group = md_group,
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en_gb"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Set wrap on for markdown files",
  pattern = "*.md",
  group = md_group,
  callback = function()
    vim.opt.wrap = true
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
    start_line = math.min(start_line, vim.api.nvim_buf_line_count(0))
    local start_col = ((col - 1) <= 0) and 1 or (col - 1)

    return start_line, start_col
  end
end

-- vim.api.nvim_create_autocmd('VimEnter', {
--   pattern = '*',
--   callback = function()
--     local start_line, start_col = parse_file_loc(vim.fn.argv())
--     print(start_line, start_col)
--     vim.api.nvim_win_set_cursor(0, {
--       start_line,
--       start_col,
--     })
--     vim.cmd.filetype('detect')
--   end,
-- })

vim.api.nvim_create_user_command('LspRestart', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  local configs = {}

  -- Save the config names of the attached clients
  for _, client in ipairs(clients) do
    if client.name and require('lspconfig')[client.name] then
      table.insert(configs, client.name)
    end
    client.stop()
  end

  -- Give some time to stop, then restart the same servers
  vim.defer_fn(function()
    for _, name in ipairs(configs) do
      require('lspconfig')[name].manager.try_add_wrapper(bufnr)
    end
  end, 100) -- 100ms delay to ensure clients are stopped
end, {})

-- TODO: move to functions.lua
local mkfloat = function()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  local bufconf = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  }

  vim.api.nvim_open_win(buf, true, bufconf)

  return buf
end

-- Show the result of a CLI cmd in a floating buffer
vim.api.nvim_create_user_command('RunCmd', function(opts)
  mkfloat()
  vim.cmd("read !" .. opts.args)
end, { nargs = "*" })

-- Get LSP info
vim.api.nvim_create_user_command("LSPInfo", function()
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    vim.notify("No active LSP clients")
    return
  end

  local lspinfo = {}

  local function add_lines(str)
    for line in str:gmatch("[^\r\n]+") do
      table.insert(lspinfo, line)
    end
  end

  for _, client in pairs(clients) do
    table.insert(lspinfo, "Name: " .. client.name)
    table.insert(lspinfo, "Root: " .. (client.config.root_dir or "N/A"))
    add_lines("Capabilities: " .. vim.inspect(client.server_capabilities))
    table.insert(lspinfo, "--------------------------------------------------")
    table.insert(lspinfo, "")
  end

  local buf = mkfloat() -- assuming mkfloat() creates a floating buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lspinfo)
end, {})
