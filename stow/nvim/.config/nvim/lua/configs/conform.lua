local options = {
  -- Formatters should only be added if the language's LSP does not format.
  formatters_by_ft = {},

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
