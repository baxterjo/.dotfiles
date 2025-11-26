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
  { import = "nvchad.blink.lazyspec" },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      -- Set up VS Code-like colors with precedence: errors > warnings > git
      vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#e5c07b" }) -- Modified: yellow shading
      vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#98c379" }) -- Untracked: green shading
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarningFileHL", { fg = "#e5c07b" }) -- Warning: yellow shading
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticErrorFileHL", { fg = "#e06c75" }) -- Error: red shading

      require("nvim-tree").setup({
        filters = {
          git_ignored = false,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = false,
          severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR,
          },
          icons = {
            hint = "•",
            info = "•",
            warning = "•",
            error = "•",
          },
        },
        renderer = {
          highlight_git = "name",
          highlight_diagnostics = "name",
          highlight_opened_files = "name",
          highlight_modified = "name",
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
            glyphs = {
              git = {
                unstaged = "M",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "U",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        sort = {
          sorter = function(nodes)
            local is_special = function(name)
              return name == "mod.rs" or name == "__init__.py" or name == "init.lua"
            end

            table.sort(nodes, function(a, b)
              local a_type = a.type
              local b_type = b.type

              -- Directories come before files (default folders_first behavior)
              if a_type ~= b_type then
                return a_type == "directory"
              end

              local a_name = a.name
              local b_name = b.name
              -- Special files come first (within their type category)
              local a_is_special = is_special(a_name)
              local b_is_special = is_special(b_name)

              -- Within the same type, special files come first
              if a_is_special and not b_is_special then
                return true
              elseif not a_is_special and b_is_special then
                return false
              end

              -- If both or neither are special files, sort alphabetically (case-insensitive)
              return a_name:lower() < b_name:lower()
            end)
          end,
        },
      })
    end,
  },
}
