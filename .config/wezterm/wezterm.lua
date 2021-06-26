local wezterm = require 'wezterm';

return {
  tab_bar_at_bottom = true,
  color_scheme = "Molokai",

  -- Like tmux..
  leader = { key="a", mods="CTRL", timeout_milliseconds=500 },

  keys = {
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    -- { key="a", mods="LEADER|CTRL", action=wezterm.action{SendString="\x01"} },

    -- Split panes
    -- { key="|", mods="LEADER|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}} },
    -- { key="-", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}} },

    -- { key="h", mods="CTRL", action=wezterm.action{ActivatePaneDirection="Left"} },
    -- { key="j", mods="CTRL", action=wezterm.action{ActivatePaneDirection="Down"} },
    -- { key="k", mods="CTRL", action=wezterm.action{ActivatePaneDirection="Up"} },
    -- { key="l", mods="CTRL", action=wezterm.action{ActivatePaneDirection="Right"} },
  }
}
