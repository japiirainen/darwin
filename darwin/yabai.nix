{ pkgs, ... }:
{
  services.yabai.enable = true;

  services.yabai.package = pkgs.yabai;

  services.yabai.config = {
    layout = "bsp";
    auto_balane = "off";
    split_ratio = "0.50";
    window_border = "off";
    window_border_width = "2";
    window_placement = "second_child";
    focus_follows_mouse = "autoraise";
    mouse_follows_focus = "off";
    top_padding = "10";
    bottom_padding = "10";
    left_padding = "10";
    right_padding = "10";
    window_gap = "10";
  };

  services.yabai.extraConfig = ''
    yabai -m rule --add title = 'Preferences' manage=off layer=above
    yabai -m rule --add title='^(Opening)' manage=off layer=above
    yabai -m rule --add title='Library' manage=off layer=above
    yabai -m rule --add app='^System Preferences$' manage=off layer=above
    yabai -m rule --add app='Activity Monitor' manage=off layer=above
    yabai -m rule --add app='Finder' manage=off layer=above
    yabai -m rule --add app='^System Information$' manage=off layer=above}
  '';
}
