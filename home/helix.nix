{ ... }:
{
  programs.helix.enable = true;
  programs.helix.settings = {
    theme = "catppuccin_frappe";
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
