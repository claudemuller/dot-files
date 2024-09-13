-----------------------------------------------------------------------
-- [[ NeoTest config ]]
-----------------------------------------------------------------------

-- Test thing
-- See `:help neotest`
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-jest',
    'nvim-neotest/neotest-go',
    -- {
    --   dir = '~/repos/3rd-party/neotest-go/',
    -- },
    -- 'nvim-neotest/neotest-rust',
    'nvim-neotest/neotest-vim-test',
  },
  keys = {
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run [T]ests in This File',
    },
    {
      '<leader>tF',
      function()
        local current_file = vim.fn.expand '%:t:r' -- Get filename without extension
        local search_pattern = current_file .. '.*test.*'
        local current_dir = vim.fn.expand '%:p:h'

        local function find_matching_files(dir, pattern)
          local matches = {}
          local files = vim.fn.globpath(dir, '*', false, true)

          for _, file in ipairs(files) do
            local filename = vim.fn.fnamemodify(file, ':t') -- Get the base name of the file
            if filename:match(pattern) then
              table.insert(matches, current_dir .. '/' .. filename)
            end
          end

          return matches
        end

        local matching_files = find_matching_files(current_dir, search_pattern)

        if #matching_files > 0 then
          vim.cmd('vsplit ' .. vim.fn.fnameescape(matching_files[1]))
        else
          print 'No matching files found.'
        end
      end,
      desc = 'Open Matching Test [F]ile',
    },
    {
      '<leader>tt',
      function()
        require('neotest').run.run(vim.loop.cwd())
      end,
      desc = 'Run All [T]est Files',
    },
    {
      '<leader>tr',
      function()
        require('neotest').run.run()
      end,
      desc = '[T]est Nea[r]est',
    },
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = '[T]est [L]ast',
    },
    {
      '<leader>td',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = '[T]est [D]ebug',
    },
    -- ['<leader>td'] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", 'Debug Test' },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle [T]est [s]ummary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = 'Show [T]est [o]utput',
    },
    {
      '<leader>tO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'Toggle [T]est [O]utput Panel',
    },
    {
      '<leader>tS',
      function()
        require('neotest').run.stop()
      end,
      desc = '[T]est [S]top',
    },
  },
  opts = {
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        if require('lazyvim.util').has 'trouble.nvim' then
          require('trouble').open { mode = 'quickfix', focus = false }
        else
          vim.cmd 'copen'
        end
      end,
    },
  },
  config = function()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
        require 'neotest-plenary',
        require 'neotest-jest',
        require 'neotest-go',
        -- require 'neotest-rust',
        require 'neotest-vim-test' {
          ignore_file_types = { 'python', 'vim', 'lua', 'go', 'typescript', 'jest' },
        },
      },
      -- icons = {
      --   expanded = '',
      --   child_prefix = '',
      --   child_indent = '',
      --   final_child_prefix = '',
      --   non_collapsible = '',
      --   collapsed = '',
      --
      --   passed = '',
      --   running = '',
      --   failed = '',
      --   unknown = '',
      -- },
    }
  end,
}
