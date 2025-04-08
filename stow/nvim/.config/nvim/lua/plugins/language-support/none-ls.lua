return {
  'nvimtools/none-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- null-ls was deprecated, none-ls uses the same bindings to make migration easy.
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.codespell,
      },
    })
  end,
}
