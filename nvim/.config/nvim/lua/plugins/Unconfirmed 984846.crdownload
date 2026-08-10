return {
  "jinzhongjia/zig-lamp",
  event = "VeryLazy",
  -- Optional but recommended: build the local FFI lib to enable faster/safer verification & formatting
  build = ":ZigLampBuild async",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- For Neovim < 0.11 you’ll likely want lspconfig
    "neovim/nvim-lspconfig",
  },
  init = function()
    -- Backward-compatible global vars (all optional)
    -- Auto-install ZLS: timeout in milliseconds; set to nil to disable
    vim.g.zig_lamp_zls_auto_install = nil
    -- Fallback to system zls when no local match is found
    vim.g.zig_lamp_fall_back_sys_zls = nil
    -- Extra LSP options merged into defaults
    vim.g.zig_lamp_zls_lsp_opt = {}
    -- ZLS server settings (overrides built-in recommendations)
    vim.g.zig_lamp_zls_settings = {}
    -- Help text color for the package panel
    vim.g.zig_lamp_pkg_help_fg = "#CF5C00"
    -- Timeout (ms) used by `zig fetch` when retrieving url hashes
    vim.g.zig_lamp_zig_fetch_timeout = 5000
  end,
}
