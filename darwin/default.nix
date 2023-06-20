{pkgs, ...}: {
  documentation.enable = false;

  users.users.japiirainen.home = "/Users/japiirainen";

  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [bash zsh];

    loginShell = pkgs.zsh;

    systemPackages = with pkgs; [coreutils];

    systemPath = ["/opt/homebrew/bin"];

    pathsToLink = ["/Applications"];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  fonts.fontDir.enable = true; # DANGER
  fonts.fonts = [(pkgs.nerdfonts.override {fonts = ["Meslo"];})];

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

  # backwards compat; don't change
  system.stateVersion = 4;
}
