return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.1',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local ts = require("telescope")

    ts.setup({
      pickers = {
        find_files = {
          theme = "ivy",
        },
      },
      extensions = {
        fzf = {},
      },
    })

    local builtin = require('telescope.builtin')

    builtin.diagnostics({ severity_sort = true })
    ts.load_extension("fzf")
    require("config.telescope.multigrep").setup()

    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { 0 })
    end

    -- Find  --------------------------------------------------------------------------------------

    -- Find files
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    -- vim.keymap.set("n", "<leader>fF", function()
    --   builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
    -- end, { desc = "Files in cwd" })

    -- Find files in dir
    vim.keymap.set("n", "<leader>fd", function()
      local get_start_dir = function()
        -- local input = vim.fn.input 'Start dir: '
        local input = vim.fn.input("Start dir: ", "", "dir")
        local base = vim.fn.expand("%:p:h")                   -- current buffer's directory
        return vim.fn.fnamemodify(base .. "/" .. input, ":p") -- resolve relative to buffer dir
      end

      builtin.find_files({ cwd = get_start_dir() })
    end, { desc = "Files in dir" })

    -- Find files in cwd
    vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })

    -- Grep -------------------------------------------------------------------------------

    -- Live grep
    local function to_dir(path)
      local uv = vim.loop
      local stat = uv.fs_stat(path)
      if stat and stat.type == "directory" then
        return path
      else
        return uv.fs_realpath(vim.fn.fnamemodify(path, ":h")) -- parent folder
      end
    end

    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    -- Grep in cwd
    -- TODO: fix multigrep's preview
    vim.keymap.set("n", "<leader>gg", builtin.live_grep, { desc = "String in workspace" })

    vim.keymap.set("n", "<leader>g.", function()
      builtin.live_grep({ cwd = vim.fn.expand("%:p:h") })
    end, { desc = "String in cwd" })

    -- Live grep in dir
    vim.keymap.set("n", "<leader>gd", function()
      builtin.find_files({
        prompt_title = "Pick a directory",
        cwd = vim.fn.getcwd(),
        -- Show hidden dirs too (optional)
        hidden = true,
        -- Only show items that are directories
        find_command = { "fd", "--type", "d", "--strip-cwd-prefix" },
        attach_mappings = function(prompt_bufnr, map)
          -- Replace <CR> with our custom action
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)

            local dir = to_dir(selection.path) -- ensure we have a clean dir path
            builtin.live_grep({ cwd = dir })
          end)
          return true
        end,
      })
    end, { desc = "Live grep in dir" })

    local grep_buffer_for_text = function(builtin)
      local mode = vim.fn.mode()
      if mode ~= "v" and mode ~= "V" and mode ~= "" then
        builtin.current_buffer_fuzzy_find()
      else
        -- TODO: this stuff is wonky :/ fix
        local start_line, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
        local end_line, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
        if start_line ~= end_line then
          print("Selection spans multiple lines, no go sailor :(")
          return nil
        end

        local line_text = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]
        local selected_text = string.sub(line_text, start_col, end_col)
        builtin.current_buffer_fuzzy_find({ default_text = selected_text })
      end
    end

    -- Ggrep in current buffer
    vim.keymap.set({ "n", "v" }, "<leader>/", function()
      grep_buffer_for_text(builtin)
    end, { desc = "Fuzzily grep in current buffer" })

    -- Grep in open buffers
    vim.keymap.set("n", "<leader>gb", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Grep buffers",
      })
    end, { desc = "Grep buffers" })

    local grep_snippets = function()
      local filetype = vim.bo.filetype
      local path = vim.fn.expand("~/.local/share/nvim/lazy/friendly-snippets/snippets/") .. filetype
      local json_path = path .. ".json"

      if vim.fn.filereadable(json_path) == 1 then
        builtin.live_grep({
          search_dirs = { json_path },
          prompt_title = "Grepping Snippets: " .. filetype .. ".json",
        })
      else
        builtin.live_grep({
          cwd = path,
          prompt_title = "Grepping Snippets: " .. filetype,
        })
      end
    end

    vim.keymap.set("n", "<leader>gw", builtin.grep_string, { desc = "Word under cursor in buffer" })

    -- Grep in snippets
    vim.keymap.set("n", "<leader>gX", grep_snippets, { desc = "Grep snippets" })

    -- Version control (git) ----------------------------------------------------------------------

    vim.keymap.set("n", "<leader>vS", builtin.git_status, { desc = "Status (Telescope)" })
    vim.keymap.set("n", "<leader>vT", builtin.git_stash, { desc = "Show stashes (Telescope)" })
    vim.keymap.set("n", "<leader>vB", builtin.git_branches, { desc = "Show branches (Telescope)" })
    vim.keymap.set("n", "<leader>vll", builtin.git_commits, { desc = "Show commits log (Telescope)" })
    vim.keymap.set("n", "<leader>vL.", builtin.git_bcommits, { desc = "Show commits log for buffer (Telescope)" })

    -- Find Misc ----------------------------------------------------------------------------------

    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help tags' })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
    vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "Find Telescope selects" })
    vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Find registers" })
    vim.keymap.set("i", "<C-R>", builtin.registers, { desc = "Search Registers" })
    vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Find marks" })
    vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Find jumplist" })

    -- LSP ----------------------------------------------------------------------------------------

    vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })
    vim.keymap.set("n", "gz", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
      vim.cmd("zt")
    end, { desc = "Split go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Show references" })
    vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "Show implementations" })

    vim.keymap.set("n", "<leader>fz", function()
      local symbol = vim.fn.input("Symbol (default: under cursor): ")
      if symbol == "" or symbol == nil then
        symbol = vim.fn.expand("<cword>")
      end
      builtin.lsp_workspace_symbols({ query = symbol })
    end, { desc = "Symbol (default: under cursor)" })

    vim.keymap.set("n", "<leader>fs", function()
      builtin.lsp_document_symbols({ symbol_width = 100 })
    end, { desc = "Document symbols" })

    vim.keymap.set("n", "<leader>fS", function()
      builtin.lsp_workspace_symbols({ symbol_width = 100 })
    end, { desc = "Workspace symbols" })

    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    -- local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- if client and client.server_capabilities.documentHighlightProvider then
    --   vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    --     buffer = event.buf,
    --     callback = vim.lsp.buf.document_highlight,
    --   })
    --
    --   vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    --     buffer = event.buf,
    --     callback = vim.lsp.buf.clear_references,
    --   })
    -- end

    -- Full documentation func
    vim.keymap.set("n", "<leader>ch", function()
      local params = vim.lsp.util.make_position_params()
      vim.lsp.buf_request(0, "textDocument/hover", params, function(_, result, _, _)
        if not result or not result.contents then
          return
        end
        -- Extract the type name from the hover text (looks like "var p Person")
        local typ = result.contents.value:match("%s+([%w_]+)%s*$")
        if typ then
          -- Issue a second hover request on the type name
          local new_params = vim.tbl_extend("force", params,
            { position = { line = params.position.line, character = params.position.character } })
          vim.lsp.buf_request(0, "textDocument/hover", new_params, function(_, res, _, _)
            if res then
              vim.lsp.util.open_floating_preview(vim.lsp.util.convert_input_to_markdown_lines(res.contents), "markdown")
            end
          end)
        end
      end)
    end, { desc = "Full documentation" })

    -- Config -------------------------------------------------------------------------------------

    -- Find in Neovim config
    vim.keymap.set('n', '<leader>en', function()
      local opts = require("telescope.themes").get_ivy({
        cwd = vim.fn.stdpath("config")
      })
      builtin.find_files(opts)
    end, { desc = 'Telescope Neovim config' })
  end
}
