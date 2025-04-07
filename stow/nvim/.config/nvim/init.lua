-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Load plugins
require("config.lazy")

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Always configure plugins BEFORE configuring key mappings.
vim.g.mapleader = " "

local t_builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-P>", t_builtin.find_files, {desc="Find files in the project using telescope"})
vim.keymap.set("n", "<leader>fg", t_builtin.live_grep, {desc="Live grep through files in the project using telescope"})




require("config.keymappings")
