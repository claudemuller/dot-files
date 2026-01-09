-----------------------------------------------------------------------
-- [[ Go config ]]
-----------------------------------------------------------------------

-- Go stuff
-- See `:help go`
return {
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
    { "<leader>cgc", ":GoCmt<CR>", desc = "Function comment" },
    { "<leader>cgm", ":GoMockGen<CR>", desc = "Mocks for current file" },

    { "<leader>cgt", ":GoAddTag<CR>", desc = "Tags" },
    { "<leader>crt", ":GoRmTag<CR>", desc = "Tags" },

    { "<leader>cfs", ":GoFillStruct<CR>", desc = "Struct fields" },
    { "<leader>cfS", ":GoFillSelect<CR>", desc = "Select" },
    { "<leader>cfe", ":GoIfErr<CR>", desc = "If/Err" },

    { "<leader>ct", ":GoModTidy<CR>", desc = "Tidy" },

    -- { '<leader>cd', 'zy:GoDoc <C-r>z<CR>', desc = '[C]ode Go[D]ocs Under Cursor', mode = 'v' },
    -- { '<leader>cs', ':GoPkgOutline<CR>', desc = '[C]ode [S]ymbols' },
  },
  init = function()
    require("go").setup()
    require("go.format").goimport() -- goimport + gofmt
    vim.cmd("GoInstallBinaries")
  end,
  event = { "CmdlineEnter" },
  ft = {
    "go",
    "gomod",
  },
  build = ':lua require("go.install").update_all_sync()',
}
