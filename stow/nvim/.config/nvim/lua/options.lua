require("nvchad.options")

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.diagnostic.config({
  virtual_text = true,
  float = {
    source = true,
  },
})
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set splitright")
vim.lsp.inlay_hint.enable(true)

vim.filetype.add({
  filename = {
    [".mdx"] = "mdx",
  },

  pattern = {
    [".*/%.github[%w/]+workflows[%w/]+.*%.ya?ml"] = "yaml.github",
  },
})

require("configs.language-support").config_lsp()
require("configs.language-support").setup_rust()

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
