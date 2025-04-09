-- Mini is a collection of plugins, this plugin is loaded a little differently
-- than others, the init.lua will do the work of loading the "bucket" plugin
-- via lazy, then the `config` function will do the work of loading the
-- individual modules.
return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.ai').setup()
    require('mini.surround').setup()
    require('mini.files').setup({
      options = { use_as_default_explorer = false },
      mappings = { close = '<ESC>' },
    })
    require('mini.comment').setup()
  end,
  keys = { {
    '-',
    ':lua MiniFiles.open()<cr>',
    desc = 'Open mini files',
  } },
}
