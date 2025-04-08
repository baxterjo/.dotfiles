return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local t_builtin = require('telescope.builtin')
      vim.keymap.set(
        'n',
        '<C-P>',
        t_builtin.find_files,
        { desc = 'Find files in the project using telescope' }
      )
      vim.keymap.set(
        'n',
        '<leader>fg',
        t_builtin.live_grep,
        { desc = 'Live grep through files in the project using telescope' }
      )
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      -- This is your opts table
      require('telescope').setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
        },
      })
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require('telescope').load_extension('ui-select')
    end,
  },
}
