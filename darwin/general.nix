{ pkgs
, config
, ...
}:
let
  podman-az-login = pkgs.writeShellScriptBin "podman-az-login" ''
    #!/usr/bin/env bash

    set -xe

    token=$(az acr login --name adalyonimgs --expose-token --output tsv --query accessToken)
    user="00000000-0000-0000-0000-000000000000"

    podman login adalyonimgs.azurecr.io -u "$user" -p "$token"

  '';
in
{
  environment.systemPackages = with pkgs; [
    icu
    zlib
    coreutils
    # TODO: remove once unstable works again.
    pkgs-stable.kitty
    podman-az-login
  ];

  programs.nix-index.enable = true;

  fonts.packages = with pkgs; [
    cozette
    julia-mono
    font-awesome_5
    (nerdfonts.override {
      fonts = [
        "Meslo"
        "FiraCode"
        "DejaVuSansMono"
        "JetBrainsMono"
        "Terminus"
        "UbuntuMono"
        "VictorMono"
        "Iosevka"
        "Mononoki"
      ];
    })
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Add ability to use TouchID for sudo auth
  security.pam.enableSudoTouchIdAuth = true;

  # Store management
  nix.gc.automatic = true;
  nix.gc.interval.Hour = 3;
  nix.gc.options = "--delete-older-than 15d";
  nix.optimise.automatic = true;
  nix.optimise.interval.Hour = 4;
}
