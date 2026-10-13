{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionalString;
  inherit (config.home.user-info) nixConfigDirectory;
in
{
  programs.fish.enable = true;

  home.packages = [ ];

  programs.fish.functions = {
    set-shell-colors = {
      body = ''
        # Set LS_COLORS
        set -xg LS_COLORS (${pkgs.vivid}/bin/vivid generate catppuccin-frappe)
      ''
      + optionalString config.programs.bat.enable ''
        # Use correct theme for `bat`.
        set -xg BAT_THEME "Catppuccin Frappe"
      '';
    };
  };

  # Fish configuration

  # Aliases

  programs.fish.shellAliases = with pkgs; {
    drb = "sudo darwin-rebuild build --flake ${nixConfigDirectory}";
    drs = "sudo darwin-rebuild switch --flake ${nixConfigDirectory}";
    flakeup = "nix flake update --flake ${nixConfigDirectory}";
    vimconf = "nvim ${nixConfigDirectory}/configs/nvim/init.lua";
    nb = "nix build";
    nd = "nix develop";
    nf = "nix flake";
    nr = "nix run";
    ns = "nix search";
    ".." = "cd ..";
    la = "ll -a";
    ll = "ls -lah --time-style long-iso --icons";
    ls = "${eza}/bin/eza";
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    cat = "bat";
    top = "btop";
  };

  programs.fish.interactiveShellInit = ''
    set -g fish_greeting ""
    set -xg PNPM_HOME /Users/jp-work/Library/pnpm
    fish_add_path /Users/jp-work/Library/pnpm
    set-shell-colors
    # Catppuccin Frappe
    set -g fish_color_normal       c6d0f5
    set -g fish_color_command      8caaee
    set -g fish_color_param        eebebe
    set -g fish_color_comment      737994
    set -g fish_color_autosuggestion 737994
    set -g fish_color_quote        a6d189
    set -g fish_color_redirection  f4b8e4
    set -g fish_color_end          ef9f76
    set -g fish_color_error        e78284
    set -g fish_color_match        --reverse # color of highlighted matching parenthesis
    set -g fish_color_search_match f2d5cf --background=414559
    set -g fish_color_selection    c6d0f5 --background=414559
    set -g fish_color_operator     f4b8e4
    set -g fish_color_escape       ea999c
    set -g fish_color_cancel       e78284
    set -g fish_color_valid_path   --underline
    set -g fish_pager_color_progress 737994
    set -g fish_pager_color_prefix  f4b8e4
    set -g fish_pager_color_completion c6d0f5
    set -g fish_pager_color_description 737994
    set -g fish_pager_color_selected_background --background=414559
  '';
}
