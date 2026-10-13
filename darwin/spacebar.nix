{ pkgs, ... }:
{
  services.spacebar.enable = false;

  services.spacebar.package = pkgs.spacebar;

  services.spacebar.config = {
    position = "top";
    height = 28;
    title = "on";
    spaces = "on";
    power = "on";
    clock = "on";
    padding_left = 20;
    padding_right = 20;
    spacing_left = 25;
    spacing_right = 25;
    text_font = ''"Comic Code Ligatures:20.0"'';
    icon_font = ''"Font Awesome 5 Free:Solid:16.0"'';
    background_color = "0xff303446"; # Catppuccin Frappe base
    foreground_color = "0xffc6d0f5"; # text
    space_icon_color = "0xff8caaee"; # blue
    space_icon_strip = "I II III IV V VI VII VIII IX X";
    spaces_for_all_displays = "on";
    display_separator = "on";
    display_separator_icon = "|";
    clock_format = ''"%d/%m/%y %R"'';
    right_shell = "off";
    right_shell_icon = "";
    right_shell_command = "whoami";
  };
}
