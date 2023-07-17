{ config, ... }: {
  programs.kitty.enable = true;

  programs.kitty.settings = {
    # font settings
    font_family = "DejaVuSansM Nerd Font Mono";
    font_size = "14.0";
    adjust_line_height = "100%";
    disable_ligatures = "cursor";

    hide_window_decorations = "titlebar-only";
    confirm_os_window_close = "100";
  };

  programs.kitty.keybindings = {
    # Open new windows and tabs
    "cmd+n" = "launch --type=os-window --cwd=current";
    "cmd+t" = "launch --type=tab --cwd=current";
    # Tab navigation
    "cmd+1" = "goto_tab 1";
    "cmd+2" = "goto_tab 2";
    "cmd+3" = "goto_tab 3";
    "cmd+4" = "goto_tab 4";
    "cmd+5" = "goto_tab 5";
    "cmd+6" = "goto_tab 6";

    # Remove line 
    "cmd+backspace" = "send_text all \\x15";
    # Move to beginning
    "cmd+left" = "send_text all \\x01";
    # Move to end
    "cmd+right" = "send_text all \\x05";
  };

  # Colors config
  programs.kitty.extras.colors = {
    enable = true;

    # Background dependent colors
    dark = config.colors.solarized-dark.pkgThemes.kitty;
    light = config.colors.solarized-light.pkgThemes.kitty;
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
