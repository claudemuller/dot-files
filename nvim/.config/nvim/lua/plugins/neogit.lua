return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>vg", "<cmd>Neogit kind=floating<cr>", desc = "Show Neogit UI" },
  },
  config = function()
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#73c991", bg = "#21262d" })
    vim.api.nvim_set_hl(0, "DiffChange", { fg = "#cca760", bg = "#21262d" })
    vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#e06c75", bg = "#21262d" })
    vim.api.nvim_set_hl(0, "DiffText", { fg = "#ffffff", bg = "#30363d" })
  end,
}
