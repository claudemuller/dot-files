-----------------------------------------------------------------------
-- [[ gitsigns config ]]
-----------------------------------------------------------------------

-- Gitsigns
-- See `:help gitsigns.txt`
return { -- Gutter Git signs
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "✚" },
			change = { text = "" },
			delete = { text = "✖" },
			topdelete = { text = "✖" },
			changedelete = { text = "" },
		},
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			delay = 100,
			ignore_whitespace = false,
		},
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

			-- stylua: ignore start
			map("n", "]h", gs.next_hunk, "Next Hunk")
			map("n", "[h", gs.prev_hunk, "Prev Hunk")
			map({ "n", "v" }, "<leader>Ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
			map({ "n", "v" }, "<leader>Ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
			map("n", "<leader>Ghp", gs.preview_hunk, "Preview Hunk")
			map("n", "<leader>Gs", gs.stage_buffer, "Stage Buffer")
			map("n", "<leader>Gu", gs.undo_stage_hunk, "Undo Stage Hunk")
			map("n", "<leader>Gr", gs.reset_buffer, "Reset Buffer")
			map("n", "<leader>Gb", function() gs.blame_line({ full = true }) end, "Blame Line")
			map({ "n", "v" }, "<leader>Gd", gs.diffthis, "Diff This")
			map("n", "<leader>GD", function() gs.diffthis("~") end, "Diff This ~")
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
		end
	},
}
