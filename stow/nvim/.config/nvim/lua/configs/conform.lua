local options = {
  -- Formatters should only be added if the language's LSP does not format.
  formatters_by_ft = {
    markdown = { "mdformat" },
    -- A first party LSP formatter is being considered: https://github.com/godotengine/godot-proposals/issues/3630
    gdscript = {
      "gdformat",
      format_on_save = {
        timeout_ms = 5000,
        lsp_fallback = true,
      },
    },
  },

  formatters = {
    mdformat = {
      -- Mason uses PATH = "skip" in NvChad. Prefer a project virtualenv, then Mason.
      command = function(self, ctx)
        local mason = vim.fn.stdpath("data") .. "/mason/bin/mdformat"
        local fallback = vim.fn.executable(mason) == 1 and mason or "mdformat"
        return require("conform.util").find_executable({ ".venv/bin/mdformat" }, fallback)(self, ctx)
      end,
    },
  },

  format_on_save = {
    timeout_ms = 2000,
    lsp_format = "fallback",
  },
}

return options
