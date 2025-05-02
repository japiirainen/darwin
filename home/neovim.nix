{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;
in
{
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };

  # Put neovim configuration located in this repository into place in a way that edits to the
  # configuration don't require rebuilding the `home-manager` environment to take effect.
  xdg.configFile."nvim/lua/".source = mkOutOfStoreSymlink "${nixConfigDirectory}/configs/nvim";

  # Load the `init` module from the above configs
  programs.neovim.extraConfig = "lua require('init')";

  programs.neovim.plugins = [ ];

  programs.neovim.extraPackages = with pkgs; [
    nodePackages.bash-language-server
    shellcheck
    marksman
    nodePackages.typescript-language-server
    deadnix
    nixfmt-rfc-style
    statix
    nil
    stylua
    sumneko-lua-language-server
    vscode-langservers-extracted
    yaml-language-server
    tailwindcss-language-server
  ];

  xdg.configFile."zls.json".text = ''
    {
      "enable_build_on_save": true
    }
  '';
}
