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

return M
