return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    require("neogit").setup {
      kind = "floating",
      integrations = {
        telescope = true,
        diffview = true,
      },
    }
    dofile(vim.g.base46_cache .. "git")
    dofile(vim.g.base46_cache .. "neogit")
  end,
}
