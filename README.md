This repository contains my [nix](https://nixos.org) configurations for my macOS machines.

## Bootstrap new machine

1. Download nix

2. `make bootstrap`

## Rebuilding after configuration changes

```sh
darwin-rebuild switch --flake ${nixConfigDirectory}

# or

drs
```

set `fish` as default shell after applying flake.

```sh
make set-fish
```

### notes

- I recently changed from `coq_nvim` to `mini-nvim`. I'm not sure
  if it is as good as `coq_nvim`. I changed since `coq_nvim` broke.
  Maybe try to switch back at some point.
