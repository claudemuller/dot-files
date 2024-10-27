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

    { '<leader>ghs', '<cmd>Gitsigns stage_hunk<cr>', desc = '[G]it [H]unk [S]tage', mode = { 'n', 'v' } },
    { '<leader>ghr', '<cmd>Gitsigns reset_hunk<cr>', desc = '[G]it [H]unk [R]eset', mode = { 'n', 'v' } },
    { '<leader>ghp', '<cmd>Gitsigns preview_hunk<cr>', desc = '[G]it [H]unk [P]review' },
    { '<leader>ghu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = '[G]it [H]unk [U]ndo Staged' },
    { '<leader>ga', '<cmd>Gitsigns stage_buffer<cr>', desc = '[G]it Stage Buffer' },
    { '<leader>gr', '<cmd>Gitsigns reset_buffer<cr>', desc = '[G]it [R]eset Buffer' },
    { '<leader>gtb', '<cmd>Gitsigns blame_line<cr>', desc = '[G]it [T]oggle [B]lame Line' },
    { '<leader>gtd', '<cmd>Gitsigns toggle_deleted<cr>', desc = '[G]it [T]oggle [D]eleted' },
    { '<leader>gdt', '<cmd>Gitsigns diffthis<cr>', desc = '[G]it [D]iff File with Index', mode = { 'n', 'v' } },
    { '<leader>gdd', '<cmd>Gitsigns diffthis ~<cr>', desc = '[G]it [D]iff File with ~' },
    { '<leader>gdb', '', desc = '[G]it [D]iff [B]ranch', mode = { 'n' } },
  },
  config = function()
    require('gitsigns').setup {
      -- █▓▒░▀▄
      signs = {
        add = { text = '█' },
        change = { text = '▓' },
        delete = { text = '▒' },
        topdelete = { text = '▀' },
        changedelete = { text = '░' },
        untracked = { text = '▄' },
      },
      signs_staged = {
        add = { text = '█' },
        change = { text = '▓' },
        delete = { text = '▒' },
        topdelete = { text = '▀' },
        changedelete = { text = '░' },
        untracked = { text = '▄' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = false,
      },
    }
  end,
}
