-----------------------------------------------------------------------
-- [[ Which Key config ]]
-----------------------------------------------------------------------

-- Which Key
-- See `:help which-key.nvim`
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function() -- This is the function that runs, AFTER loading
    local wk = require 'which-key'

    wk.add {
      { '<leader>d', group = 'Diagnostics' },
      { '<leader>N', group = 'Code notes' },

      { '<leader>c', group = 'Code' },
      { '<leader>cg', group = 'Generate' },
      { '<leader>cr', group = 'Remove' },
      { '<leader>cf', group = 'Fill' },

      { '<leader>l', group = 'LSP' },
      { '<leader>t', group = 'Test' },
      { '<leader>D', group = 'Debug' },

      { '<leader>s', group = 'Search' },
      { '<leader>ss', group = 'Symbols' },

      { '<leader>r', group = 'Rename' },

      { '<leader>O', group = 'Obsidian' },
      { '<leader>Od', group = 'Daily' },

      { '<leader>f', group = 'File' },
      { '<leader>ft', group = 'Toggle' },

      { '<leader>h', group = 'Hints' },
      { '<leader>ht', group = 'Toggle' },

      { '<leader>g', group = 'Git' },
      { '<leader>gh', group = 'Hunk' },
      { '<leader>gt', group = 'Toggle' },
      { '<leader>gd', group = 'Diff' },
      { '<leader>gl', group = 'Log' },

      { '<leader>p', group = 'Swap previous' },
      { '<leader>n', group = 'Swap next' },
    }
  end,
}
