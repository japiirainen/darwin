{config, ...}: {
  programs.kitty = {
    enable = true;

    settings = {
      # font settings
      font_family = "FiraCode Nerd Font Mono";
      font_size = "14.0";
      adjust_line_height = "100%";
      disable_ligatures = "cursor";
    };

    # Colors config
    extras.colors = {
      enable = true;

      # Background dependent colors
      dark = config.colors.solarized-dark.pkgThemes.kitty;
      light = config.colors.solarized-light.pkgThemes.kitty;
    };
  };
  programs.fish.functions.set-term-colors = {
    body = "term-background $term_background";
    onVariable = "term_background";
  };

  programs.fish.interactiveShellInit = ''
    # Set term colors based on value of `$term_backdround` when shell starts up.
    set-term-colors
  '';
}
