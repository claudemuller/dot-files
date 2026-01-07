-----------------------------------------------------------------------
-- [[ Gitsigns config ]]
-----------------------------------------------------------------------

local gh = require("functions").gh

vim.pack.add({ gh("lewis6991/gitsigns.nvim") })

--   event = { 'BufEnter', 'BufCreate' },

require("gitsigns").setup({
	-- █▓▒░▀▄
	signs = {
		add = { text = "█" },
		change = { text = "▓" },
		delete = { text = "▒" },
		topdelete = { text = "▀" },
		changedelete = { text = "░" },
		untracked = { text = "▄" },
	},
	signs_staged = {
		add = { text = "█" },
		change = { text = "▓" },
		delete = { text = "▒" },
		topdelete = { text = "▀" },
		changedelete = { text = "░" },
		untracked = { text = "▄" },
	},
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 100,
		ignore_whitespace = false,
	},
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		-- Actions
		map("n", "<leader>hs", gitsigns.stage_hunk)
		map("n", "<leader>hr", gitsigns.reset_hunk)

		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		map("n", "<leader>hS", gitsigns.stage_buffer)
		map("n", "<leader>hR", gitsigns.reset_buffer)
		map("n", "<leader>hp", gitsigns.preview_hunk)
		map("n", "<leader>hi", gitsigns.preview_hunk_inline)

		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end)

		map("n", "<leader>hd", gitsigns.diffthis)

		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end)

		map("n", "<leader>hQ", function()
			gitsigns.setqflist("all")
		end)
		map("n", "<leader>hq", gitsigns.setqflist)

		-- Toggles
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
		map("n", "<leader>tw", gitsigns.toggle_word_diff)

		-- Text object
		map({ "o", "x" }, "ih", gitsigns.select_hunk)
	end,
})

-- keymaps

-- vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
-- vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous hunk" })
-- vim.keymap.set({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
-- vim.keymap.set({ "n", "v" }, "<leader>vhs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage" })
-- vim.keymap.set({ "n", "v" }, "<leader>vhr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset" })
-- vim.keymap.set("n", "<leader>vhp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview" })
-- vim.keymap.set("n", "<leader>vhu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo staged" })
-- vim.keymap.set("n", "<leader>va", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage buffer" })
-- vim.keymap.set("n", "<leader>vr", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset buffer" })
-- vim.keymap.set("n", "<leader>vtb", "<cmd>Gitsigns blame_line<cr>", { desc = "Toggle blame line" })
-- vim.keymap.set("n", "<leader>vtd", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Toggle deleted" })
-- vim.keymap.set({ "n", "v" }, "<leader>vdt", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff file with index" })
-- vim.keymap.set("n", "<leader>vdd", "<cmd>Gitsigns diffthis ~<cr>", { desc = "Diff file with ~" })
-- vim.keymap.set("n", "<leader>vdb", "", { desc = "Diff branch" })
