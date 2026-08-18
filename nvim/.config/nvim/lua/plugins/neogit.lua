return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>vg", "<cmd>Neogit kind=floating<cr>",      desc = "Show Neogit UI" },
    { "<leader>vp", "<cmd>Neogit pull kind=floating<cr>", desc = "Pull" },
    { "<leader>vP", "<cmd>Neogit push kind=floating<cr>", desc = "Push" },
  },
  config = function()
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#98c379", bg = "#21262d" })
    vim.api.nvim_set_hl(0, "DiffChange", { fg = "#d19a66", bg = "#21262d" })
    vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#e06c75", bg = "#21262d" })
    vim.api.nvim_set_hl(0, "DiffText", { fg = "#ffffff", bg = "#30363d" })
  end,
}
