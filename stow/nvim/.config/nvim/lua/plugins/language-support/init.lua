return {
  -- Core / Common
  require("plugins.language-support.lsp"),
  require("plugins.language-support.linting"),
  require("plugins.language-support.utils"),
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("configs.dap").setup()
    end,
  },
}
