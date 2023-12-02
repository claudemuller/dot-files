-----------------------------------------------------------------------
-- [[ Keymaps ]]
-----------------------------------------------------------------------

local M = {}

local funcs = require("functions")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<S-u>", ":redo", { silent = true })

-- Move line up or down
vim.keymap.set({ "v", "n" }, "<C-j>", "<cmd>:m +1<cr>", { silent = true })
vim.keymap.set({ "v", "n" }, "<C-k>", "<cmd>:m -1<cr>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- File operations
vim.keymap.set("n", "<M-s>", "<cmd>:wa<cr>", { desc = "[Ctrl][Meta][S]ave Current File" })

-- Window management
vim.keymap.set("n", "<leader>+", "<cmd>:vertical resize +10<cr>", { desc = "Increase Split" })
vim.keymap.set("n", "<leader>-", "<cmd>:vertical resize -10<cr>", { desc = "Decrease Split" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- C/C++
vim.keymap.set("n", "<leader>gc", funcs.switch_c_h, { desc = "[G]o to C/Cpp or H file" })

return M
