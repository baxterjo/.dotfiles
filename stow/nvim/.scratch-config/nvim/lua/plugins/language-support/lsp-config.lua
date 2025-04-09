-- LSP package manager, Lazy handles plugins, mason handles LSP servers.
-- https://github.com/williamboman/mason.nvim
--
-- Also check utils.completions.lua if completions is not working as expected.
local function on_lsp_attach(client, bufnr)
  require('plugins.language-support.keymaps').setup(bufnr)
end
return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { 'rust-analyzer' },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.rust_analyzer.setup({
        settings = {
          ['rust-analyzer'] = {
            check = { command = 'clippy' },
            diagnostics = { enable = true },
          },
        },
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })
      lspconfig.jsonls.setup({ capabilities = capabilities })
      lspconfig.yamlls.setup({ capabilities = capabilities })
      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
    end,
  },
}
