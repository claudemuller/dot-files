-----------------------------------------------------------------------
-- [[ General config ]]
-----------------------------------------------------------------------

return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },
    keys = {
      { '<leader>gs', ':Git<cr>', desc = '[G]it [S]tatus', mode = { 'n' } },
      { '<leader>gc', ':Git commit<cr>', desc = '[G]it [C]ommit', mode = { 'n' } },
      { '<leader>gp', ':Git pull<cr>', desc = '[G]it [P]ull', mode = { 'n' } },
      { '<leader>gP', ':Git push<cr>', desc = '[G]it [P]ush', mode = { 'n' } },
      { '<leader>gll', ':Gllog<cr>', desc = '[G]it [L]og', mode = { 'n' } },
      { '<leader>gr', ':Gvdiffsplit!<cr>', desc = '[G]it [R]esolve conflict', mode = { 'n' } },
      { '<leader>gP', ':Git push<cr>', desc = '[G]it [P]ush', mode = { 'n' } },
    },
  },

  -- `opts = {}` is equivalent to:
  --    require('Comment').setup({})
  { 'numToStr/Comment.nvim', opts = {} },

  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>fd', ':DiffviewOpen HEAD~2<CR>', desc = 'Diffview with last commit', mode = { 'n', 'v' } },
      { '<leader>fu', ':DiffviewOpen<CR>', desc = 'Diffview with unstaged files', mode = { 'n', 'v' } },
    },
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}
  },

  {
    'vhyrro/luarocks.nvim',
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { 'magick' },
    },
  },
  {
    '3rd/image.nvim',
    dependencies = { 'luarocks.nvim' },
    config = function()
      require('image').setup {
        backend = 'kitty',
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { 'norg' },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' }, -- render image files as images when opened
      }
    end,
  },

  {
    'leoluz/nvim-dap-go',
    keys = {
      { '<leader>Dn', '::lua require("dap-go").debug_test()<cr>', desc = '[D]ebug [N]earest Test', mode = { 'n' } },
      { '<leader>Dl', '::lua require("dap-go").debug_last_test()<cr>', desc = '[D]ebug [L]ast Test', mode = { 'n' } },
    },
  },
}
