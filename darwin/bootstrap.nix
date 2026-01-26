{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Nix configuration
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "auto-allocate-uids"
      "auto-allocate-uids"
    ];
    keep-outputs = true;
    keep-derivations = true;
    warn-dirty = false;
    build-users-group = "nixbld";
    builders-use-substitutes = true;
    allow-import-from-derivation = true;
    cores = 0; # `0` denotes all available cores
    extra-platforms = lib.mkIf (pkgs.stdenv.hostPlatform.system == "aarch64-darwin") [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    trusted-users = [
      "root"
      config.users.primaryUser.username
    ];

    substituters = [
      "https://cachix.org/api/v1/cache/japiirainen"
      "https://cachix.org/api/v1/cache/nix-community"
      "https://ideal.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "japiirainen.cachix.org-1:DN3k1GBybULfClDDZccSKQP4OQXFNHdliEnZHTFhhnw="
      "ideal.cachix.org-1:mZP+EJyp4LBboHqvRABbQU3AgD24Dgie3RkWP6/Yc6c="
    ];
  };

  nix.optimise.automatic = true;

  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';

  # Shells
  environment.shells = with pkgs; [
    bashInteractive
    zsh
    fish
  ];

  # Install and setup ZSH to work with nix(-darwin) as well
  programs.zsh.enable = true;

  # Make Fish the default shell
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  programs.fish.babelfishPackage = pkgs.babelfish;
  # Needed to address bug where $PATH is not properly set for fish:
  # https://github.com/LnL7/nix-darwin/issues/122
  programs.fish.shellInit = ''
    for p in (string split : ${config.environment.systemPath})
      if not contains $p $fish_user_paths
        set -g fish_user_paths $fish_user_paths $p
      end
    end
  '';

  environment.variables.SHELL = "${pkgs.fish}/bin/fish";

  system.stateVersion = 5;
}
