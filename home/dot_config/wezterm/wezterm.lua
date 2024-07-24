local wezterm = require 'wezterm'
local config = {}

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = 'Catppuccin Frappe'
config.font = wezterm.font 'JetBrainsMono Nerd Font'

return config
