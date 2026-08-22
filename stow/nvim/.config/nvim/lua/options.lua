require("nvchad.options")

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.o.exrc = true
vim.diagnostic.config({
  virtual_text = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})
-- Enable diagnostic float windows
vim.o.updatetime = 500 -- how long to wait (ms) before CursorHold fires

require("configs.diagnostics").setup()

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set splitright")
vim.lsp.inlay_hint.enable(true)

-- Set default shell to zsh if installed at Linuxbrew location
if vim.uv.fs_stat("/home/linuxbrew/.linuxbrew/bin/zsh") then
  vim.o.shell = "/home/linuxbrew/.linuxbrew/bin/zsh"
end

-- Add custom filetypes
vim.filetype.add({
  extension = {
    mdx = "mdx",
    env = "dotenv",
  },

  filename = {
    [".env"] = "dotenv",
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },

  pattern = {
    -- Github actions yaml files
    [".*/%.github[%w/]+workflows[%w/]+.*%.ya?ml"] = "yaml.github",
    -- dotenv files
    ["%.env%.[%w_.-]+"] = "dotenv",
    -- .vscode/*.json files are JSONC (allow comments + trailing commas)
    [".*/%.vscode/.*%.json"] = "jsonc",
    -- Docker compose yaml files
    ["docker%-compose%.[%w_.-]+%.ya?ml"] = "yaml.docker-compose",
    ["compose%.[%w_.-]+%.ya?ml"] = "yaml.docker-compose",
  },
})

-- Registers dotenv files to be highlighted using bash syntax highlighting.
vim.treesitter.language.register("bash", "dotenv")
-- Registers MDX files to be highlighted using markdown syntax highlighting.
vim.treesitter.language.register("markdown", "mdx")
require("configs.language-support").config_lsp()
require("configs.language-support").setup_rust()

-- Disable autoformat for toml files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "toml" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- paths to check for project.godot file
local paths_to_check = { "/", "/../" }
local is_godot_project = false
local godot_project_path = ""
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for _, value in pairs(paths_to_check) do
  if vim.uv.fs_stat(cwd .. value .. "project.godot") then
    is_godot_project = true
    godot_project_path = cwd .. value
    break
  end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. "server.pipe")
-- start server, if not already running
if is_godot_project then
  if not is_server_running then
    vim.fn.serverstart(godot_project_path .. "server.pipe")
  end
  local dap = require("dap")
  dap.adapters.godot = {
    type = "server",
    host = "127.0.0.1",
    port = 6006,
  }
  dap.configurations.gdscript = {
    {
      type = "godot",
      request = "launch",
      name = "Launch scene",
      project = "${workspaceFolder}",
      launch_scene = true,
    },
  }
end
