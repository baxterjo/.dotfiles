return {
  -- Mason is in the NV Chad default config.
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,

    config = function()
      require("mason-lspconfig").setup({
        -- rustaceanvim takes care of rust_analyzer setup
        automatic_enable = {
          -- This ensures that LSPs that have specific configs and automatic
          -- installation are not double instantiated. But LSPs that are
          -- installed manually via mason will start without config.
          exclude = require("configs.language-support").lsps(),
        },
        ensure_installed = require("configs.language-support").lsps(),
      })
    end,
  },
  -- Rust
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
