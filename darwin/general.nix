{ pkgs
, config
, ...
}: {
  # Nix configuration
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    keep-derivations = true;

    keep-outputs = true;

    cores = 8;

    trusted-users = [ "root" config.users.primaryUser.username ];

    auto-optimise-store = true;
  };

  nix.settings.substituters = [
    "https://cachix.org/api/v1/cache/japiirainen"
    "https://cachix.org/api/v1/cache/nix-community"
  ];

  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "japiirainen.cachix.org-1:DN3k1GBybULfClDDZccSKQP4OQXFNHdliEnZHTFhhnw="
  ];

  services.nix-daemon.enable = true;

  nix.configureBuildUsers = true;

  # Remove this when it stops breaking builds..
  documentation.enable = false;

  environment.shells = with pkgs; [
    bashInteractive
    zsh
    fish
  ];

  environment.systemPackages = with pkgs; [
    coreutils
    kitty
  ];

  programs.nix-index.enable = true;

  environment.loginShell = pkgs.fish;

  environment.systemPath = [ "/opt/homebrew/bin" ];

  environment.pathsToLink = [ "/Applications" ];

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

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    font-awesome_5
    (nerdfonts.override { fonts = [ "Meslo" "FiraCode" ]; })
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Add ability to use TouchID for sudo auth
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.NSGlobalDomain = {
    "com.apple.trackpad.scaling" = 2.0;
    AppleShowAllExtensions = true;
    AppleInterfaceStyle = "Dark";
    AppleInterfaceStyleSwitchesAutomatically = false;
    AppleMeasurementUnits = "Centimeters";
    AppleMetricUnits = 1;
    AppleShowScrollBars = "Automatic";
    AppleTemperatureUnit = "Celsius";
    InitialKeyRepeat = 14;
    KeyRepeat = 1;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    _HIHideMenuBar = true;
  };

  # Firewall
  system.defaults.alf = {
    globalstate = 1;
    allowsignedenabled = 1;
    allowdownloadsignedenabled = 1;
    stealthenabled = 1;
  };

  # Dock
  system.defaults.dock = {
    autohide = true;
    expose-group-by-app = false;
    mru-spaces = false;
    tilesize = 100;
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };

  # Finder
  system.defaults.finder = {
    AppleShowAllExtensions = true;
    _FXShowPosixPathInTitle = true;
  };

  system.stateVersion = 4;
}
