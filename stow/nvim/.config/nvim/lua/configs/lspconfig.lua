-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { rust_analyzer = {}, lua_ls = {}, ansiblels = {}, pyright = {} }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for name, opts in ipairs(servers) do
  opts.on_attach = nvlsp.on_attach
  opts.on_init = nvlsp.on_init
  opts.capabilities = nvlsp.capabilities
  lspconfig[name].setup(opts)
end
