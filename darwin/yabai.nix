{ pkgs, ... }:
{
  services = {
    yabai = {
      enable = true;

      package = pkgs.yabai;

      config = {
        layout = "bsp";
        auto_balane = "off";
        split_ratio = "0.50";
        window_animation_duration = "0.3";
        insert_feedback_color = "0xff9dd274";
        window_placement = "second_child";
        focus_follows_mouse = "off";
        mouse_follows_focus = "off";
        top_padding = "8";
        bottom_padding = "8";
        left_padding = "8";
        right_padding = "8";
        window_gap = "8";
        external_bar = "main:28:0";
      };
    };
  };

  #services.yabai.extraConfig = ''
  #yabai -m rule --add title = 'Preferences' manage=off layer=above
  #yabai -m rule --add title='^(Opening)' manage=off layer=above
  #yabai -m rule --add title='Library' manage=off layer=above
  #yabai -m rule --add app='^System Preferences$' manage=off layer=above
  #yabai -m rule --add app='Activity Monitor' manage=off layer=above
  #yabai -m rule --add app='Finder' manage=off layer=above
  #yabai -m rule --add app='^System Information$' manage=off layer=above}
  #'';
}
