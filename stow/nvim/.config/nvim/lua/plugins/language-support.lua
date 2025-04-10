return {
  -- Core / Common
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "pyright",
        "ansiblels",
        "bashls",
        "yamlls",
        "jsonls",
        "markdownlint-cli2",
        "markdown-toc",
      },
      auto_install = true,
      setup = {
        -- rustaceanvim takes care of rust setup
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
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
  -- Markdown

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = false,
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      -- Snacks.toggle({
      --   name = "Render Markdown",
      --   get = function()
      --     return require("render-markdown.state").enabled
      --   end,
      --   set = function(enabled)
      --     local m = require("render-markdown")
      --     if enabled then
      --       m.enable()
      --     else
      --       m.disable()
      --     end
      --   end,
      -- }):map("<leader>um")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
}
