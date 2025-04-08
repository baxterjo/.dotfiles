return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed.
      'nvim-telescope/telescope.nvim', -- optional
      'ibhagwan/fzf-lua', -- optional
      'echasnovski/mini.pick', -- optional
    },
    opts = {},
  },
  {
    'lewis6991/gitsigns.nvim',

    config = function()
      require('gitsigns').setup({ current_line_blame = true })
      vim.keymap.set(
        'n',
        '<leader>gp',
        ':Gitsigns preview_hunk<CR>',
        { desc = 'Preview change git change' }
      )
    end,
  },
}
