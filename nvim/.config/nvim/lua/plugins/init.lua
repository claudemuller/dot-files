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
