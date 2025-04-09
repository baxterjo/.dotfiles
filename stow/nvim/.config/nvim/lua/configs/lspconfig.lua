-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")

-- EXAMPLE
-- Rust analyzer is setup by rustaceanvim.
local servers = { ansiblels = {}, pyright = {} }
local nvlsp = require("nvchad.configs.lspconfig")

-- lsps with default config
for name, opts in ipairs(servers) do
  opts.on_attach = nvlsp.on_attach
  opts.on_init = nvlsp.on_init
  opts.capabilities = nvlsp.capabilities
  lspconfig[name].setup(opts)
end

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      -- you can also put keymaps in here
      vim.keymap.set("n", "<leader>a", function()
        vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
      end, { silent = true, buffer = bufnr })
      vim.keymap.set(
        "n",
        "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
        function()
          vim.cmd.RustLsp({ "hover", "actions" })
        end,
        { silent = true, buffer = bufnr }
      )
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {},
    },
  },
  -- DAP configuration
  dap = {},
}
