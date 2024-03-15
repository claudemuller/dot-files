-----------------------------------------------------------------------
-- [[ Gitsigns config ]]
-----------------------------------------------------------------------

-- Gutter Git signs
-- See `:help gitsigns`
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufEnter', 'BufCreate' },
  keys = {
    { ']h', '<cmd>Gitsigns next_hunk<cr>', desc = 'Next hunk' },
    { '[h', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Previous hunk' },
    { 'ih', '<cmd><C-U>Gitsigns select_hunk<CR>', 'Select Hunk', mode = { 'o', 'x' } },

    { '<leader>Ghs', '<cmd>Gitsigns stage_hunk<cr>', desc = 'Stage Hunk', mode = { 'n', 'v' } },
    { '<leader>Ghr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset Hunk', mode = { 'n', 'v' } },
    { '<leader>Ghp', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Preview hunk' },
    { '<leader>Gs', '<cmd>Gitsigns stage_buffer<cr>', desc = 'Stage Buffer' },
    { '<leader>Gu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = 'Undo Stage Hunk' },
    { '<leader>Gu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = 'Undo Stage Hunk' },
    { '<leader>Gb', '<cmd>Gitsigns blame_line<cr>', desc = 'Blame Line' },
    { '<leader>Gd', '<cmd>Gitsigns diffthis<cr>', desc = 'Diff This', mode = { 'n', 'v' } },
    { '<leader>GD', '<cmd>Gitsigns diffthis ~<cr>', desc = 'Diff This ~' },
  },
  config = {
    signs = {
      add = { text = '✚' },
      change = { text = '' },
      delete = { text = '✖' },
      test = 'test',
      topdelete = { text = '✖' },
      changedelete = { text = '' },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 100,
      ignore_whitespace = false,
    },
  },
}
