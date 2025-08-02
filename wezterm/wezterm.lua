-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}
config.window_close_confirmation = "AlwaysPrompt"

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("0xProto", {
	weight = "Medium",
})
config.font_size = 14
config.line_height = 1

-- enable transparency
config.window_background_opacity = 0.6
config.text_background_opacity = 0.4

config.window_padding = { left = 12, bottom = 0, top = 12, right = 0 }

-- config.macos_window_background_blur = 10
config.native_macos_fullscreen_mode = false

-- setup toggle of top bar
config.enable_tab_bar = false

-- allow international keyboard input
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- Key maps
config.keys = {
	{
		key = "f",
		mods = "SHIFT|CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config
