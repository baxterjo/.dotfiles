require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open (Neogit)" })
map("n", "<leader>gd", "<cmd>Neogit diff<cr>", { desc = "Diff (Neogit)" })
map("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "Commit (Neogit)" })
map("n", "<leader>gp", "<cmd>Neogit push<cr>", { desc = "Push (Neogit)" })

vim.keymap.del("n", "<leader>h")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
