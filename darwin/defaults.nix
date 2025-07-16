{
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
  networking.applicationFirewall = {
    enable = true;
    enableStealthMode = true;
    allowSignedApp = true;
    allowSigned = true;
  };

  # Dock
  system.defaults.dock = {
    autohide = true;
    expose-group-apps = false;
    mru-spaces = false;
    tilesize = 20;
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

  # Screenshots location
  system.defaults.screencapture = {
    location = "~/Pictures/Screenshots";
  };
}
