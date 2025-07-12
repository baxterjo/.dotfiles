return {
  require("plugins.language-support"),
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require("configs.conform"),
  },
  {
    "RRethy/vim-illuminate",
    lazy = false,
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  { "echasnovski/mini.surround", version = "*" },
}
