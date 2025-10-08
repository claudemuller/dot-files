-----------------------------------------------------------------------
-- [[ Telescope config ]]
-----------------------------------------------------------------------

local grep_buffer_for_text = function(builtin)
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' and mode ~= '' then
    builtin.current_buffer_fuzzy_find()
  else
    -- TODO: this stuff is wonky :/ fix
    local start_line, start_col = unpack(vim.fn.getpos "'<", 2, 3)
    local end_line, end_col = unpack(vim.fn.getpos "'>", 2, 3)
    if start_line ~= end_line then
      print 'Selection spans multiple lines, no go sailor :('
      return nil
    end

    local line_text = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]
    local selected_text = string.sub(line_text, start_col, end_col)
    builtin.current_buffer_fuzzy_find { default_text = selected_text }
  end
end

-- Fuzzy Finder (files, lsp, etc)
-- See `:help telescope`
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    -- Two important keymaps to use while in telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    require('telescope').setup {
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
          -- needed to exclude some files & dirs from general search when not included or specified in .gitignore
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

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })

    vim.keymap.set('n', '<leader>sff', builtin.find_files, { desc = 'Files' })
    vim.keymap.set('n', '<leader>sf.', function()
      builtin.find_files { cwd = vim.fn.expand '%:p:h' }
    end, { desc = 'Files in cwd' })
    vim.keymap.set('n', '<leader>sfF', function()
      local get_start_dir = function()
        -- local input = vim.fn.input 'Start dir: '
        local input = vim.fn.input('Start dir: ', '', 'dir')
        local base = vim.fn.expand '%:p:h' -- current buffer's directory
        return vim.fn.fnamemodify(base .. '/' .. input, ':p') -- resolve relative to buffer dir
      end

      builtin.find_files { cwd = get_start_dir() }
    end, { desc = 'Files in dir' })

    vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = 'Telescope selects' })

    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Word under cursor in buffer' })
    vim.keymap.set('n', '<leader>sW', function()
      local term = vim.fn.expand '<cword>'
      builtin.live_grep { default_text = term }
    end, { desc = 'Word under cursor in workspace' })

    vim.keymap.set('n', '<leader>sgg', builtin.live_grep, { desc = 'String in workspace' })
    vim.keymap.set('n', '<leader>sg.', function()
      builtin.live_grep { cwd = vim.fn.expand '%:p:h' }
    end, { desc = 'String in cwd' })
    vim.keymap.set('n', '<leader>sgG', function()
      builtin.live_grep { cwd = vim.fn.input('Start dir: ', '', 'dir') }
    end, { desc = 'String in dir' })

    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'

    local function to_dir(path)
      local uv = vim.loop
      local stat = uv.fs_stat(path)
      if stat and stat.type == 'directory' then
        return path
      else
        return uv.fs_realpath(vim.fn.fnamemodify(path, ':h')) -- parent folder
      end
    end

    vim.keymap.set('n', '<leader>sgD', function()
      builtin.find_files {
        prompt_title = 'Pick a directory',
        cwd = vim.fn.getcwd(),
        -- Show hidden dirs too (optional)
        hidden = true,
        -- Only show items that are directories
        find_command = { 'fd', '--type', 'd', '--strip-cwd-prefix' },
        attach_mappings = function(prompt_bufnr, map)
          -- Replace <CR> with our custom action
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)

            local dir = to_dir(selection.path) -- ensure we have a clean dir path
            builtin.live_grep { cwd = dir }
          end)
          return true
        end,
      }
    end, { desc = 'Live grep in chosen directory' })

    vim.keymap.set('n', '<leader>sp', builtin.resume, { desc = 'Previous picker' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.registers, { desc = 'Registers' })
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = 'Marks' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })

    vim.keymap.set('n', '<leader>sj', builtin.jumplist, { desc = 'Jumplist' })

    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Search buffers' })

    vim.keymap.set({ 'n', 'v' }, '<leader>/', function()
      grep_buffer_for_text(builtin)
    end, { desc = 'Fuzzily grep in current buffer' })

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Grep buffers',
      }
    end, { desc = 'Grep buffers' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Neovim config files' })

    -- Git shortcuts
    vim.keymap.set('n', '<leader>gS', builtin.git_status, { desc = 'Status (Telescope)' })
    vim.keymap.set('n', '<leader>gt', builtin.git_stash, { desc = 'Show stashes (Telescope)' })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Show branches (Telescope)' })
    vim.keymap.set('n', '<leader>glC', builtin.git_commits, { desc = 'Show commits log (Telescope)' })
    vim.keymap.set('n', '<leader>glc', builtin.git_bcommits, { desc = 'Show commits log for buffer (Telescope)' })

    vim.keymap.set('i', '<C-R>', builtin.registers, { desc = 'Search Registers' })

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
    vim.keymap.set('n', '<leader>sX', grep_snippets, { desc = 'Grep snippets' })

    builtin.diagnostics { severity_sort = true }
  end,
}
