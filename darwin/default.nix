{
  pkgs,
  config,
  ...
}: {
  documentation.enable = false;

  environment.shells = with pkgs; [
    bashInteractive
    zsh
    fish
  ];

  environment.systemPackages = with pkgs; [coreutils];

  environment.loginShell = pkgs.fish;

  environment.systemPath = ["/opt/homebrew/bin"];

  environment.pathsToLink = ["/Applications"];

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

  # Install and setup ZSH to work with nix(-darwin) as well
  programs.zsh.enable = true;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  fonts.fontDir.enable = true; # DANGER
  fonts.fonts = [(pkgs.nerdfonts.override {fonts = ["Meslo" "FiraCode"];})];

  services.nix-daemon.enable = true;

  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {};
    casks = ["raycast"];
    taps = [];
    brews = [];
  };
}
