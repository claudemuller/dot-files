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

  -- Map 'q' or '<Esc>' in normal mode to close the floating window safely
  local close_float = function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  vim.keymap.set("n", "q", close_float, { buffer = buf, silent = true })
  vim.keymap.set("n", "<Esc>", close_float, { buffer = buf, silent = true })
end

local function run_make_run()
  run_in_float("make run")
end

function _G.select_make_target()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local function get_make_targets()
    local targets = {}
    local makefile = io.popen("make -qp | awk -F: '/^[a-zA-Z0-9][^$#\\/\\t=]*:([^=]|$)/ {print $1}' | sort | uniq")
    if makefile then
      for line in makefile:lines() do
        table.insert(targets, line)
      end
      makefile:close()
    end
    return targets
  end

  local targets = get_make_targets()
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Make Targets",
      finder = require("telescope.finders").new_table({
        results = targets,
      }),
      sorter = require("telescope.config").values.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            run_in_float("make " .. selection.value)
          end
        end)
        return true
      end,
    })
    :find()
end

vim.keymap.set("n", "<leader>r", run_make_run, { noremap = true, silent = true, desc = "Make Run in Floating Window" })
vim.keymap.set(
  "n",
  "<leader>R",
  select_make_target,
  { noremap = true, silent = true, desc = "Select Make Target Picker" }
)
