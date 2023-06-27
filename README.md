This repository contains my nix configurations for my macOS machines.

## Bootstrap new machine

1. Download nix

2. `make bootstrap`

## Rebuilding after configuration changes

```sh
darwin-rebuild switch --flake ${nixConfigDirectory}

# or

drs
```
