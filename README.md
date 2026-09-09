# dotfiles

Curated backup of `~/.config` (this repo lives at `~/.config` and is
tracked in place) plus `~/.zshrc`.

## What's included

Only actual configuration is tracked. Everything else in `~/.config` is
ignored by default via `.gitignore`, which allowlists specific paths:

- **Shell/terminal**: `alacritty`, `foot`, `ghostty`, `kitty`, `tmux`,
  `starship.toml`, `.zshrc`
- **Window manager / desktop**: `hypr`, `hyprland-preview-share-picker`,
  `omarchy`, `autostart`, `systemd` (user units/enablement symlinks),
  `wireplumber`, `fcitx5`, `gtk-3.0`, `mimeapps.list`, `chromium-flags.conf`
- **Editor**: `nvim` (current LazyVim config)
- **Tools**: `git`, `lazygit`, `mise`, `btop`, `herdr`, `voxtype`,
  `opencode`, `obsidian`, `imv`, `xournalpp`

`nvim-old/` is a previous packer-based nvim config, kept for reference
but no longer in use — see `nvim/` for the active config.

## What's excluded

Browser profiles (`chromium`, `google-chrome*`, `BraveSoftware`,
`microsoft-edge*`, `mozilla`), the `Bitwarden` vault, `dconf`, `pulse`,
`ibus`, `fcitx` (state cache), `procps`, `user-dirs.dirs`, and any other
app state/cache/credentials that isn't hand-written config.

## Adding a new tool's config

Add an allowlist entry for it near the top of `.gitignore` (following
the existing pattern), then `git add` the path.
