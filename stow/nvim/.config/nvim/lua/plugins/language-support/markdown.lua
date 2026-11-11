return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    cmd = { "RenderMarkdown" },
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown buf_toggle<cr>", ft = "markdown", desc = "Markdown toggle rendering" },
    },
    opts = {
      completions = { lsp = { enabled = true } },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end,
  },
  {
    "selimacerbas/mdkite.nvim",
    dependencies = { "selimacerbas/kitehost.nvim" },
    -- Upstream's README omits these, but this config sets `defaults = { lazy = true }`,
    -- so the plugin needs an explicit trigger or its commands are never registered.
    cmd = { "MdKite" },
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MdKite start<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      require("mdkite").setup({
        instance_mode = "takeover", -- or "multi"
        port = 0, -- auto
        open_browser = true,
        default_theme = "dark",
        debounce_ms = 300,
        mermaid_elk = true,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline", "html" })
    end,
  },
  {
    "bullets-vim/bullets.nvim",
    ft = "markdown",
    opts = {
      enabled_file_types = { "markdown" },
      set_mappings = false,
      -- Keep task states compatible with GitHub Markdown.
      checkbox_markers = " x",
      nested_checkboxes = false,
      auto_indent_after_colon = false,
      custom_mappings = {
        { "n", "o", "<Plug>(bullets-newline)" },
        { { "n", "x" }, "gN", "<Plug>(bullets-renumber)" },
        { "n", "<leader>mx", "<Plug>(bullets-toggle-checkbox)" },
        { "i", "<C-t>", "<Plug>(bullets-demote)" },
        { "i", "<C-d>", "<Plug>(bullets-promote)" },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.keymap = opts.keymap or {}
      opts.keymap["<CR>"] = {
        "accept",
        function()
          if vim.bo.filetype == "markdown" then
            -- Blink evaluates this under textlock; run the edit after the expression returns.
            return vim.api.nvim_replace_termcodes("<Cmd>InsertNewBullet<CR>", true, false, true)
          end
        end,
        "fallback",
      }
    end,
  },
}
