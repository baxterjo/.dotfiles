return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = function()
      local builtin = require('telescope.builtin')
      return {
        { '<C-P>', builtin.find_files, desc = 'Find files (Telescope)' },
        {
          '<leader>fg',
          builtin.live_grep,
          desc = 'Live grep (Telescope)',
        },
      }
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
