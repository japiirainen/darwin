{ ... }:
{
  programs.helix.enable = true;
  programs.helix.settings = {
    theme = "dark_plus";
    editor = {
      line-number = "relative";
      lsp.display-messages = true;
    };
    keys.insert = {
      j = {
        k = "normal_mode";
      };
    };
  };
}
