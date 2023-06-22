{pkgs, ...}: {
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    ripgrep
    vim
    fd
    curl
    less
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";

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

  home.file.".inputrc".source = ./dotfiles/inputrc;
}
