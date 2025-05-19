This repository contains my [nix](https://nixos.org) configurations for my macOS machines.

## Bootstrap new machine

1. Download nix

2. `make bootstrap`

## Rebuilding after configuration changes

```sh
sudo darwin-rebuild switch --flake ${nixConfigDirectory}

# or

drs
```

set `fish` as default shell after applying flake.

```sh
make set-fish
```

## Setting up podman

To use `podman` one must run these steps manually:

```sh
podman machine init
```

Then to start `podman` after each boot:

```sh
podman machine start
```
