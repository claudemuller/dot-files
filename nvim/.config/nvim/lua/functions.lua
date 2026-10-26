-----------------------------------------------------------------------
-- [[ Shared functions ]]
-----------------------------------------------------------------------

local M = {}

local chop_filename = function(file)
  local ext = string.match(file, ".(%w+)$")
  if ext == "" then
    local name = string.sub(file, 0, string.len(file) - string.len(ext) - 1)
    return name, ""
  end

  return file, ext
end

-- Easily switch between .c and .h files
M.switch_c_h = function(newwin)
  -- local name, ext = chop_filename(vim.fn.expand '%')
  local curFile = vim.fn.expand("%")
  local ext = string.match(curFile, ".(%w+)$")
  local name = string.sub(curFile, 0, string.len(curFile) - string.len(ext))

  local opencmd = "e"
  if newwin then
    opencmd = "vs"
  end

  if ext == "h" or ext == "hpp" then
    if vim.fn.filereadable(name .. "c") > 0 then
      vim.cmd(":" .. opencmd .. " " .. name .. "c")
    elseif vim.fn.filereadable(name .. "cpp") > 0 then
      vim.cmd(":" .. opencmd .. " " .. name .. "cpp")
    end
  end

  if ext == "c" or ext == "cpp" then
    if vim.fn.filereadable(name .. "h") > 0 then
      vim.cmd(":" .. opencmd .. " " .. name .. "h")
    elseif vim.fn.filereadable(name .. "hpp") > 0 then
      vim.cmd(":" .. opencmd .. " " .. name .. "hpp")
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
        vim.cmd(":update")
      end)
    end
  end
end

local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end
M.dump = dump

local daily_filename = function()
  local day_lookup = {}
  day_lookup["måndag"] = "Monday"
  day_lookup["tisdag"] = "Tuesday"
  day_lookup["onsdag"] = "Wednesday"
  day_lookup["torsdag"] = "Thursday"
  day_lookup["fredag"] = "Friday"
  day_lookup["lordag"] = "Saturday"
  day_lookup["sondag"] = "Sunday"

  local daily_loc = os.getenv("HOME") .. "/repos/notes/calendar/"
  local todays_date = os.date("%Y-%m-%d")
  local today = os.date("%A")

  return daily_loc .. todays_date .. " " .. day_lookup[today] .. ".md"
end

M.obsidian = {
  create_new_day = function()
    local daily_tmpl = os.getenv("HOME") .. "/repos/notes/templates/Daily_tmpl.md"
    local out_file = daily_filename()

    local src_daily = io.open(daily_tmpl, "rb")
    if not src_daily then
      print("Error: Could not open source file " .. daily_tmpl)
      return false
    end

    local dest_daily = io.open(out_file, "wb")
    if not dest_daily then
      print("Error: Could not open destination file " .. out_file)
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

    vim.api.nvim_command("edit " .. out_file)
  end,

  copy_this_day = function()
    local out_file = daily_filename()
    local this_daily = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    local file = io.open(out_file, "w")
    if not file then
      print("Error: Could not open file " .. out_file)
      return
    end

    for _, line in ipairs(this_daily) do
      file:write(line .. "\n")
    end

    file:close()

    vim.api.nvim_command("edit " .. out_file)
  end,
}

M.code_notes = {
  code_notes_ns = "code_notes",
  are_notes_showing = function()
    local ns_id = vim.api.nvim_create_namespace(M.code_notes.code_notes_ns)
    local extmarks = vim.api.nvim_buf_get_extmarks(0, ns_id, 0, -1, { details = true })
    return #extmarks > 0
  end,

  show_note = function(line, char, note)
    vim.api.nvim_buf_set_extmark(0, vim.api.nvim_create_namespace(M.code_notes.code_notes_ns), line - 1, char, {
      virt_text = { { "📓 " .. note, "Comment" } }, -- "Comment" is a highlight group for color
      virt_text_pos = "right_align", -- Options: "overlay", "eol", "right_align"
    })
  end,

  show_notes = function()
    local filename, _ = chop_filename(vim.fn.expand("%"))
    local notes = io.open(filename .. ".md", "r")
    if not notes then
      print("Error: Could not open source file " .. filename)
      return false
    end

    for text_line in notes:lines() do
      local line, char, note = text_line:match("(%S+):(%d+)%s*(.*)")
      line = string.sub(line, 2)
      note = string.match(note, "^(.*%S)%s*$")
      M.code_notes.show_note(line, tonumber(char), note)
    end
  end,

  add_note = function()
    local dap = require("dap")

    if dap.session() then
      local var = dap.repl_commands["local"]()
      vim.cmd("call setline('.', 'Variable Value: " .. var .. "')")
    end

    local cur_pos = vim.api.nvim_win_get_cursor(0) -- 0 refers to the current window
    local cur_line = cur_pos[1]                    -- Line num
    local cur_char = cur_pos[2]                    -- Char num
    local cur_loc = "L" .. cur_line .. ":" .. cur_char
    local note = vim.fn.input("Note at " .. cur_loc) .. " [" .. os.date("%Y-%m-%d %H:%M:%S") .. "]"
    local final_note = cur_loc .. " " .. note

    M.code_notes.show_note(cur_line, cur_char, note)

    if M.code_notes.are_notes_showing() then
      M.code_notes.show_notes()
    end

    local filename, _ = chop_filename(vim.fn.expand("%"))
    local out_file = filename .. ".md"
    local notes_file = io.open(out_file, "a")
    if not notes_file then
      print("Error: Could not open destination file " .. out_file)
      return false
    end

    notes_file:write(final_note .. "\n")
    notes_file:close()
  end,

  toggel_notes = function()
    if M.code_notes.are_notes_showing() then
      vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_create_namespace(M.code_notes.code_notes_ns), 0, -1)
    else
      M.code_notes.show_notes()
    end
  end,
}

-- Helper function to run any shell command in a centered floating terminal window
local function run_in_float(cmd)
  -- Create an unlisted scratch buffer for the terminal
  local buf = vim.api.nvim_create_buf(false, true)

  -- Calculate window size (80% of editor width and height)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Window configuration
  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  }

  -- Open the floating window and focus it
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Run the command using the modern non-deprecated jobstart API with term = true
  vim.fn.jobstart(cmd, {
    term = true,
    on_exit = function(_, code, _)
      -- When the process finishes: stop insert mode and jump to the bottom
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(win) then
          vim.cmd("stopinsert")
          -- Jump cursor to the last line of the buffer
          vim.api.nvim_win_call(win, function()
            vim.cmd("normal! G")
          end)
        end
      end)

      if code == 0 then
        print("Make finished successfully. (Press 'q' or Esc to close)")
      else
        print("Make failed with code: " .. code .. " (Press 'q' or Esc to close)")
      end
    end,
  })

  vim.cmd("startinsert")

  -- Map 'q' or '<Esc>' in normal mode to close the floating window safely
  local close_float = function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  vim.keymap.set("n", "q", close_float, { buffer = buf, silent = true })
  vim.keymap.set("n", "<Esc>", close_float, { buffer = buf, silent = true })
end
M.run_in_float = run_in_float

return M
