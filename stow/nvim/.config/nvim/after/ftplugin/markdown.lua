-- Wrap prose on screen without rewriting paragraphs while typing.
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.textwidth = 0
vim.opt_local.colorcolumn = ""
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.formatoptions:remove({ "t", "c" })

for _, key in ipairs({ "j", "k" }) do
  vim.keymap.set("n", key, function()
    return vim.v.count == 0 and "g" .. key or key
  end, { buffer = true, expr = true, silent = true, desc = "Move through wrapped prose" })
end

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
  .. " | setlocal wrap< linebreak< breakindent< textwidth< colorcolumn< spell< spelllang< formatoptions<"
  .. " | silent! nunmap <buffer> j | silent! nunmap <buffer> k"
