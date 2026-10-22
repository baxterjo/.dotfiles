vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

local function load_local_config()
  local path = vim.fn.stdpath("config") .. "/lua/nvim-local.lua"
  if vim.fn.filereadable(path) == 0 then
    return {}
  end

  local config = require("nvim-local")
  assert(type(config) == "table", "nvim-local.lua must return a configuration table")
  return config
end

-- Read once: plugin specs are needed now; local settings run after initialization.
local local_config = load_local_config()

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
  local_config.plugins or {},
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
dofile(vim.g.base46_cache .. "syntax")
dofile(vim.g.base46_cache .. "treesitter")

require("options")
require("nvchad.autocmds")

vim.schedule(function()
  require("mappings")

  -- Apply optional machine-local overrides after shared initialization.
  if local_config.setup then
    local_config.setup()
  end
end)
