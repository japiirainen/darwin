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
