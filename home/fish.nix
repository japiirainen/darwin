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
        # Rosé Pine directory listings.
        set -xg LS_COLORS (${pkgs.vivid}/bin/vivid generate rose-pine)
      ''
      + optionalString config.programs.bat.enable ''
        # Use correct theme for `bat`.
        set -xg BAT_THEME "rose-pine"
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
    # Rosé Pine shell highlighting.
    set -g fish_color_normal       e0def4
    set -g fish_color_command      9ccfd8
    set -g fish_color_param        e0def4
    set -g fish_color_comment      6e6a86
    set -g fish_color_autosuggestion 6e6a86
    set -g fish_color_quote        f6c177
    set -g fish_color_redirection  c4a7e7
    set -g fish_color_end          ebbcba
    set -g fish_color_error        eb6f92
    set -g fish_color_match        --reverse
    set -g fish_color_search_match e0def4 --background=403d52
    set -g fish_color_selection    e0def4 --background=403d52
    set -g fish_color_operator     31748f
    set -g fish_color_escape       ebbcba
    set -g fish_color_cancel       eb6f92
    set -g fish_color_valid_path   --underline
    set -g fish_pager_color_progress 908caa
    set -g fish_pager_color_prefix  9ccfd8
    set -g fish_pager_color_completion e0def4
    set -g fish_pager_color_description 908caa
    set -g fish_pager_color_selected_background --background=403d52
  '';
}
