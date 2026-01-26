{ pkgs, lib, ... }:
{
  programs.ghostty = {
    enable = true;

    # Ghostty is installed via Homebrew on macOS.
    package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin null;

    enableFishIntegration = true;

    settings = {
      font-family = "PragmataPro Liga";
      font-size = 18;

      adjust-cell-height = "10%";

      theme = "Catppuccin Macchiato";

      mouse-hide-while-typing = true;

      macos-titlebar-style = "hidden";
      macos-titlebar-proxy-icon = "hidden";
      macos-option-as-alt = true;

      copy-on-select = "clipboard";
      shell-integration-features = "cursor,sudo,no-title";

      # enable transparency
      # background-opacity = 0.80;
      # background-blur = true;
    };
  };
}
