local function remove_dupes(tab)
  local set = {}
  local finalTab = {}
  for _, val in pairs(tab) do
    if not set[val] then
      set[val] = 1
    else
      set[val] = set[val] + 1
    end
  end

  for k, v in pairs(set) do
    if v == 1 then
      finalTab[#finalTab + 1] = k
    end
  end

  return finalTab
end

local M = {}

---@type table<string, table<string, table<string, any>>>
M.tools = {
  -- LSPs are run by nvim-lspconfig
  lsp = {
    ansible = { ansiblels = {} },
    json = { jsonls = {} },
    markdown = { marksman = {} },
    proto = { protols = {} },
    python = { pyright = {} },
    -- Rust LSP is handled by rustaceanvim
    sh = { bashls = {} },
    toml = { taplo = {} },
    yaml = { yamlls = {} },
  },
  dap = {},
  -- Linters are run by nvim lint
  linter = {
    ["*"] = { cspell = {} },
    json = { jsonlint = {} },
    lua = { luacheck = {} },
    markdown = { markdownlint = {}, vale = {} },
    make = { checkmake = {} },
    python = { flake8 = {} },
    rst = { vale = {} },
    sh = { shellcheck = {} },
    text = { vale = {} },
    yaml = { yamllint = {} },
  },
  -- Formatters are run by conform
  formatter = {
    lua = { stylua = {} },
    python = { black = {} },
    -- Rust formatting is handled by rustaceanvim
  },
}

function M.mason_tools()
  local out = {}
  for _, by_ft in pairs(M.tools) do
    for _, tools in pairs(by_ft) do
      for tool, _ in pairs(tools) do
        if not out[tool] then
          table.insert(out, tool)
        end
      end
    end
  end
  out = remove_dupes(out)
  return out
end

function M.linters_by_ft()
  -- All this just to remove the "*" from the tools list
  local out = {}
  for ft, tool in pairs(M.tools.linter) do
    if ft ~= "*" then
      local linters = {}
      for tool_name, _ in pairs(tool) do
        table.insert(linters, tool_name)
      end

      out[ft] = linters
    end
  end
  return out
end

function M.lspconfig()
  -- load defaults i.e lua_lsp
  require("nvchad.configs.lspconfig").defaults()
  local nvlsp = require("nvchad.configs.lspconfig")

  --EXAMPLE
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
end

return M
