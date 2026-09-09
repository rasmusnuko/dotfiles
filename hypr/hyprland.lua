-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Swap SUPER and ALT as Hyprland's keybinding modifiers. Physical keys keep
-- their normal meaning everywhere else (other apps, XKB) -- this only
-- rewrites the modifier name Hyprland matches against, for every bind
-- registered after this point (Omarchy defaults below, and hypr/bindings.lua).
-- Since it's a true swap (not a one-way rename), every existing combo that
-- already uses SUPER, ALT, or both keeps working with no new collisions --
-- e.g. former SUPER+Q is now ALT+Q, former ALT+TAB is now SUPER+TAB, and
-- former SUPER+ALT+F still needs both keys together.
local function swap_super_alt_keys(keys)
  local tokens = {}
  for raw_token in keys:gmatch("[^+]+") do
    local token = raw_token:match("^%s*(.-)%s*$")
    local lower = token:lower()
    if lower == "super" then
      token = "ALT"
    elseif lower == "alt" then
      token = "SUPER"
    end
    table.insert(tokens, token)
  end
  return table.concat(tokens, " + ")
end

local real_hl_bind = hl.bind
hl.bind = function(keys, dispatcher, opts)
  return real_hl_bind(swap_super_alt_keys(keys), dispatcher, opts)
end

local real_hl_unbind = hl.unbind
hl.unbind = function(keys)
  return real_hl_unbind(swap_super_alt_keys(keys))
end

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })
