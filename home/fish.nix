{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) elem optionalString;
  inherit (config.home.user-info) nixConfigDirectory;
in
{
  programs.fish.enable = true;

  home.packages = with pkgs; [ fishPlugins.done ];

  programs.fish.functions = {

    setup-atuin = {
      body = ''
        atuin init fish | source
      '';
    };

    # Sets Fish Shell to light or dark colorscheme based on `$term_background`.
    set-shell-colors = {
      body =
        optionalString config.programs.bat.enable ''
          # Use correct theme for `bat`.
          set -xg BAT_THEME "ansi"
        ''
        + optionalString (elem pkgs.bottom config.home.packages) ''
          # Use correct theme for `btm`.
          if test "$term_background" = light
            alias btm "btm --color default-light"
          else
            alias btm "btm --color default"
          end
        '';
      onVariable = "term_background";
    };
  };

  # Fish configuration

  # Aliases

  programs.fish.shellAliases = with pkgs; {
    drb = "darwin-rebuild build --flake ${nixConfigDirectory}";
    drs = "darwin-rebuild switch --flake ${nixConfigDirectory}";
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
    ${pkgs.thefuck}/bin/thefuck --alias | source
    setup-atuin
    # Run function to set colors that are dependant on `$term_background` and to register them so
    # they are triggerd when the relevent event happens or variable changes.
    set-shell-colors
    # Set Fish colors that aren't dependant the `$term_background`.
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
    nerdfetch
  '';
}
