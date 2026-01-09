return {
  "lewis6991/gitsigns.nvim",
  event = { "BufEnter", "BufCreate" },
  keys = {
    { "]h",          "<cmd>Gitsigns next_hunk<cr>",        desc = "Next hunk" },
    { "[h",          "<cmd>Gitsigns prev_hunk<cr>",        desc = "Previous hunk" },
    { "ih",          "<cmd><C-U>Gitsigns select_hunk<CR>", "Select Hunk",                 mode = { "o", "x" } },

    { "<leader>vhs", "<cmd>Gitsigns stage_hunk<cr>",       desc = "Stage",                mode = { "n", "v" } },
    { "<leader>vhr", "<cmd>Gitsigns reset_hunk<cr>",       desc = "Reset",                mode = { "n", "v" } },
    { "<leader>vhp", "<cmd>Gitsigns preview_hunk<cr>",     desc = "Preview" },
    { "<leader>vhu", "<cmd>Gitsigns undo_stage_hunk<cr>",  desc = "Undo staged" },
    { "<leader>va",  "<cmd>Gitsigns stage_buffer<cr>",     desc = "Stage buffer" },
    { "<leader>vr",  "<cmd>Gitsigns reset_buffer<cr>",     desc = "Reset buffer" },
    { "<leader>vtb", "<cmd>Gitsigns blame_line<cr>",       desc = "Toggle blame line" },
    { "<leader>vtd", "<cmd>Gitsigns toggle_deleted<cr>",   desc = "Toggle deleted" },
    { "<leader>vdt", "<cmd>Gitsigns diffthis<cr>",         desc = "Diff file with index", mode = { "n", "v" } },
    { "<leader>vdd", "<cmd>Gitsigns diffthis ~<cr>",       desc = "Diff file with ~" },
    { "<leader>vdb", "",                                   desc = "Diff branch",          mode = { "n" } },
  },
  config = function()
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
    })
  end,
}
