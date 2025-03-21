{ pkgs, ... }:
{
  services.jankyborders = {
    enable = true;

    package = pkgs.jankyborders;

    active_color = "0xfff5a9b8";
    inactive_color = "0xff5bcefa";
    style = "round";
    order = "above";
    width = 5.0;
  };
}
