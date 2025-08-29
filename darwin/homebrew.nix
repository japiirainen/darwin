{ config, lib, ... }:
let
  inherit (lib) mkIf;
  brewEnabled = config.homebrew.enable;
in
{
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-fish
  # For some reason if the Fish completions are added at the end of `fish_complete_path` they don't
  # seem to work, but they do work if added at the start.
  programs.fish.interactiveShellInit = mkIf brewEnabled ''
    if test -d (brew --prefix)"/share/fish/completions"
      set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
      set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
  '';

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    # NOTE: set to `zap` once docker issue is resolved
    onActivation.cleanup = "none";
    global.brewfile = true;

    taps = [
      "koekeishiya/formulae"
    ];

    casks = [
      "google-chrome"
      "firefox"
      "1password"
      "docker"
      "pgadmin4"
      "sage"
      "raycast"
      "slack"
      "ghostty"
      "tidal"
      "whatsapp"
    ];

    brews = [
      "elan"
      "ghcup"
      "pulumi"
      "podman"
      "podman-compose"
      "sdl2"
      "portaudio"
      "cloudflared"
    ];
  };
}
