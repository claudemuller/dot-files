-----------------------------------------------------------------------
-- [[ Shared functions ]]
-----------------------------------------------------------------------

local M = {}

-- Easily switch between .c and .h files
M.switch_c_h = function()
  local curFile = vim.fn.expand '%'
  local ext = string.match(curFile, '.(%w+)$')
  local name = string.sub(curFile, 0, string.len(curFile) - string.len(ext))

  if ext == 'h' or ext == 'hpp' then
    if vim.fn.filereadable(name .. 'c') > 0 then
      vim.cmd(':e ' .. name .. 'c')
    elseif vim.fn.filereadable(name .. 'cpp') > 0 then
      vim.cmd(':e ' .. name .. 'cpp')
    end
  end

  if ext == 'c' or ext == 'cpp' then
    if vim.fn.filereadable(name .. 'h') > 0 then
      vim.cmd(':e ' .. name .. 'h')
    elseif vim.fn.filereadable(name .. 'hpp') > 0 then
      vim.cmd(':e ' .. name .. 'hpp')
    end
  end
end

M.save_all_buffers = function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    -- Check if buffer is valid and is not a terminal buffer
    -- if vim.api.nvim_buf_is_valid(buf) and not vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if vim.fn.filereadable(bufname) == 1 then
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd ':update'
      end)
    end
  end
end

M.dump = function(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

local daily_filename = function()
  local day_lookup = {}
  day_lookup['måndag'] = 'Monday'
  day_lookup['tisdag'] = 'Tuesday'
  day_lookup['onsdag'] = 'Wednesday'
  day_lookup['torsdag'] = 'Thursday'
  day_lookup['fredag'] = 'Friday'
  day_lookup['lordag'] = 'Saturday'
  day_lookup['sondag'] = 'Sunday'

  local daily_loc = os.getenv 'HOME' .. '/repos/notes/calendar/'
  local todays_date = os.date '%Y-%m-%d'
  local today = os.date '%A'

  return daily_loc .. todays_date .. ' ' .. day_lookup[today] .. '.md'
end

M.obsidian = {
  create_new_day = function()
    local daily_tmpl = os.getenv 'HOME' .. '/repos/notes/templates/Daily_tmpl.md'
    local out_file = daily_filename()

    local src_daily = io.open(daily_tmpl, 'rb')
    if not src_daily then
      print('Error: Could not open source file ' .. daily_tmpl)
      return false
    end

    local dest_daily = io.open(out_file, 'wb')
    if not dest_daily then
      print('Error: Could not open destination file ' .. out_file)
      src_daily:close()
      return false
    end

    local chunk_size = 8192
    while true do
      local bytes = src_daily:read(chunk_size)
      if not bytes then
        break
      end
      dest_daily:write(bytes)
    end

    src_daily:close()
    dest_daily:close()

    vim.api.nvim_command('edit ' .. out_file)
  end,

  copy_this_day = function()
    local out_file = daily_filename()
    local this_daily = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    local file = io.open(out_file, 'w')
    if not file then
      print('Error: Could not open file ' .. out_file)
      return
    end

    for _, line in ipairs(this_daily) do
      file:write(line .. '\n')
    end

    file:close()

    vim.api.nvim_command('edit ' .. out_file)
  end,
}

return M
