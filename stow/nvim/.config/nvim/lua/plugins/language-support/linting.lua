return {
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = require("configs.language-support").linters_by_ft()
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        callback = function()
          lint.try_lint()
        end,
      })

      -- vim.keymap.set("n", "<leader>ll", function()
      --   lint.try_lint()
      -- end, { desc = "Lint Current File" })
    end,
  },
}
