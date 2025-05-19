---Removes duplicates from a table.
---@param tab table<string>
---@return table<string>
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
  -- This is the list of all the tools that are used in this config.
  -- The general rule for adding new language support is this:
  -- - First add an LSP
  -- - Check if the LSP has diagnostics and formatting.
  -- - If the diagnostics are lacking or if there is no LSP for the language
  --   install a linter.
  -- - If there is no formatting install a formatter.

  -- LSPs are run by nvim-lspconfig
  lsp = {
    -- ["*"] = { harper_ls = {} },
    ansible = { ansiblels = {} },
    json = { jsonls = {} },
    lua = { lua_ls = {} },
    markdown = { marksman = {} },
    proto = { protols = {} },
    python = { basedpyright = {}, ruff = {} },
    -- Rust LSP is handled by rustaceanvim
    sh = { bashls = {} },
    toml = { taplo = {} },
    yaml = {
      yamlls = {},
      gh_actions_ls = {
        filetypes = { "yaml.github" },
        init_options = { sessionToken = "" },
      },
    },
  },
  dap = {},
  -- Linters are run by nvim lint
  linter = {
    make = { checkmake = {} },
    rst = { vale = {} },
    text = { vale = {} },
  },
  -- Formatters are run by conform
  formatter = {
    -- Rust formatting is handled by rustaceanvim
  },
}

---Returns a table of all mason tools. (LSP clients, linters, and formatters)
---@return table<string>
function M.mason_tools()
  local out = {}
  for _, ft in pairs(M.tools) do
    for _, tools in pairs(ft) do
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

---Returns a list of all LSP servers and their settings from M.tools
---@return table<string, table<any>>
function M.lsp_configs()
  local out = {}
  for _, tools in pairs(M.tools.lsp) do
    for tool, settings in pairs(tools) do
      if not out[tool] then
        out[tool] = settings
      end
    end
  end
  return out
end

---Returns a table of the names of all of the LSPs in M.tools
---@return table<string>
function M.lsps()
  local lsps = M.lsp_configs()
  local out = {}
  for tool, _ in pairs(lsps) do
    table.insert(out, tool)
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

function M.config_lsp()
  -- load defaults i.e lua_lsp
  require("nvchad.configs.lspconfig").defaults()
  local nvlsp = require("nvchad.configs.lspconfig")

  --EXAMPLE
  -- Rust analyzer is setup by rustaceanvim.
  local servers = M.lsp_configs()

  -- lsps with default config
  for name, opts in pairs(servers) do
    -- lua_ls is set up by nvchad.
    if name == "lua_ls" then
      goto continue
    end
    opts.on_attach = nvlsp.on_attach
    opts.on_init = nvlsp.on_init
    opts.capabilities = nvlsp.capabilities
    vim.lsp.enable(name)
    vim.lsp.config(name, opts)
    ::continue::
  end
end

function M.setup_rust()
  -- Rustaceanvim Config
  vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {

      on_initiated = function(_, _)
        -- Flicker inlay hints when rust analyzer is finished initializing
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
    },
    -- LSP configuration
    server = {
      on_attach = function(_, bufnr)
        -- you can also put keymaps in here
        vim.keymap.set("n", "<leader>ca", function()
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
        ["rust-analyzer"] = {
          diagnostics = { enable = true },
        },
      },
    },
    -- DAP configuration
    dap = {},
  }
end

return M
