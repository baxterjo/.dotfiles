require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map(
  "n",
  "<leader>fg",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "telescope live grep with args" }
)
map("n", "<leader>rr", ":Telescope resume<CR>", { desc = "Telescope Resume previous picker" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Git Neogit Open" })
map("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "Git Neogit Commit" })
map("n", "<leader>gp", "<cmd>Neogit push<cr>", { desc = "Git Neogit Push" })

map("n", "<leader>dd", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Window Left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Window Down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Window Up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Window Right" })

map("i", "<C-i>", function()
  require("copilot.suggestion").toggle_auto_trigger()
end, {
  desc = "Copilot toggle",
})

map("n", "<leader>ti", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

vim.keymap.del("n", "<leader>h")

require("configs.dap").keymap()
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
