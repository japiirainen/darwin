{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;
in
{
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;
  programs.neovim.withRuby = false;
  programs.neovim.withPython3 = false;

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
    bash-language-server
    shellcheck
    marksman
    typescript-language-server
    deadnix
    nixfmt
    statix
    nil
    stylua
    lua-language-server
    vscode-langservers-extracted
    yaml-language-server
    tailwindcss-language-server
    tree-sitter
  ];

  xdg.configFile."zls.json".text = ''
    {
      "enable_build_on_save": true
    }
  '';
}
