{
  pkgs,
  pwnvim,
  ...
}: {
  home.stateVersion = "23.05";

  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.curl
    pkgs.less
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
  };

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

  programs.kitty = {
    enable = true;
  };

  home.file.".inputrc".source = ./dotfiles/inputrc;
}
