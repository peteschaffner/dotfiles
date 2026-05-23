# dotfiles

Personal config, symlinked into place.

## Setup on a new machine

```sh
git clone git@github.com:peteschaffner/dotfiles.git ~/dotfiles
~/dotfiles/install
```

`install` symlinks everything into `~` / `~/.config`. It's safe to re-run: an
existing correct link is left alone, and any real file in the way is backed up
to `<name>.bak-<timestamp>` first.

## Layout

| Path | Symlinks to |
|------|-------------|
| `home/.zshrc`, `home/.zprofile` | `~/.zshrc`, `~/.zprofile` |
| `config/git/` | `~/.config/git/` (`config` + `ignore`; uses the XDG location, not `~/.gitconfig`) |
| `config/nvim/` | `~/.config/nvim/` |
| `config/ghostty/` | `~/.config/ghostty/` |

## Editing

Files in `~` are symlinks into this repo, so edits are live immediately — no
need to re-run `install`. To save changes:

```sh
cd ~/dotfiles && git add -A && git commit && git push
```

Run `~/dotfiles/install` again only when adding a *new* file to track.

## Notes

- The Ghostty app icon (`*.icns`) is git-ignored (large binary, optional).
- Not tracked here: `gh` (auth token), `opencode` (app state).
