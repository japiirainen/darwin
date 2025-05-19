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
        # external_bar = "main:28:0";
      };
    };
  };
}
