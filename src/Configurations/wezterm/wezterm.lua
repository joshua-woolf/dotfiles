local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.adjust_window_size_when_changing_font_size = false

config.audible_bell = 'Disabled'

-- config.color_scheme = 'Rosé Pine (Gogh)'
-- config.color_scheme = 'Wryan (Gogh)'

config.command_palette_bg_color = '#0000FF'

-- config.default_cwd = 'C:'

config.default_prog = { 'pwsh.exe', '-NoLogo', }

config.disable_default_key_bindings = true

config.font = wezterm.font 'CaskaydiaCove NF'

config.font_size = 14

config.force_reverse_video_cursor = true

config.hide_mouse_cursor_when_typing = true

config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.5,
}

config.initial_cols = 120

config.initial_rows = 30

config.keys = {
  { action = wezterm.action.ActivateCommandPalette,                           key = 'P',         mods = 'CTRL|SHIFT', },
  { action = wezterm.action.ActivateTabRelative(-1),                          key = '[',         mods = 'CTRL', },
  { action = wezterm.action.ActivateTabRelative(1),                           key = ']',         mods = 'CTRL', },
  { action = wezterm.action.CloseCurrentPane { confirm = false },             key = 'w',         mods = 'CTRL', },
  { action = wezterm.action.CopyTo 'Clipboard',                               key = 'C',         mods = 'CTRL|SHIFT', },
  { action = wezterm.action.DecreaseFontSize,                                 key = '-',         mods = 'CTRL', },
  { action = wezterm.action.IncreaseFontSize,                                 key = '=',         mods = 'CTRL', },
  { action = wezterm.action.PasteFrom 'Clipboard',                            key = 'V',         mods = 'CTRL|SHIFT', },
  { action = wezterm.action.PaneSelect,                                       key = 'g',         mods = 'CTRL', },
  { action = wezterm.action.QuickSelect,                                      key = ' ',         mods = 'CTRL|SHIFT', },
  { action = wezterm.action.ResetFontSize,                                    key = '0',         mods = 'CTRL', },
  { action = wezterm.action.ScrollByLine(-1),                                 key = 'UpArrow',   mods = 'SHIFT', },
  { action = wezterm.action.ScrollByLine(1),                                  key = 'DownArrow', mods = 'SHIFT', },
  { action = wezterm.action.ScrollByPage(-1),                                 key = 'PageUp',    mods = 'SHIFT', },
  { action = wezterm.action.ScrollByPage(1),                                  key = 'PageDown',  mods = 'SHIFT', },
  { action = wezterm.action.ScrollToTop,                                      key = 'UpArrow',   mods = 'CTRL|SHIFT', },
  { action = wezterm.action.ScrollToBottom,                                   key = 'DownArrow', mods = 'CTRL|SHIFT', },
  { action = wezterm.action.ShowDebugOverlay,                                 key = 'F12', },
  { action = wezterm.action.ShowLauncher,                                     key = 'L',         mods = 'CTRL|SHIFT', },
  { action = wezterm.action.ShowTabNavigator,                                 key = 'T',         mods = 'CTRL|SHIFT', },
  { action = wezterm.action.SpawnTab 'CurrentPaneDomain',                     key = 't',         mods = 'CTRL', },
  { action = wezterm.action.SpawnWindow,                                      key = 'N',         mods = 'CTRL|SHIFT', },
  { action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },   key = 'f',         mods = 'CTRL', },
  { action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, key = 'd',         mods = 'CTRL', },
  { action = wezterm.action.ToggleFullScreen,                                 key = 'F11', },
}

config.launch_menu = {
  {
    label = 'Command Prompt',
    args = { 'cmd.exe', '/k', },
  },
  {
    label = 'PowerShell',
    args = { 'pwsh.exe', '-NoLogo', },
  },
  {
    label = 'Windows PowerShell',
    args = { 'powershell.exe', '-NoLogo', },
  },
}

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = 'Right', }, },
    mods = 'NONE',
    action = wezterm.action.PasteFrom('PrimarySelection'),
  },
  {
    event = { Up = { streak = 1, button = 'Left', }, },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

config.scrollback_lines = 10000

config.unicode_version = 15

config.use_dead_keys = false

config.window_close_confirmation = 'NeverPrompt'

config.window_frame = {
  font = wezterm.font { family = 'Cascadia Code', weight = 'Regular', },
  font_size = 14,
}

return config
