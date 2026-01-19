return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()',
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
    keys = {
      --   { '<leader>Tf', ':GoTestFunc<CR>', desc = '[T]est [f]unction' },
      --   { '<leader>TF', ':GoTestFile<CR>', desc = '[T]est [F]ile' },
      --   { '<leader>Tp', ':GoTestPkg<CR>', desc = '[T]est [p]ackage' },
      --
      { "<leader>cgc", ":GoCmt<CR>",        desc = "Function comment" },
      { "<leader>cgm", ":GoMockGen<CR>",    desc = "Mocks for current file" },

      { "<leader>cta", ":GoAddTag<CR>",     desc = "Tags" },
      { "<leader>ctr", ":GoRmTag<CR>",      desc = "Tags" },

      { "<leader>cfs", ":GoFillStruct<CR>", desc = "Struct fields" },
      { "<leader>cfS", ":GoFillSelect<CR>", desc = "Select" },
      { "<leader>cfe", ":GoIfErr<CR>",      desc = "If/Err" },

      { "<leader>cT",  ":GoModTidy<CR>",    desc = "Tidy" },

      -- { '<leader>cd', 'zy:GoDoc <C-r>z<CR>', desc = '[C]ode Go[D]ocs Under Cursor', mode = 'v' },
      -- { '<leader>cs', ':GoPkgOutline<CR>', desc = '[C]ode [S]ymbols' },
    },
    config = function()
      local function get_git_root()
        local dot_git = vim.fn.finddir(".git", ".;")
        return vim.fn.fnamemodify(dot_git, ":p:h:h")
      end

      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.go",
        callback = function()
          if get_git_root():find("repos/src") then
            -- golangci-lint run --new-from-rev=HEAD~1
            -- golangci-lint run --new-from-merge-base=main
            vim.fn.jobstart({ "./bin/golangci-lint", "run", "--new-from-rev=HEAD~1", "--fix" }, {
              on_exit = function(_, code)
                if code == 0 then
                  print("Golangci-lint ran successfully")
                end
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "leoluz/nvim-dap-go",
    keys = {
      { "<leader>Dn", ':lua require("dap-go").debug_test()<cr>',      desc = "Nearest test", mode = { "n" } },
      { "<leader>Dl", ':lua require("dap-go").debug_last_test()<cr>', desc = "Last test",    mode = { "n" } },
    },
  },
}
