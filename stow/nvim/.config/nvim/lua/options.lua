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
