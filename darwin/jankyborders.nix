{ pkgs, ... }:
{
  services.jankyborders = {
    enable = true;

    package = pkgs.jankyborders;

    active_color = "0xffebbcba"; # Rosé Pine rose
    inactive_color = "0xff403d52"; # highlight med
    style = "round";
    order = "above";
    width = 5.0;
  };
}
