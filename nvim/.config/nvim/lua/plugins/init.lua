return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "minimal",
        options = {
          multilines = {
            enabled = true,
            always_show = true,
          },
        },
      })

      vim.diagnostic.config({ virtual_text = false })
    end,
  },

  -- {
  --   "ronisbr/nano-theme.nvim",
  --   config = function()
  --     require("nano-theme").setup({
  --       light_variant = "gray",
  --       dark_variant = "amber",
  --       transparent = false,
  --       transparent_floats = true,
  --       float_blend = 0,
  --     })
  --     vim.o.background = "light"
  --     vim.cmd.colorscheme("nano-theme")
  --   end,
  -- },

  {
    "huyvohcmc/atlas.vim",
    config = function()
      vim.cmd.colorscheme("atlas")
      vim.api.nvim_set_hl(0, "Normal", { bg = "#121212" })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#5c5f62", italic = true })
      vim.api.nvim_set_hl(0, "@comment", { fg = "#5c5f62", italic = true })
      vim.api.nvim_set_hl(0, "Identifier", { fg = "#c0c0c0" })
      vim.api.nvim_set_hl(0, "@variable", { fg = "#c0c0c0" })
      vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { bg = "#2e2e2e", fg = "#5c5f62", bold = true })
      -- Popup & completion menu
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#161616", fg = "#cccccc" })
      -- Selected item in the popup menu
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#2e2e2e", fg = "#ffffff", bold = true })
      -- General floating windows (LSP hover, diagnostics)
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#161616", fg = "#cccccc" })
      -- Floating window borders
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#161616", fg = "#555555" })
      -- Matching Brackets (Highlight when cursor is on a bracket)
      vim.api.nvim_set_hl(0, "MatchParen", { bg = "#383838", fg = "#ffffff", bold = true })
    end,
  },

  -- {
  --   "hardselius/warlock",
  --   config = function()
  --     vim.cmd.colorscheme("warlock")
  --     vim.api.nvim_set_hl(0, "Normal", { bg = "#121212" })
  --   end,
  -- },

  -- { -- Snazzy theme
  --   "dzfrias/noir.nvim",
  --   config = function()
  --     vim.cmd.colorscheme("noir")
  --     vim.api.nvim_set_hl(0, "Comment", { fg = "#5c5f62", italic = true })
  --     vim.api.nvim_set_hl(0, "@comment", { fg = "#5c5f62", italic = true })
  --   end,
  -- },

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
    opts = {
      colors = {
        error = { "#5c5f62" },
        warning = { "#5c5f62" },
        info = { "#5c5f62" },
        hint = { "#5c5f62" },
        default = { "#5c5f62" },
        test = { "#5c5f62" },
      },
    },
  },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- {
  --   "tpope/vim-fugitive",
  --   dependencies = {
  --     "tpope/vim-rhubarb",
  --   },
  --   keys = {
  --     -- { "<leader>gs",       ":Git<cr>",                desc = "Status",               mode = { "n", "v" } },
  --     -- { "<leader>gc",       ":Git commit<cr>",         desc = "Commit",               mode = { "n", "v" } },
  --     -- { "<leader>gp",       ":Git pull<cr>",           desc = "Pull",                 mode = { "n", "v" } },
  --     -- { "<leader>gP",       ":Git push<cr>",           desc = "Push",                 mode = { "n", "v" } },
  --     -- { "<leader>gll",      ":Gllog<cr>",              desc = "Log",                  mode = { "n", "v" } },
  --     --
  --     -- { "<leader>gdh",      ":Gdiff :0<cr>",           desc = "Hunk",                 mode = { "n", "v" } },
  --     -- { "<leader>gdm",      ":Gvdiffsplit master<cr>", desc = "With master",          mode = { "n", "v" } },
  --
  --     { "<leader>vC",       ":Git mergetool<cr>", desc = "Show merge conflicts", mode = { "n", "v" } },
  --     { "<leader>vR",       ":Gvdiffsplit!<cr>",  desc = "Resolve conflicts",    mode = { "n", "v" } },
  --     { "<localleader>vdT", ":diffget //3<cr>",   desc = "Accept theirs",        mode = { "n", "v" } },
  --     { "<localleader>vdM", ":diffget //2<cr>",   desc = "Accept mine",          mode = { "n", "v" } },
  --
  --     -- { "<localleader>gBf", ":Git blame<cr>",          desc = "Git blame",            mode = { "n", "v" } },
  --   },
  -- },

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
