return {
  "sindrets/diffview.nvim",
  opts = {},
  config = function()
    local function file_history_to_diffview()
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      builtin.git_bcommits({
        attach_mappings = function(prompt_bufnr, map)
          -- Override 'Enter' to open Diffview
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            -- selection.value is the commit hash
            vim.cmd("DiffviewOpen " .. selection.value .. "^!" .. " -- " .. selection.path)
          end)
          return true
        end,
      })
    end

    -- TODO: put in functions
    local function get_main_branch()
      local remote_head = vim.fn.systemlist("git symbolic-ref refs/remotes/origin/HEAD --short 2>/dev/null")[1]
      if vim.v.shell_error == 0 and remote_head then
        return remote_head -- Returns "origin/main" or "origin/master"
      end

      if vim.fn.system("git rev-parse --verify main 2>/dev/null") ~= "" then
        return "main"
      end

      return "master"
    end

    -- Keymap example:
    vim.keymap.set("n", "<leader>vh", file_history_to_diffview, { desc = "File git history (Diffview)" })

    -- Helper for cleaner keymaps
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
    end

    -- 1. Current file with HEAD~1 (Previous version)
    map("n", "<leader>vfp", "<cmd>DiffviewOpen HEAD~1 -- %<cr>", "Diff File: Previous Commit")

    -- 2. Current file with a specific branch (Prompt for branch name)
    map("n", "<leader>vfb", function()
      local branch = vim.fn.input("Branch to compare: ")
      if branch ~= "" then
        vim.cmd("DiffviewOpen " .. branch .. " -- %")
      end
    end, "Diff File: Against Branch")

    -- 3. Current file with HEAD (Uncommitted changes)
    -- Note: DiffviewOpen with no args defaults to comparing current state vs Index/HEAD
    map("n", "<leader>vfh", "<cmd>DiffviewOpen -- %<cr>", "Diff File: Against HEAD")

    -- 4. Current STATE (All staged/unstaged) with HEAD
    map("n", "<leader>vsh", "<cmd>DiffviewOpen<cr>", "Diff State: Against HEAD")

    -- 5. Current STATE (All staged/unstaged) with Branch
    map("n", "<leader>vsb", function()
      local branch = vim.fn.input("Branch to compare: ")
      if branch ~= "" then
        vim.cmd("DiffviewOpen " .. branch)
      end
    end, "Diff State: Against Branch")

    -- 6. Current branch with main (changes on this branch)
    map("n", "<leader>vdsb", function()
      vim.cmd("DiffviewOpen origin/main... -- %")
      -- vim.cmd("DiffviewOpen origin/" .. get_main_branch() .. "... -- %")
    end, "Diff State: Against Branch")

    -- Bonus: Close the diff view easily
    map("n", "<leader>dc", "<cmd>DiffviewClose<cr>", "Diff: Close View")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "DiffviewFiles,DiffviewFileHistory",
      callback = function()
        vim.api.nvim_set_hl(0, "DiffviewDiffAdd", { fg = "#98c379", bg = "#21262d" })
        vim.api.nvim_set_hl(0, "DiffviewDiffChange", { fg = "#d19a66", bg = "#21262d" })
        vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { fg = "#e06c75", bg = "#21262d" })
        vim.api.nvim_set_hl(0, "DiffviewDiffText", { fg = "#ffffff", bg = "#30363d" })
      end,
    })
  end,
}
