return {
  -- Core / Common
  require("plugins.language-support.lsp"),
  require("plugins.language-support.linting"),
  require("plugins.language-support.utils"),
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        auto_install = true,
        ensure_installed = { "markdown", "markdown_inline", "html" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
