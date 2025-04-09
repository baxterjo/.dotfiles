-- Any files that do not match "plugins/*.lua" need to be required here.
return {
  require('plugins.ui.lualine'),
  require('plugins.ui.theme'),
  require('plugins.ui.noice'),
  require('plugins.language-support.lsp-config'),
  require('plugins.language-support.formatting'),
  require('plugins.language-support.none-ls'),
  require('plugins.language-support.tree-sitter'),
  require('plugins.utils.completions'),
  require('plugins.utils.git'),
  require('plugins.utils.telescope'),
  require('plugins.utils.neo-tree'),
  require('plugins.utils.trouble'),
  require('plugins.utils.which-key'),
}
