-----------------------------------------------------------------------
-- [[ Which Key config ]]
-----------------------------------------------------------------------

-- Which Key
-- See `:help which-key.nvim`
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]iagnostics', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },

      ['<leader>O'] = { name = '[O]bsidian', _ = 'which_key_ignore' },
      ['<leader>Od'] = { name = '[O]bsidian [D]aily', _ = 'which_key_ignore' },

      ['<leader>f'] = { name = '[F]ile', _ = 'which_key_ignore' },
      ['<leader>ft'] = { name = '[T]oggle', _ = 'which_key_ignore' },

      ['<leader>h'] = { name = '[H]ints', _ = 'which_key_ignore' },
      ['<leader>ht'] = { name = '[T]oggle', _ = 'which_key_ignore' },

      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>ss'] = { name = '[S]ymbols', _ = 'which_key_ignore' },

      ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      ['<leader>gh'] = { name = '[H]unk', _ = 'which_key_ignore' },
      ['<leader>gt'] = { name = '[T]oggle', _ = 'which_key_ignore' },
      ['<leader>gd'] = { name = '[D]iff', _ = 'which_key_ignore' },
      ['<leader>gl'] = { name = '[L]og', _ = 'which_key_ignore' },

      ['<leader>p'] = { name = 'Swap [P]revious', _ = 'which_key_ignore' },
      ['<leader>n'] = { name = 'Swap [N]ext', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
      ['<leader>D'] = { name = '[D]ebug', _ = 'which_key_ignore' },
    }
  end,
}
