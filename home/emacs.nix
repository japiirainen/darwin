{ config, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;
in
{
  home.file.".emacs.d".source = mkOutOfStoreSymlink "${nixConfigDirectory}/configs/emacs";
}
