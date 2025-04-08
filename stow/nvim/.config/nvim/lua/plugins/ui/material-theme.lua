return {

  'marko-cerovac/material.nvim',

  config = function()
    local material = require('material')
    vim.g.material_style = 'palenight'

    material.setup({
      contrast = {
        cursor_line = true,
        sidebars = true,
        lsp_virtual_text = true,
      },
      disable = {
        eob_lines = true,
      },
      styles = {
        comments = { italic = true },
        functions = { italic = true },
      },
      plugins = {
        'flash',
        'telescope',
        'noice',
        'nvim-cmp',
        'nvim-web-devicons',
        'nvim-notify',
        'gitsigns',
        'neogit',
        'neorg',
        'noice',
        'dap',
        'mini',
      },
      lualine_style = 'stealth',
    })

    vim.cmd('colorscheme material')
  end,
}
