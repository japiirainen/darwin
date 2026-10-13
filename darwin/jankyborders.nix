{ pkgs, ... }:
{
  services.jankyborders = {
    enable = true;

    package = pkgs.jankyborders;

    active_color = "0xfff4b8e4"; # Catppuccin Frappe pink
    inactive_color = "0xff99d1db"; # sky
    style = "round";
    order = "above";
    width = 5.0;
  };
}
