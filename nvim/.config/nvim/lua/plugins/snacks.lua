return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = { enabled = false },
    scratch = {
      win_by_ft = {
        lua = {
          keys = {
            ['source'] = {
              '<cr>',
              function(self)
                local name = 'scratch.' .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ':e')
                Snacks.debug.run { buf = self.buf, name = name }
              end,
              desc = 'Source buffer',
              mode = { 'n', 'x' },
            },
          },
        },
        go = {
          keys = {
            ['source'] = {
              '<cr>',
              function(self)
                local name = 'scratch.' .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ':e')
                Snacks.debug.run { buf = self.buf, name = name }
              end,
              desc = 'Source buffer',
              mode = { 'n', 'x' },
            },
          },
        },
      },
    },
    notifier = {
      timeout = 3000, -- default timeout in ms
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- editor margin to keep free. tabline and statusline are taken into account automatically
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true, -- add 1 cell of left/right padding to the notification window
      sort = { 'level', 'added' },
      level = vim.log.levels.TRACE,
      icons = {
        error = ' ',
        warn = ' ',
        info = ' ',
        debug = ' ',
        trace = ' ',
      },
      keep = function(notif)
        return vim.fn.getcmdpos() > 0
      end,
      ---@type snacks.notifier.style
      style = 'compact',
      top_down = true, -- place notifications from top to bottom
      date_format = '%R', -- time format for notifications
      -- format for footer when more lines are available
      -- `%d` is replaced with the number of lines.
      -- only works for styles with a border
      ---@type string|boolean
      more_format = ' ↓ %d lines ',
      refresh = 50, -- refresh at most every 50ms
    },
  },
  keys = {
    {
      '<leader>S.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle scratch buffer',
    },
    {
      '<leader>Ss',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select scratch buffer',
    },
    {
      '<leader>nh',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification history',
    },
    {
      '<leader>nd',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss all notifications',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete buffer',
    },
    {
      '<leader>cR',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename file',
    },
    {
      '<leader>gG',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git browse web for current line',
    },
    {
      '<leader>gBl',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git blame current line',
    },
    {
      '<leader>gLf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Current file history',
    },
    {
      '<leader>gL',
      function()
        Snacks.lazygit()
      end,
      desc = 'Launch',
    },
    {
      '<leader>gLl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Log (cwd)',
    },
    -- {
    --   '<c-/>',
    --   function()
    --     Snacks.terminal()
    --   end,
    --   desc = 'Toggle terminal',
    -- },
    -- {
    --   '<c-_>',
    --   function()
    --     Snacks.terminal()
    --   end,
    --   desc = 'which_key_ignore',
    -- },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    {
      '<leader>N',
      desc = 'Neovim News',
      function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        }
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>uh'
      end,
    })
  end,
}
