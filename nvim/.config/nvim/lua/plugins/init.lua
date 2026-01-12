return {
  { -- Snazzy theme
    "dzfrias/noir.nvim",
    config = function()
      vim.cmd.colorscheme("noir")
      vim.api.nvim_set_hl(0, "Comment", { fg = "#5c5f62", italic = true })
      vim.api.nvim_set_hl(0, "@comment", { fg = "#5c5f62", italic = true })
    end
  },

  { -- Mason for tool installtion
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  -- Mulit selections
  { "mg979/vim-visual-multi" },

  -- Better notifications
  { "rcarriga/nvim-notify" },

  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- TODO: clean this up :)
  {
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

      -- Bonus: Close the diff view easily
      map("n", "<leader>dc", "<cmd>DiffviewClose<cr>", "Diff: Close View")
    end
  },

  -- {
  --   "aaronhallaert/advanced-git-search.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     -- to show diff splits and open commits in browser
  --     "tpope/vim-fugitive",
  --     -- to open commits in browser with fugitive
  --     "tpope/vim-rhubarb",
  --     -- optional: to replace the diff from fugitive with diffview.nvim
  --     -- (fugitive is still needed to open in browser)
  --     -- "sindrets/diffview.nvim",
  --   },
  --   cmd = { "AdvancedGitSearch" },
  --   config = function()
  --     -- optional: setup telescope before loading the extension
  --     require("telescope").setup {
  --       -- move this to the place where you call the telescope setup function
  --       extensions = {
  --         advanced_git_search = {
  --           -- See Config
  --         }
  --       }
  --     }
  --
  --     require("telescope").load_extension("advanced_git_search")
  --   end,
  -- },

  { -- Nvim config dev helper
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
