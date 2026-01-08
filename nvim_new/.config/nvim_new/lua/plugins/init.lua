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
