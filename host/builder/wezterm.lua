local config = require("wezterm").config_builder()
local action = require("wezterm").action
config = {
	font = wezterm.font "Fira Code Nerd Font Mono",
	color_scheme = "Tokyo Night Storm",
	enable_scroll_bar = true,
	use_ime = true,
	window_background_opacity = 0.8,
	text_background_opacity = 0.8,
	keys = {
		{
			key = "w",
			mods = "CTRL|SHIFT|ALT",
			action = action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = action.ActivatePaneDirection("Left"),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = action.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = action.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = action.ActivatePaneDirection("Right"),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT|ALT",
			action = action.AdjustPaneSize({ "Left", 1 }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT|ALT",
			action = action.AdjustPaneSize({ "Down", 1 }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT|ALT",
			action = action.AdjustPaneSize({ "Up", 1 }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = action.SpawnTab("CurrentPaneDomain"),
		},
	},
}
return config
