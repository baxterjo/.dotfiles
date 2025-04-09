-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Load plugins
require('config.lazy')

vim.cmd('set expandtab')
vim.cmd('set tabstop=2')
vim.cmd('set softtabstop=2')
vim.cmd('set shiftwidth=2')
vim.cmd('set splitright')

vim.cmd.colorscheme('catppuccin-macchiato')

-- Always configure plugins BEFORE configuring key mappings.
vim.g.mapleader = ' '

vim.diagnostic.config({ virtual_text = true })

require('config.keymappings')
