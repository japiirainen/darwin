{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;
in
{
  programs.neovim.enable = true;

  # Config and plugins ------------------------------------------------------------------------- {{{

  # Put neovim configuration located in this repository into place in a way that edits to the
  # configuration don't require rebuilding the `home-manager` environment to take effect.
  xdg.configFile."nvim/lua/".source = mkOutOfStoreSymlink "${nixConfigDirectory}/configs/nvim";

  # Load the `init` module from the above configs
  programs.neovim.extraConfig = "lua require('init')";

  programs.neovim.withNodeJs = true;

  programs.neovim.extras.termBufferAutoChangeDir = false;
  programs.neovim.extras.nvrAliases.enable = false;
  programs.neovim.extras.defaultEditor = true;

  programs.neovim.extraPackages = with pkgs; [
    neovim-remote
    nodePackages.bash-language-server
    shellcheck

    marksman
    nodePackages.typescript-language-server
    # Uncomment when updating inputs
    # dhall-lsp-server

    deadnix
    nixpkgs-fmt
    statix
    nil
    stylua

    nodePackages.vim-language-server
    sumneko-lua-language-server
    vscode-langservers-extracted
    yaml-language-server
    tailwindcss-language-server
    ruff-lsp

    proselint
    (agda.withPackages (p: [ p.standard-library ]))
    cornelis
  ];
}
