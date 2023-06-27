my macos configuration

## Bootstrap new machine

1. Download nix

2. `make bootstrap`

## Rebuilding after configuration changes

```sh
darwin-rebuild switch --flake ${nixConfigDirectory}

# or

drs
```
