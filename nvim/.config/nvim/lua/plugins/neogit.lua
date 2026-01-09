return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>vg", "<cmd>Neogit kind=floating<cr>", desc = "Show Neogit UI" }
  },
}
