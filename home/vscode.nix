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

        "editor.fontFamily" = "CommitMono Nerd Font Mono";
        "editor.fontSize" = 13;
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
