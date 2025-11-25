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

---Checks to see if a table contains a value
---@param table table<string>
---@param value string
---@return boolean
local function tableContains(table, value)
  for _, item in ipairs(table) do
    if item == value then
      return true
    end
  end
  return false
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
    gdscript = { gdscript = {} },
    json = { jsonls = {} },
    lua = { lua_ls = {} },
    markdown = { marksman = {} },
    proto = { protols = {} },
    python = { basedpyright = {}, ruff = {} },
    rust = { rust_analyzer = {} },
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
    dotenv = { ["dotenv-linter"] = {} },
  },
  -- Formatters are run by conform
  formatter = {
    -- Rust formatting is handled by rustaceanvim
  },
}

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

---Returns a table of the names of all of the linters in M.tools
---@return table<string>
function M.linters()
  local out = {}
  for _, tools in pairs(M.linters_by_ft()) do
    for _, tool in ipairs(tools) do
      table.insert(out, tool)
    end
  end
  return out
end

---Returns a table of the names of all of the LSPs in M.tools
---@return table<string>
function M.ensure_installed()
  local out = {}
  for _, tool in pairs(M.lsps()) do
    if not tableContains({ "gdscript" }, tool) then
      table.insert(out, tool)
    end
  end

  out = remove_dupes(out)
  return out
end

---@return table<string, string[]>
function M.linters_by_ft()
  -- All this just to remove the "*" from the tools list
  local out = {}
  for ft, tools in pairs(M.tools.linter) do
    if ft ~= "*" then
      local linters = {}
      for tool_name, _ in pairs(tools) do
        table.insert(linters, tool_name)
      end

      out[ft] = linters
    end
  end
  return out
end

function M.config_lsp()
  -- load defaults i.e lua_lsp
  local nvlsp = require("nvchad.configs.lspconfig")
  nvlsp.defaults()

  local servers = M.lsp_configs()

  -- lsps with default config
  for name, opts in pairs(servers) do
    -- Skip LSPs that are setup by other services.
    -- lua_ls is setup by nvchad
    -- rust_analyzer is set up by rustaceanvim
    if tableContains({ "lua_ls", "rust_analyzer" }, name) then
      goto continue
    end
    opts.on_attach = nvlsp.on_attach
    opts.on_init = nvlsp.on_init
    opts.capabilities = nvlsp.capabilities
    vim.lsp.config(name, opts)
    vim.lsp.enable(name)
    ::continue::
  end
end

function M.setup_rust()
  local rustaceanvim_json = require("rustaceanvim.config.json")

  --- Overwrite rustaceanvim's json parser to allow json with comments.
  ---@param json_content string
  ---@return table
  ---@diagnostic disable-next-line: duplicate-set-field
  function rustaceanvim_json.silent_decode(json_content)
    rustaceanvim_json.warnings = {}
    rustaceanvim_json.errors = {}
    local ok, json_tbl = pcall(require("json5").parse, json_content)
    if not ok or type(json_tbl) ~= "table" then
      rustaceanvim_json.add_error(("Failed to decode json: %s"):format(json_tbl or "unknown error"))
      return {}
    end
    return json_tbl
  end

  -- Rustaceanvim Config
  vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {

      on_initialized = function(_, _)
        -- Flicker inlay hints when rust analyzer is finished initializing
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      enable_clippy = false,
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

      cmd = function()
        local mason_registry = require("mason-registry")
        if mason_registry.is_installed("rust-analyzer") then
          -- This may need to be tweaked depending on the operating system.
          local ra = vim.fn.expand("$MASON/bin/rust-analyzer") or "rust-analyzer"
          -- vim.print("Using RA " .. ra)
          return { ra }
        else
          -- global installation
          return { "rust-analyzer" }
        end
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
          diagnostics = { enable = true },
        },
      },
      load_vscode_settings = true,
    },
    -- DAP configuration
    dap = {},
  }
end

return M
