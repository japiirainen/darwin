{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    icu
    zlib
    coreutils
    kitty
  ];

  programs.nix-index.enable = true;

  fonts.packages = with pkgs; [
    cozette
    julia-mono
    font-awesome_5
    uiua386
    bqn386
    nerd-fonts.meslo-lg
    nerd-fonts.fira-code
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu-mono
    nerd-fonts.victor-mono
    nerd-fonts.iosevka
    nerd-fonts.mononoki
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Add ability to use TouchID for sudo auth
  security.pam.services.sudo_local.touchIdAuth = true;

  # Store management
  nix.gc.automatic = true;
  nix.gc.interval.Hour = 3;
  nix.gc.options = "--delete-older-than 15d";
  nix.optimise.automatic = true;
  nix.optimise.interval.Hour = 4;
}
