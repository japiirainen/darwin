{config, ...}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;
in
{
  programs.neovim.enable = true;

  # Config and plugins ------------------------------------------------------------------------- {{{

  # Put neovim configuration located in this repository into place in a way that edits to the
  # configuration don't require rebuilding the `home-manager` environment to take effect.
  xdg.configFile."nvim/lua/nvim.lua".source = mkOutOfStoreSymlink "${nixConfigDirectory}/configs/nvim.lua";

  # Load the `init` module from the above configs
  programs.neovim.extraConfig = "lua require('nvim')";
}
