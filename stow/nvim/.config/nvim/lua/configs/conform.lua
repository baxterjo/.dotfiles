local options = {
  -- Formatters should only be added if the language's LSP does not format.
  formatters_by_ft = {
    -- A first party LSP formatter is being considered: https://github.com/godotengine/godot-proposals/issues/3630
    gdscript = {
      "gdformat",
      format_on_save = {
        timeout_ms = 5000,
        lsp_fallback = true,
      },
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
