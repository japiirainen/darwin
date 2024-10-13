{ config, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;
in
{
  xdg.configFile."emacs/init.el".source = mkOutOfStoreSymlink "${nixConfigDirectory}/configs/emacs/init.el";
}
