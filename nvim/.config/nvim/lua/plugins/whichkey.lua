-----------------------------------------------------------------------
-- [[ Which Key config ]]
-----------------------------------------------------------------------

-- Which Key
-- See `:help which-key.nvim`
return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>O'] = { name = '[O]bsidian', _ = 'which_key_ignore' },
      ['<leader>G'] = { name = '[G]it', _ = 'which_key_ignore' },
      ['<leader>Gh'] = { name = '[G]it [h]', _ = 'which_key_ignore' },
      ['<leader>T'] = { name = '[T]est', _ = 'which_key_ignore' },
      ['<leader>D'] = { name = '[D]ebug', _ = 'which_key_ignore' },
    }
  end,
}
