-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Power button: lock the screen instead of opening the power menu
-- (power menu is still reachable via CTRL+ALT+P).
hl.unbind("XF86PowerOff")
o.bind("XF86PowerOff", "Lock screen (power button)", "omarchy-system-lock", { locked = true })

-- Firefox on SUPER+while
hl.unbind("SUPER + w")
o.bind("SUPER + w", nil, "firefox")

-- Close on SUPER+q
o.bind("SUPER + q", "Close window", hl.dsp.window.close())

-- Move keybindings overview from SUPER+K to SUPER+SHIFT+K
hl.unbind("SUPER + K")
o.bind("SUPER + SHIFT + K", "Keybindings", "omarchy-menu-keybindings")

-- Free up SUPER+J and SUPER+L for vim-style window navigation below
-- (was: Toggle window split / Toggle workspace layout)
hl.unbind("SUPER + J")
o.bind("SUPER + ALT + J", "Toggle window split", hl.dsp.layout("togglesplit"))
hl.unbind("SUPER + L")
o.bind("SUPER + ALT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

-- New terminals always open at $HOME instead of following the focused
-- terminal's cwd -- skips the omarchy-cmd-terminal-cwd lookup (~120ms).
hl.unbind("SUPER + RETURN")
local open_terminal_at_home = o.launch('xdg-terminal-exec --dir="$HOME"')
o.bind("SUPER + RETURN", "Terminal", open_terminal_at_home)
o.bind("SUPER + E", "Terminal (Alt+E)", open_terminal_at_home)

-- Vim-style (hjkl) focus navigation between windows
o.bind("SUPER + H", "Focus on left window (vim)", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Focus on below window (vim)", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Focus on above window (vim)", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Focus on right window (vim)", hl.dsp.focus({ direction = "r" }))

-- NOTE: hyprland.lua swaps SUPER<->ALT for every bind registered after it, so
-- from here on writing "ALT" in a keys string is what lands on the physical
-- Windows/Super key. Everything below is intentionally "ALT" for that reason.

-- Windows key + HJKL sends plain arrow keys to the focused app (not window
-- focus -- that's already vim-bound above on the physical Alt key).
local function send_key_once(key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = "", key = key, state = "down" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = "", key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

o.bind("ALT + H", "Left arrow (Windows+H)", send_key_once("LEFT"))
o.bind("ALT + J", "Down arrow (Windows+J)", send_key_once("DOWN"))
o.bind("ALT + K", "Up arrow (Windows+K)", send_key_once("UP"))
o.bind("ALT + L", "Left arrow (Windows+L)", send_key_once("LEFT"))

-- Windows key + Shift + S: drag-to-select screenshot (region mode, like
-- Windows' own Win+Shift+S). Saves to file, copies to clipboard, and offers
-- an edit shortcut via notification -- same as the default screenshot flow.
o.bind("ALT + SHIFT + S", "Screenshot (region, Windows+Shift+S)", "omarchy-capture-screenshot region")

-- Windows key + Shift + L: lock the screen (like Windows' own Win+L).
o.bind("ALT + SHIFT + L", "Lock screen (Windows+Shift+L)", "omarchy-system-lock")

-- Windows key + V: clipboard history (Omarchy's built-in clipboard manager,
-- already bound to CTRL+ALT+V by default -- this just adds Windows+V too).
o.bind("ALT + V", "Clipboard manager (Windows+V)", "omarchy-shell shell toggle omarchy.clipboard")
