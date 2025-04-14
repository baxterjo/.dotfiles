require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Git Neogit Open" })
map("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "Git Neogit Commit" })
map("n", "<leader>gp", "<cmd>Neogit push<cr>", { desc = "Git Neogit Push" })
map("n", "<leader>ti", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

vim.keymap.del("n", "<leader>h")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
