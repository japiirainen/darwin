pwnvim:

{
  pkgs,
  ...
}: {
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    ripgrep
    fd
    curl
    less
    pwnvim.packages."aarch64-darwin".default
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.exa.enable = true;

  programs.git.enable = true;
  programs.git = {
    userEmail = "joona.piirainen@gmail.com";
    ignores = [".DS_Store"];
    userName = "japiirainen";
    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      pl = "pull";
      ps = "push";
      aa = "add -A";
      upd = "! git pull && git submodule update --recursive";
    };
    # Enhanced diffs
    delta.enable = true;
  };

  programs.gh.enable = true;

  programs.zsh.enable = true;
  programs.zsh = {
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ls = "ls --color=auto -F";
      nixswitch = "darwin-rebuild switch --flake ~/dev/darwin/.#";
      nixup = "pushd ~/dev/darwin; nix flake update; nixswitch";
    };
  };

  home.file.".inputrc".source = ./dotfiles/inputrc;
}
