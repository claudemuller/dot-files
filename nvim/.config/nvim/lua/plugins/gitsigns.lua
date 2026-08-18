local function switch_base()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Get all branches
  local branches = vim.fn.systemlist("git branch -a --format='%(refname:short)'")

  -- Prepend a reset option
  table.insert(branches, 1, "  [reset to HEAD]")

  pickers
      .new({}, {
        prompt_title = "Gitsigns Base Branch",
        finder = finders.new_table({ results = branches }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)

            if selection[1] == "  [reset to HEAD]" then
              require("gitsigns").reset_base(true)
              vim.notify("gitsigns: reset base to HEAD", vim.log.levels.INFO)
            else
              local branch = vim.trim(selection[1])
              require("gitsigns").change_base(branch, true)
              vim.notify("gitsigns: base → " .. branch, vim.log.levels.INFO)
            end
          end)
          return true
        end,
      })
      :find()
end

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufEnter", "BufCreate" },
  keys = {
    { "]h",          "<cmd>Gitsigns next_hunk<cr>",        desc = "Next hunk" },
    { "[h",          "<cmd>Gitsigns prev_hunk<cr>",        desc = "Previous hunk" },
    { "ih",          "<cmd><C-U>Gitsigns select_hunk<CR>", "Select Hunk",                 mode = { "o", "x" } },

    { "<leader>vhs", "<cmd>Gitsigns stage_hunk<cr>",       desc = "Stage",                mode = { "n", "v" } },
    { "<leader>vhr", "<cmd>Gitsigns reset_hunk<cr>",       desc = "Reset",                mode = { "n", "v" } },
    { "<leader>vhp", "<cmd>Gitsigns preview_hunk<cr>",     desc = "Preview" },
    { "<leader>vhu", "<cmd>Gitsigns undo_stage_hunk<cr>",  desc = "Undo staged" },
    { "<leader>va",  "<cmd>Gitsigns stage_buffer<cr>",     desc = "Stage buffer" },
    { "<leader>vr",  "<cmd>Gitsigns reset_buffer<cr>",     desc = "Reset buffer" },
    { "<leader>vtb", "<cmd>Gitsigns blame_line<cr>",       desc = "Toggle blame line" },
    { "<leader>vtd", "<cmd>Gitsigns toggle_deleted<cr>",   desc = "Toggle deleted" },
    { "<leader>vdt", "<cmd>Gitsigns diffthis<cr>",         desc = "Diff file with index", mode = { "n", "v" } },
    { "<leader>vdd", "<cmd>Gitsigns diffthis ~<cr>",       desc = "Diff file with ~" },
    {
      "<leader>vdb",
      function()
        switch_base()
      end,
      desc = "Pick branch to diff with",
      mode = { "n" },
    },
  },
  config = function()
    local green = "#98c379"
    local orange = "#d19a66"
    local red = "#e06c75"
    local purple = "#c678dd"

    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "‾" }, -- Deletion at the top of a file
        changedelete = { text = "~" }, -- Line was modified and then deleted
        untracked = { text = "┆" }, -- File is untracked
      },
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      word_diff = true,
      watch_gitdir = {
        follow_files = true,
      },
      signcolumn = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        ignore_witespace = false,
        gnore_witespace = false,
      },
    })

    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = green })
    vim.api.nvim_set_hl(0, "GitSignsStagedAdd", { fg = green })
    vim.api.nvim_set_hl(0, "GitSignsAddPreview", { fg = green })
    vim.api.nvim_set_hl(0, "GitSignsAddLnInline", { fg = green })

    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = purple })
    vim.api.nvim_set_hl(0, "GitSignsStagedChange", { fg = purple })
    vim.api.nvim_set_hl(0, "GitSignsChangeLnInline", { fg = purple })

    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = red })
    vim.api.nvim_set_hl(0, "GitSignsStagedDelete", { fg = red })
    vim.api.nvim_set_hl(0, "GitSignsDeletePreview", { fg = red })
    vim.api.nvim_set_hl(0, "GitSignsDeleteLnInline", { fg = red })
    vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = red })
    vim.api.nvim_set_hl(0, "GitSignsStagedTopdelete", { fg = red })
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = orange })
    vim.api.nvim_set_hl(0, "GitSignsStagedChangedelete", { fg = orange })

    vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = green })
    vim.api.nvim_set_hl(0, "GitSignsStagedUntracked", { fg = green })

    -- This changes the base on load e.g. GIT_BASE=HEAD~1 nvim
    local git_base = os.getenv("GIT_BASE")
    if git_base then
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function(args)
          vim.defer_fn(function()
            local status, gs = pcall(require, "gitsigns")
            if status then
              gs.change_base(git_base)
            end
          end, 200)
        end,
      })
    end
  end,
}
