local M = {}

function M.setup()
  require('notify').setup({
    render = 'compact',
    stages = 'fade',
    top_down = false,
    icons = {
      DEBUG = "",
      ERROR = "",
      INFO = "",
      TRACE = "",
      WARN = ""
    },
  })

  require("noice").setup({
    views = {
      cmdline_popup = {
        border = {
          style = "none",
          padding = { 2, 3 },
        },
        filter_options = {},
        win_options = {
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
        position = {
          row = "45%",
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "64%",
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
        },
      },
    },
    cmdline = {
      format = {
        cmdline = { pattern = "^:", icon = "❯", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = "/ ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = "? ", lang = "regex" },
      }
    },
    lsp = {
      progress = {
        enabled = false,
      },
      hover = {
        enabled = true,
        silent = false, -- set to true to not show a message if hover is not available
        view = nil,     -- when nil, use defaults from documentation
        ---@type NoiceViewOptions
        opts = {},      -- merged with defaults from documentation
      },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = false,        -- use a classic bottom cmdline for search
      command_palette = true,       -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
    -- add any options here
  })

  -- vim.keymap.set({ 'n', 'i', 's' }, '<c-f>', function()
  --   if not require('noice.lsp').scroll(4) then
  --     return '<C-f>'
  --   end
  -- end, { silent = true, expr = true })

  -- vim.keymap.set({ 'n', 'i', 's' }, '<c-b>', function()
  --   if not require('noice.lsp').scroll(-4) then
  --     return '<C-b>'
  --   end
  -- end, { silent = true, expr = true })
end

return M
