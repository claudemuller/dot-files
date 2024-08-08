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
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]iagnostics' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>l', group = '[L]SP' },

      { '<leader>O', group = '[O]bsidian' },
      { '<leader>Od', group = '[O]bsidian [D]aily' },

      { '<leader>f', group = '[F]ile' },
      { '<leader>ft', group = '[T]oggle' },

      { '<leader>h', group = '[H]ints' },
      { '<leader>ht', group = '[T]oggle' },

      { '<leader>s', group = '[S]earch' },
      { '<leader>ss', group = '[S]ymbols' },

      { '<leader>g', group = '[G]it' },
      { '<leader>gh', group = '[H]unk' },
      { '<leader>gt', group = '[T]oggle' },
      { '<leader>gd', group = '[D]iff' },
      { '<leader>gl', group = '[L]og' },

      { '<leader>p', group = 'Swap [P]revious' },
      { '<leader>n', group = 'Swap [N]ext' },
      { '<leader>t', group = '[T]est' },
      { '<leader>D', group = '[D]ebug' },
    }
  end,
}
