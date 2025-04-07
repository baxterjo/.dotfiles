local wezterm = require("wezterm")
local act = wezterm.action
return {
	{
		key = ',',
		mods = 'CMD',
		action = act.PromptInputLine({
			description = 'Launch',
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(
						act.SpawnCommandInNewWindow({
							args = wezterm.shell_split(line),
						}),
						pane
					)
				end
			end),
		}),
	},

	{
		key = '?',
		mods = 'CMD|CTRL',
		action = wezterm.action_callback(function()
			state.debug_mode = not state.debug_mode
		end),
	},

	{ key = 'PageUp',   mods = 'SHIFT', action = act.ScrollByPage(-1) },
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

	-- Panes
	{
		key = 'p',
		mods = 'LEADER',
		action = act.ActivateKeyTable({
			name = 'pane',
			timeout_milliseconds = 1500,
		}),
	},
	{
		key = 'd',
		mods = key_mod_panes,
		action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
	},
	{
		key = 'D',
		mods = 'SHIFT|' .. key_mod_panes,
		action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
	},

	{
		key = 'w',
		mods = key_mod_panes,
		action = act.CloseCurrentPane({ confirm = true }),
	},

	{
		key = 'W',
		mods = key_mod_panes .. '|SHIFT',
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},

	{
		key = 'z',
		mods = key_mod_panes,
		action = act.TogglePaneZoomState,
	},

	{
		key = '!',
		mods = 'SHIFT|' .. key_mod_panes,
		action = wezterm.action_callback(function(_win, pane)
			pane:move_to_new_window()
		end),
	},

	-- Activation
	pane_activate_create({
		key = 'h',
		mods = key_mod_panes,
		direction = 'Left',
	}),

	pane_activate_create({
		key = 'l',
		mods = key_mod_panes,
		direction = 'Right',
	}),

	pane_activate_create({
		key = 'k',
		mods = key_mod_panes,
		direction = 'Up',
	}),

	pane_activate_create({
		key = 'j',
		mods = key_mod_panes,
		direction = 'Down',
	}),

	-- Size
	{
		key = 'H',
		mods = 'SHIFT|' .. key_mod_panes,
		action = act.AdjustPaneSize({ 'Left', 1 }),
	},

	{
		key = 'J',
		mods = 'SHIFT|' .. key_mod_panes,
		action = act.AdjustPaneSize({ 'Down', 1 }),
	},

	{
		key = 'K',
		mods = 'SHIFT|' .. key_mod_panes,
		action = act.AdjustPaneSize({ 'Up', 1 }),
	},

	{
		key = 'L',
		mods = 'SHIFT|' .. key_mod_panes,
		action = act.AdjustPaneSize({ 'Right', 1 }),
	},

	-- Rotate
	{
		key = 'r',
		mods = key_mod_panes,
		action = act.RotatePanes('CounterClockwise'),
	},

	{
		key = 'R',
		mods = 'SHIFT|CMD',
		action = act.RotatePanes('Clockwise'),
	},

	-- Select and focus
	{
		key = 's',
		mods = key_mod_panes,
		action = act.PaneSelect,
	},

	-- Select and swap
	{
		key = 'S',
		mods = 'SHIFT|' .. key_mod_panes,
		action = act.PaneSelect({
			mode = 'SwapWithActive',
		}),
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
	{
		key = 'o',
		mods = key_mod_panes,
		action = act.ActivateLastTab,
	},

	-- Swap Tabs
	{ key = 'H', mods = 'SHIFT|CTRL|' .. key_mod_panes, action = act.MoveTabRelative(-1) },
	{ key = 'L', mods = 'SHIFT|CTRL|' .. key_mod_panes, action = act.MoveTabRelative(1) },

	-- Utils

	{
		key = '0',
		mods = key_mod_panes,
		action = act.ResetFontSize,
	},

	{
		key = 'v',
		mods = 'SHIFT|' .. key_mod_panes,
		action = act.ActivateCopyMode,
	},

	{
		key = 'L',
		mods = 'CTRL|SHIFT',
		action = act.QuickSelectArgs({
			patterns = {
				'https?://\\S+',
			},
		}),
	},
	{
		key = 'L',
		mods = 'CMD|SHIFT',
		action = act.QuickSelectArgs({
			patterns = {
				'https?://\\S+',
			},
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.open_with(url)
			end),
		}),
	},

	-- Jump word to the left
	{
		key = 'LeftArrow',
		mods = 'OPT',
		action = act.SendKey({
			key = 'b',
			mods = 'ALT',
		}),
	},

	-- Jump word to the right
	{
		key = 'RightArrow',
		mods = 'OPT',
		action = act.SendKey({ key = 'f', mods = 'ALT' }),
	},

	-- Go to beginning of line
	{
		key = 'LeftArrow',
		mods = 'CMD',
		action = act.SendKey({
			key = 'a',
			mods = 'CTRL',
		}),
	},

	-- Go to end of line
	{
		key = 'RightArrow',
		mods = 'CMD',
		action = act.SendKey({ key = 'e', mods = 'CTRL' }),
	},

	-- Bypass
	{ key = '/', mods = 'CTRL', action = act.SendKey({ key = '/', mods = 'CTRL' }) },
	{ key = 'q', mods = 'CTRL', action = act.SendKey({ key = 'q', mods = 'CTRL' }) },
	{ key = 'k', mods = 'CTRL', action = act.SendKey({ key = 'k', mods = 'CTRL' }) },
	{ key = 'i', mods = 'CTRL', action = act.SendKey({ key = 'i', mods = 'CTRL' }) },
}
