-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("Hack Nerd Font")

-- enable transparency
config.window_background_opacity = 0.4
config.text_background_opacity = 0.4
-- config.macos_window_background_blur = 10
config.native_macos_fullscreen_mode = false

-- setup toggle of top bar
config.enable_tab_bar = false

-- Key maps
config.keys = {
	{
		key = "f",
		mods = "SHIFT|CMD",
		action = wezterm.action.ToggleFullScreen,
	},
}
return config
