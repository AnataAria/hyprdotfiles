local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'JetBrains Mono'
config.enable_tab_bar = false
config.enable_wayland = true
config.window_background_opacity = 0.6
config.text_background_opacity = 0.3
-- Spawn a fish shell in login mode
config.default_prog = { 'fish', '-l' }
return config