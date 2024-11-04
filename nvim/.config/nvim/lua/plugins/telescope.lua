-----------------------------------------------------------------------
-- [[ Telescope config ]]
-----------------------------------------------------------------------

-- Fuzzy Finder (files, lsp, etc)
-- See `:help telescope`
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires special font.
    --  If you already have a Nerd Font, or terminal set up with fallback fonts
    --  you can enable this
    -- { 'nvim-tree/nvim-web-devicons' }
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of help_tags options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        mappings = {
          i = {
            -- ['<c-enter>'] = 'to_fuzzy_refine'
            -- Disable up and down keys to get used to c-n and c-p
            ['<up>'] = false,
            ['<down>'] = false,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- needed to exclude some files & dirs from general search
          -- when not included or specified in .gitignore
          find_command = {
            'rg',
            '--files',
            '--hidden',
            '--follow',
            '--glob=!**/.git/*',
            '--glob=!**/.idea/*',
            '--glob=!**/.vscode/*',
            '--glob=!**/build/*',
            '--glob=!**/dist/*',
            '--glob=!**/yarn.lock',
            '--glob=!**/package-lock.json',
            '--glob=!**/vendor/*',
          },
        },
        current_buffer_fuzzy_find = {
          layout_strategy = 'horizontal',
          theme = 'dropdown',
          layout_config = {
            width = 0.7,
            height = 0.6,
          },
          previewer = true,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sF', function()
      builtin.find_files { cwd = vim.fn.input 'Start dir: ' }
    end, { desc = '[S]earch [F]iles in dir' })
    vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch [T]elescope Selects' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord (grep)' })
    vim.keymap.set('n', '<leader>sW', function()
      local term = vim.fn.expand '<cword>'
      builtin.live_grep { default_text = term }
    end, { desc = '[S]earch current [W]ord (grep)' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sG', function()
      builtin.live_grep { cwd = vim.fn.input 'Start dir: ' }
    end, { desc = '[S]earch by [G]rep in dir' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sp', builtin.resume, { desc = '[S]earch [P]revious Picker' })
    vim.keymap.set('n', '<leader>sr', builtin.registers, { desc = '[S]earch [R]egisters' })
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    -- Git shortcuts
    vim.keymap.set('n', '<leader>gL', ':Telescope git_commits<cr>', { desc = '[G]it [L]og in Telescope' })
    vim.keymap.set('n', '<leader>gS', ':Telescope git_status<cr>', { desc = '[G]it [S]tatus in Telescope' })
    vim.keymap.set('n', '<leader>gt', ':Telescope git_stash<cr>', { desc = '[G]it s[T]ash in Telescope' })
    vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<cr>', { desc = '[G]it [B]ranches in Telescope' })
    vim.keymap.set('n', '<leader>glC', ':Telescope git_commits<cr>', { desc = '[G]it [L]og [C]ommits in Telescope' })
    vim.keymap.set('n', '<leader>glc', ':Telescope git_bcommits<cr>', { desc = '[G]it [L]og buffer [C]ommits in Telescope' })

    -- Search search
    local grep_snippets = function()
      local filetype = vim.bo.filetype
      local path = vim.fn.expand '~/.local/share/nvim/lazy/friendly-snippets/snippets/' .. filetype
      local json_path = path .. '.json'

      if vim.fn.filereadable(json_path) == 1 then
        builtin.live_grep {
          search_dirs = { json_path },
          prompt_title = 'Grepping Snippets: ' .. filetype .. '.json',
        }
      else
        builtin.live_grep {
          cwd = path,
          prompt_title = 'Grepping Snippets: ' .. filetype,
        }
      end
    end
    vim.keymap.set('n', '<leader>sX', grep_snippets, { desc = 'Grep [S]nippets' })

    builtin.diagnostics { severity_sort = true }
  end,
}
