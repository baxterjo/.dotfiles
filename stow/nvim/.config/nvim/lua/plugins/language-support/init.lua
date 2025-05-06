return {
  -- Core / Common
  require("plugins.language-support.lsp"),
  require("plugins.language-support.linting"),
  require("plugins.language-support.utils"),
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = { auto_install = true, sync_install = false },
  },
}
