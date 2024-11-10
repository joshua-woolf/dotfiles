local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.adjust_window_size_when_changing_font_size = false

config.audible_bell = 'Disabled'

config.command_palette_bg_color = '#0000FF'

config.disable_default_key_bindings = true

config.font = wezterm.font 'Cascadia Code NF'

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
  { action = wezterm.action.ActivateCommandPalette,                           key = 'P',         mods = 'CMD|SHIFT', },
  { action = wezterm.action.ActivateTabRelative(-1),                          key = '[',         mods = 'CMD', },
  { action = wezterm.action.ActivateTabRelative(1),                           key = ']',         mods = 'CMD', },
  { action = wezterm.action.CloseCurrentPane { confirm = false },             key = 'w',         mods = 'CMD', },
  { action = wezterm.action.CopyTo 'Clipboard',                               key = 'C',         mods = 'CMD|SHIFT', },
  { action = wezterm.action.DecreaseFontSize,                                 key = '-',         mods = 'CMD', },
  { action = wezterm.action.IncreaseFontSize,                                 key = '=',         mods = 'CMD', },
  { action = wezterm.action.PasteFrom 'Clipboard',                            key = 'V',         mods = 'CMD|SHIFT', },
  { action = wezterm.action.PaneSelect,                                       key = 'g',         mods = 'CMD', },
  { action = wezterm.action.QuickSelect,                                      key = ' ',         mods = 'CMD|SHIFT', },
  { action = wezterm.action.ResetFontSize,                                    key = '0',         mods = 'CMD', },
  { action = wezterm.action.ScrollByLine(-1),                                 key = 'UpArrow',   mods = 'CMD', },
  { action = wezterm.action.ScrollByLine(1),                                  key = 'DownArrow', mods = 'CMD', },
  { action = wezterm.action.ScrollByPage(-1),                                 key = 'PageUp',    mods = 'CMD', },
  { action = wezterm.action.ScrollByPage(1),                                  key = 'PageDown',  mods = 'CMD', },
  { action = wezterm.action.ScrollToTop,                                      key = 'UpArrow',   mods = 'CMD|SHIFT', },
  { action = wezterm.action.ScrollToBottom,                                   key = 'DownArrow', mods = 'CMD|SHIFT', },
  { action = wezterm.action.ShowDebugOverlay,                                 key = 'F12', },
  { action = wezterm.action.ShowLauncher,                                     key = 'L',         mods = 'CMD|SHIFT', },
  { action = wezterm.action.ShowTabNavigator,                                 key = 'T',         mods = 'CMD|SHIFT', },
  { action = wezterm.action.SpawnTab 'CurrentPaneDomain',                     key = 't',         mods = 'CMD', },
  { action = wezterm.action.SpawnWindow,                                      key = 'N',         mods = 'CMD|SHIFT', },
  { action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },   key = 'f',         mods = 'CMD', },
  { action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, key = 'd',         mods = 'CMD', },
  { action = wezterm.action.ToggleFullScreen,                                 key = 'F11', },
}

config.launch_menu = {
  {
    label = 'PowerShell',
    args = { '/usr/local/bin/pwsh', '-NoLogo', },
  }
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
