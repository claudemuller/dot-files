return {
  {
    "dzfrias/noir.nvim",
    config = function()
      vim.cmd.colorscheme("noir")
      vim.api.nvim_set_hl(0, "Comment", { fg = "#5c5f62", italic = true })
      vim.api.nvim_set_hl(0, "@comment", { fg = "#5c5f62", italic = true })
    end
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  { "mg979/vim-visual-multi" },

  { "rcarriga/nvim-notify" },

  -- TODO: check config
  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
    },
  },

  { -- TODO: check config
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
