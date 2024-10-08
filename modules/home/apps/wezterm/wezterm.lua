local wezterm = require("wezterm")
local c = wezterm.config_builder()
local utils = require("config.utils")

require("config.keys").apply(c)

c.font = wezterm.font_with_fallback({
  "Liga SFMono Nerd Font",
  -- "Cascadia Code",
  "Symbols Nerd Font",
})
c.color_scheme = 'Gruvbox dark, pale (base16)'
c.front_end = "WebGpu"
c.font_size = 13
-- c.harfbuzz_features = { "calt=1", "ss01=1" }
c.command_palette_font_size = c.font_size * 1.1
c.window_frame = {
  font = wezterm.font("IBM Plex Sans"),
}

-- c.window_background_opacity = 0.85
-- c.macos_window_background_blur = 20

c.enable_wayland = false
c.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
c.window_padding = { left = 8, right = 8, top = 12, bottom = 0 }
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.default_cursor_style = "BlinkingBar"
c.inactive_pane_hsb = { brightness = 0.90 }

-- some annoying bug is causing crashes on sway
if utils.is_darwin() then
  require("bar.plugin").apply_to_config(c)
end

c.use_fancy_tab_bar = false
c.tab_bar_at_bottom = true

-- require("milspec.plugin").apply_to_config(c, { sync = true })

-- folke/zen-mode.nvim
wezterm.on("user-var-changed", function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while number_value > 0 do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

return c
