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
    # Set Fish colors that aren't dependant the
    set -g fish_color_quote        cyan      # color of commands
    set -g fish_color_redirection  brmagenta # color of IO redirections
    set -g fish_color_end          blue      # color of process separators like ';' and '&'
    set -g fish_color_error        red       # color of potential errors
    set -g fish_color_match        --reverse # color of highlighted matching parenthesis
    set -g fish_color_search_match --background=yellow
    set -g fish_color_selection    --reverse # color of selected text (vi mode)
    set -g fish_color_operator     green     # color of parameter expansion operators like '*' and '~'
    set -g fish_color_escape       red       # color of character escapes like '\n' and and '\x70'
    set -g fish_color_cancel       red       # color of the '^C' indicator on a canceled command
  '';
}
