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
    onActivation.cleanup = "zap";
    global.brewfile = true;

    taps = [
      "koekeishiya/formulae"
    ];

    masApps = {
      Slack = 803453959;
    };

    casks = [
      "raycast"
      "google-chrome"
      "qutebrowser"
      "notion"
      "spotify"
      "miro"
      "zoom"
      "firefox"
      "1password"
      "docker"
      "microsoft-teams"
      "pgadmin4"
      "thunderbird"
    ];

    brews = [
      "skhd"
      "elan"
      "ghcup"
      "pulumi"
      "podman"
      "podman-compose"
      "swiftformat"
    ];
  };
}
