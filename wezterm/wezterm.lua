-- wezterm.lua — lives in ~/Projects/dotfiles, symlinked to ~/.config/wezterm/wezterm.lua
-- Docs: https://wezterm.org/config/files.html

local wezterm = require("wezterm")
local config = wezterm.config_builder()

----------------------------------------------------------------------
-- Appearance
----------------------------------------------------------------------

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font_with_fallback({
  { family = "JetBrainsMono Nerd Font", weight = "Medium" },
  "Menlo",
})
config.font_size = 14.0
config.line_height = 1.1

config.window_decorations = "RESIZE"
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
config.window_background_opacity = 0.97
config.macos_window_background_blur = 20

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.tab_max_width = 32

config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.7 }

----------------------------------------------------------------------
-- Window size / fullscreen
----------------------------------------------------------------------

-- Default window size in cells (defaults are 80x24)
config.initial_cols = 140
config.initial_rows = 40

-- Make Cmd+Enter fullscreen behave like the green expand button:
-- native macOS fullscreen in its own Space
config.native_macos_fullscreen_mode = true

-- Uncomment to launch straight into fullscreen:
-- wezterm.on("gui-startup", function(cmd)
--   local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
--   window:gui_window():toggle_fullscreen()
-- end)

----------------------------------------------------------------------
-- Behavior
----------------------------------------------------------------------

config.scrollback_lines = 10000
config.default_cursor_style = "SteadyBar"
config.audible_bell = "Disabled"
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false

config.front_end = "WebGpu"
config.max_fps = 120

----------------------------------------------------------------------
-- Key bindings
----------------------------------------------------------------------

local act = wezterm.action

config.keys = {
  -- Splits
  { key = "d", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "SUPER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "w", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },

  -- Navigate panes
  { key = "LeftArrow", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = "SUPER", action = act.ActivatePaneDirection("Down") },

  -- Resize panes
  { key = "LeftArrow", mods = "SUPER|CTRL", action = act.AdjustPaneSize({ "Left", 3 }) },
  { key = "RightArrow", mods = "SUPER|CTRL", action = act.AdjustPaneSize({ "Right", 3 }) },
  { key = "UpArrow", mods = "SUPER|CTRL", action = act.AdjustPaneSize({ "Up", 3 }) },
  { key = "DownArrow", mods = "SUPER|CTRL", action = act.AdjustPaneSize({ "Down", 3 }) },

  -- Zoom current pane
  { key = "Enter", mods = "SUPER|SHIFT", action = act.TogglePaneZoomState },

  -- QuickSelect: grab paths/hashes/URLs with keyboard
  { key = "Space", mods = "SUPER|SHIFT", action = act.QuickSelect },

  -- Search scrollback
  { key = "f", mods = "SUPER", action = act.Search({ CaseInSensitiveString = "" }) },

  -- Command palette
  { key = "p", mods = "SUPER|SHIFT", action = act.ActivateCommandPalette },
}

config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

----------------------------------------------------------------------
-- Mouse
----------------------------------------------------------------------

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = act.OpenLinkAtMouseCursor,
  },
}

return config
