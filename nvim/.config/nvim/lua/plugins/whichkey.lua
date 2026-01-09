-----------------------------------------------------------------------
-- [[ Which Key config ]]
-----------------------------------------------------------------------

return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    local wk = require("which-key")

    wk.add({
      -- { "<leader>d",  group = "Diagnostics" },
      -- { "<leader>N",  group = "Code notes" },
      --
      -- { "<leader>c",  group = "Code" },
      -- { "<leader>cg", group = "Generate" },
      -- { "<leader>cr", group = "Remove" },
      -- { "<leader>cf", group = "Fill" },
      --
      -- { "<leader>l",  group = "LSP" },
      -- { "<leader>T",  group = "Test" },
      -- { "<leader>D",  group = "Debug" },
      --
      -- { "<leader>s",  group = "Search" },
      -- { "<leader>sf", group = "Files" },
      -- -- { '<leader>ss', group = 'Symbols' },
      -- { "<leader>sg", group = "Grep" },
      --
      -- { "<leader>r",  group = "Rename" },
      --
      -- { "<leader>O",  group = "Obsidian" },
      -- { "<leader>Od", group = "Daily" },
      --
      { "<leader>f", group = "Find" },
      -- { "<leader>ft", group = "Toggle" },
      --
      -- { "<leader>h",  group = "Hints" },
      -- { "<leader>ht", group = "Toggle" },
      --
      { "<leader>g", group = "Grep" },

      { "<leader>v", group = "Version control (git)" },
      -- { "<leader>gh", group = "Hunk" },
      -- { "<leader>gt", group = "Toggle" },
      -- { "<leader>gd", group = "Diff" },
      -- { "<leader>gl", group = "Log" },
      -- { "<leader>gL", group = "Lazygit" },
      --
      -- { "<leader>u",  group = "Toggle UI features" },
      --
      -- { "<leader>t",  group = "Trouble" },
      --
      -- { "<leader>n",  group = "Notifications" },
      --
      -- { "<leader>b",  group = "Buffers" },
      -- { "<leader>S",  group = "Scratch buffer" },
    })
  end,
}
