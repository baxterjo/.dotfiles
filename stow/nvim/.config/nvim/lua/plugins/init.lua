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
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "AI Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "AI Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "AI Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "AI Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "AI Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "AI Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "AI Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "AI Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "AI Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "AI Deny diff" },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  -- Used for parsing vscode's dialect of json (with comments)
  {
    "Joakker/lua-json5",
    build = "./install.sh",
    config = function()
      require("json5")
    end,
    lazy = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    opts = {
      extensions_list = { "themes", "terms", "live_grep_args" },
    },
  },
}
