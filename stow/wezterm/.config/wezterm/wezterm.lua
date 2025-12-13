---@diagnostic disable: unused-local

local wezterm = require('wezterm')
local act = wezterm.action

-- https://wezfurlong.org/wezterm/config/lua/wezterm/target_triple.html
local is_linux = wezterm.target_triple == 'x86_64-unknown-linux-gnu'
local font = 'JetBrains Mono'
local key_mod_panes = is_linux and 'ALT' or 'CMD'

-- Global state
local state = {
  debug_mode = false,
}

local pane_direction_map = {
  Down = 'Bottom',
  Left = 'Left',
  Right = 'Right',
  Up = 'Top',
}

local catppuccin = wezterm.color.get_builtin_schemes()['Catppuccin Mocha']

local keys = {

  {
    key = '?',
    mods = 'CMD|CTRL',
    action = wezterm.action_callback(function()
      state.debug_mode = not state.debug_mode
    end),
  },

  { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },

  {
    key = '.',
    mods = 'CMD',
    action = wezterm.action.ActivateCommandPalette,
  },

  {
    key = 'Enter',
    mods = key_mod_panes,
    action = act.ToggleFullScreen,
  },

  {
    key = ':',
    mods = key_mod_panes,
    action = act.ShowDebugOverlay,
  },

  -- Tabs
  {
    key = 't',
    mods = 'CMD',
    action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
  },

  { key = 'T', mods = 'SHIFT|' .. key_mod_panes, action = act.ShowTabNavigator },
  -- Activate Tabs
  { key = 'H', mods = 'SHIFT|' .. key_mod_panes, action = act.ActivateTabRelative(-1) },
  { key = 'L', mods = 'SHIFT|' .. key_mod_panes, action = act.ActivateTabRelative(1) },

  -- Utils

  {
    key = '0',
    mods = key_mod_panes,
    action = act.ResetFontSize,
  },
}

local process_icons = {
  ['docker'] = wezterm.nerdfonts.linux_docker,
  ['docker-compose'] = wezterm.nerdfonts.linux_docker,
  ['btm'] = '',
  ['psql'] = '󱤢',
  ['usql'] = '󱤢',
  ['kuberlr'] = wezterm.nerdfonts.linux_docker,
  ['ssh'] = wezterm.nerdfonts.fa_exchange,
  ['ssh-add'] = wezterm.nerdfonts.fa_exchange,
  ['kubectl'] = wezterm.nerdfonts.linux_docker,
  ['stern'] = wezterm.nerdfonts.linux_docker,
  ['nvim'] = wezterm.nerdfonts.custom_vim,
  ['vim'] = wezterm.nerdfonts.dev_vim,
  ['make'] = wezterm.nerdfonts.seti_makefile,
  ['node'] = wezterm.nerdfonts.mdi_hexagon,
  ['go'] = wezterm.nerdfonts.seti_go,
  ['python3'] = '',
  ['Python'] = '',
  ['zsh'] = wezterm.nerdfonts.dev_terminal,
  ['bash'] = wezterm.nerdfonts.cod_terminal_bash,
  ['htop'] = wezterm.nerdfonts.mdi_chart_donut_variant,
  ['cargo'] = wezterm.nerdfonts.dev_rust,
  ['sudo'] = wezterm.nerdfonts.fa_hashtag,
  ['lazydocker'] = wezterm.nerdfonts.linux_docker,
  ['git'] = wezterm.nerdfonts.dev_git,
  ['lua'] = wezterm.nerdfonts.seti_lua,
  ['wget'] = wezterm.nerdfonts.mdi_arrow_down_box,
  ['curl'] = wezterm.nerdfonts.mdi_flattr,
  ['gh'] = wezterm.nerdfonts.dev_github_badge,
  ['ruby'] = wezterm.nerdfonts.cod_ruby,
}

-- Colors defined here will override the Catppuccin scheme
-- For some reason the catppuccin tab colors do not propogate in the theme
local colors = {
  tab_bar = {
    background = catppuccin.tab_bar.background,
    inactive_tab_edge = catppuccin.tab_bar.inactive_tab_edge,
    active_tab = {
      bg_color = catppuccin.tab_bar.active_tab.bg_color,
      fg_color = catppuccin.tab_bar.active_tab.fg_color,
    },
    inactive_tab = {
      bg_color = catppuccin.tab_bar.inactive_tab.bg_color,
      fg_color = catppuccin.tab_bar.inactive_tab.fg_color,
    },
    inactive_tab_hover = {
      bg_color = catppuccin.tab_bar.inactive_tab_hover.bg_color,
      fg_color = catppuccin.tab_bar.inactive_tab_hover.fg_color,
    },
  },
}

-- If XDG_CURRENT_DESKTOP contains KDE or cannot be found, window_decorations = TITLE | RESIZE
-- otherwise make it compact
local window_decorations = (string.find(os.getenv('XDG_CURRENT_DESKTOP') or '', 'KDE') ~= nil)
    and 'RESIZE'
  or 'TITLE | RESIZE'

local config = {
  adjust_window_size_when_changing_font_size = false,
  audible_bell = 'Disabled',
  canonicalize_pasted_newlines = 'None',
  color_scheme = 'Catppuccin Mocha',
  colors = colors,
  command_palette_font_size = 16.0,
  cursor_blink_rate = 500,
  default_cursor_style = 'BlinkingUnderline',
  default_cwd = wezterm.home_dir,
  default_prog = { 'zsh' },
  font = wezterm.font(font, { weight = 'Regular', italic = false }),
  font_rules = {
    {
      intensity = 'Bold',
      font = wezterm.font(font, { italic = false, weight = 'Bold' }),
    },
  },
  font_size = 14.0,
  -- Disable font ligatures
  harfbuzz_features = { 'calt=1', 'clig=0', 'liga=0', 'zero', 'ss01' },
  hide_tab_bar_if_only_one_tab = true,
  hyperlink_rules = wezterm.default_hyperlink_rules(),
  keys = keys,
  max_fps = 120,
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection('PrimarySelection'),
    },

    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = act.OpenLinkAtMouseCursor,
    },
  },
  quote_dropped_files = 'Posix',
  scrollback_lines = 10000,
  send_composed_key_when_left_alt_is_pressed = false,
  set_environment_variables = {
    EDITOR = 'nvim',
  },
  show_new_tab_button_in_tab_bar = false,
  -- Nightly only
  -- show_close_tab_button_in_tabs = false,
  switch_to_last_active_tab_when_closing_tab = true,
  tab_max_width = 80,
  underline_position = -4,
  use_fancy_tab_bar = true,
  window_decorations = window_decorations,
  window_frame = {
    font = wezterm.font({ family = font }),
    font_size = 18.0,
    active_titlebar_bg = catppuccin.background,
    inactive_titlebar_bg = catppuccin.background,
  },
}

return config
