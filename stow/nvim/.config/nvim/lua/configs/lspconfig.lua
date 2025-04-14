-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local nvlsp = require("nvchad.configs.lspconfig")

-- EXAMPLE
-- Rust analyzer is setup by rustaceanvim.
local servers = {
  marksman = {},
  ansiblels = {},
  pyright = {},
  protols = {},
}

-- lsps with default config
for name, opts in pairs(servers) do
  opts.on_attach = nvlsp.on_attach
  opts.on_init = nvlsp.on_init
  opts.capabilities = nvlsp.capabilities
  require("lspconfig")[name].setup(opts)
end
