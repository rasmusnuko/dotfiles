# Split ergo keyboard + home-row mods

Reference notes from investigating whether/how to support a split ergo
board (home-row mods: `f`=Win, `d`=Alt, `a`=Shift, `z`=Ctrl, held) and a
standard keyboard side by side. Nothing here is applied yet — this is
just what we found, to act on later if needed.

## Where home-row mods actually live

Home-row mods are implemented in the keyboard's own firmware (QMK/ZMK)
or a host-side remapper (kanata, keyd) — **not** in Hyprland. Neither
kanata nor keyd is installed on this machine, so the mods are firmware
side on the board itself.

By the time a held `f` reaches Hyprland, it's already a plain Left-GUI
keycode — indistinguishable from a normal keyboard's physical Super
key. **This means `hypr/bindings.lua` already works identically on
both keyboards with zero duplication** — nothing to configure in
Hyprland just to "make Super/Alt/etc. work" with the split board.

## Tuning the home-row mods themselves (firmware side)

Not done here (lives in the board's QMK/ZMK config, outside
`~/.config`), but for reference, the main failure mode people hit is
**misfires during fast typing**: two same-hand letters rolled quickly
get misread as a hold, firing a modifier (or a whole WM shortcut)
instead of typing the letters. Since all four mods here (`f d a z`)
are on one hand, same-hand rolls between any of them and nearby
letters are exactly the case to guard against.

Fixes, roughly newest/best to older/simpler:

- **Chordal Hold** (ZSA's newer QMK feature) — current best practice
  for home-row mods specifically. Resolves a hold based on which hand
  the *next* key comes from: opposite-hand key → hold fires instantly;
  same-hand key → treated as a roll, stays a tap.
- **Permissive Hold** (older, still common) — same idea, cruder. Needs
  a fairly high tapping term (~200–250ms) to avoid misfires.
- **Tapping term**: 160–220ms is the typical sweet spot (200ms is
  QMK's default), tunable per key. Worth giving Win/Super a more
  deliberate hold specifically since it's used constantly for WM
  shortcuts and a misfire is disruptive mid-sentence.
- **Achordion** (community QMK mod by getreuer) — alternative,
  more customizable tap/hold decision engine.
- **ZMK**: the popular pattern is "timeless home row mods" — separate
  hold-tap behaviors defined per hand, reducing dependence on precise
  timing.

Sources:
- https://precondition.github.io/home-row-mods
- https://blog.zsa.io/chordal-hold/
- https://docs.qmk.fm/tap_hold
- https://getreuer.info/posts/keyboards/achordion/index.html
- https://sunaku.github.io/home-row-mods.html
- https://zmk.dev/docs/keymaps/behaviors/hold-tap

## Diverging actual shortcuts per keyboard (Hyprland side)

Separate from the mods themselves: what *feels* good as a chord on a
split board with layers/thumb keys may be awkward to reach on a 60%
with no layers. Hyprland (via this config's Lua layer) supports
scoping a bind to a specific physical keyboard, so both a
split-friendly and a 60%-friendly binding for the same action can
coexist — Hyprland picks the right one based on which device sent the
keypress, no manual mode-switching.

Every `o.bind()` call takes an options table as its last argument,
which supports a `device` field:

```lua
device? = { inclusive?: boolean, list?: string[] }
```

Usage sketch:

```lua
-- 1. Find each keyboard's exact device name:
--      hyprctl devices
--
-- 2. Bind the same logical action twice, each scoped to one device:
o.bind("SUPER + H", "Some action (split board)", action,
  { device = { list = { "my-split-keyboard-name" } } })
o.bind("SUPER + CTRL + H", "Same action (60%)", action,
  { device = { list = { "my-60-percent-name" } } })
```

`list` takes the exact device name(s) from `hyprctl devices`.
`inclusive` (default true) flips to "every device except these" for
the opposite case — one binding scoped to the split board, a fallback
scoped to exclude it.

Not set up yet — revisit if a specific chord actually turns out to be
uncomfortable on one board or the other.
