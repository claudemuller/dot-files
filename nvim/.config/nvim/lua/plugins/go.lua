return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      --   { '<leader>Tf', ':GoTestFunc<CR>', desc = '[T]est [f]unction' },
      --   { '<leader>TF', ':GoTestFile<CR>', desc = '[T]est [F]ile' },
      --   { '<leader>Tp', ':GoTestPkg<CR>', desc = '[T]est [p]ackage' },
      --
      { "<leader>cgc", ":GoCmt<CR>",        desc = "Function comment" },
      { "<leader>cgm", ":GoMockGen<CR>",    desc = "Mocks for current file" },

      { "<leader>cgt", ":GoAddTag<CR>",     desc = "Tags" },
      { "<leader>crt", ":GoRmTag<CR>",      desc = "Tags" },

      { "<leader>cfs", ":GoFillStruct<CR>", desc = "Struct fields" },
      { "<leader>cfS", ":GoFillSelect<CR>", desc = "Select" },
      { "<leader>cfe", ":GoIfErr<CR>",      desc = "If/Err" },

      { "<leader>ct",  ":GoModTidy<CR>",    desc = "Tidy" },

      -- { '<leader>cd', 'zy:GoDoc <C-r>z<CR>', desc = '[C]ode Go[D]ocs Under Cursor', mode = 'v' },
      -- { '<leader>cs', ':GoPkgOutline<CR>', desc = '[C]ode [S]ymbols' },
    },
    opts = function()
      require("go").setup()

      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require('go.format').goimports()
        end,
        group = format_sync_grp,
      })
      return {
        -- lsp_keymaps = false,
        -- other options
      }
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()'
  },
  {
    "leoluz/nvim-dap-go",
    keys = {
      { "<leader>Dn", ':lua require("dap-go").debug_test()<cr>',      desc = "Nearest test", mode = { "n" } },
      { "<leader>Dl", ':lua require("dap-go").debug_last_test()<cr>', desc = "Last test",    mode = { "n" } },
    },
  },
}
