-- Keymaps ----------------------------------------------------------------------------------------

local fn = require("functions")

vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { desc = "Show Lazy" })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Redo
vim.keymap.set("n", "<S-u>", ":redo<CR>", { silent = true })

-- File operations
vim.keymap.set("n", "<C-S-s>", "<cmd>:w<CR>", { noremap = true, desc = "Save current buffer" })
-- check here - https://vi.stackexchange.com/questions/38848/how-can-i-map-ctrl-alt-letter-mappings-in-vim
vim.keymap.set("n", "<C-S-A-s>", fn.save_all_buffers, { noremap = true, desc = "Save all open buffers" })

-- Switch between .c and .h files
vim.keymap.set("n", "<C-7>", fn.switch_c_h, { noremap = true, desc = "Switch between .c/.c++ and .h files" })
vim.keymap.set("n", "gH", fn.switch_c_h, { noremap = true, desc = "Switch between .c/.c++ and .h files" })

-- Window keybinds
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-W><C-l>", "<cmd>:vertical resize +10<cr>", { desc = "Increase pane split" })
vim.keymap.set("n", "<C-W><C-h>", "<cmd>:vertical resize -10<cr>", { desc = "Decrease pane split" })
-- vim.keymap.set("n", "q", ":q<cr>", { desc = "Close current window" })
-- vim.keymap.set("n", "Qf", ":cclose<cr>", { desc = "Close quickfix" })

vim.keymap.set("n", "<C-S-j>", ":m +1<cr>", { desc = "Move line down" })
vim.keymap.set("v", "<C-S-j>", ":m '>+1<cr>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("n", "<C-S-k>", ":m -2<cr>", { desc = "Move line up" })
vim.keymap.set("v", "<C-S-k>", ":m '<-2<cr>gv=gv", { desc = "Move selected lines up" })

-- Diagnostics
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic message" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic message" })
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic errors" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Show diagnostic quickfix list" })
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostics in floating" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- L
-- Naughty naughty
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Obsidian
-- vim.keymap.set("n", "<leader>Odn", fn.obsidian.create_new_day, { desc = "New daily note" })
-- vim.keymap.set("n", "<leader>Odc", fn.obsidian.copy_this_day, { desc = "Copy current note" })

-- Octo
-- vim.keymap.set("n", "<leader>go", ":Octo actions<cr>", { desc = "Open Octo" })

-- Copy full file path to clipboard
vim.keymap.set("n", "<leader>Fc", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied path: " .. path)
end, { desc = "Copy full file path to clipboard" })

-- Quickfix ---------------------------------------------------------------------------------------
vim.keymap.set("n", "<M-q>", function()
  local function is_quickfix_open()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].buftype == "quickfix" then
        return true
      end
    end
    return false
  end

  if is_quickfix_open() then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end, { desc = "Toggle quickfix" })
vim.keymap.set("n", "<M-n>", "<cmd>:cnext<CR>", { desc = "Next quickfix entry" })
vim.keymap.set("n", "<M-p>", "<cmd>:cprev<CR>", { desc = "Previous quickfix entry" })

-- Debugging/Dev ----------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>x", "<cmd>source %<CR>", { desc = "Source current buffer" })
vim.keymap.set("n", "<leader>X", ":.lua<CR>", { desc = "Source current line" })
vim.keymap.set("v", "<leader>X", ":lua<CR>", { desc = "Source current line" })



function RunCmdOnSelection()
  -- Get visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  -- If selection is single-line, trim to selected columns
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    lines[1] = string.sub(lines[1], start_pos[3])
  end

  -- Join lines to a single command
  local cmd = table.concat(lines, "\n")

  -- Run shell command
  local output = vim.fn.system(cmd)

  -- Replace selection with output
  vim.fn.setline(start_pos[2], vim.split(output, "\n"))

  -- If multi-line, delete extra lines
  if end_pos[2] > start_pos[2] then
    vim.api.nvim_buf_set_lines(0, start_pos[2], end_pos[2], false, {})
  end
end

vim.api.nvim_set_keymap('v', '<leader>R', ':lua RunCmdOnSelection()<CR>',
  { desc = "Run command in selection", noremap = true, silent = true })
