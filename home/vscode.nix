{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-marketplace; [
        dracula-theme.theme-dracula
        jnoortheen.nix-ide
        vscodevim.vim
        leanprover.lean4
        github.copilot
        github.copilot-chat
      ];

      userSettings = {
        "workbench.colorTheme" = "Dracula Theme";

        "editor.fontFamily" = "Comic Code Ligatures";
        "editor.fontSize" = 15;
        "vim.insertModeKeyBindings" = [
          {
            "before" = [
              "j"
              "k"
            ];
            "after" = [ "<Esc>" ];
          }
        ];
      };
    };
  };
}
