{ pkgs, lib, ... }: {
  programs.bat.enable = true;
  programs.bat.config.style = "plain";

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  programs.ssh.enable = true;
  programs.ssh.controlPath = "~/.ssh/%C";

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide.enable = true;

  programs.vscode = {
    # only install vscode and extensions via nix for now
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      jnoortheen.nix-ide
      bbenoist.nix
    ];
  };

  home.packages = lib.attrValues {
    inherit (pkgs)
      tree
      ripgrep
      vim
      fd
      curl
      less
      exa
      bottom
      wget
      ;

    inherit (pkgs)
      cloc
      github-copilot-cli
      typescript
      nodejs
      ;

    agda = pkgs.agda.withPackages (ps: [ ps.standard-library ]);

    # Nix related tools
    inherit (pkgs)
      cachix
      comma
      nix-tree
      nix-update
      statix
      ;

    # npm packages
    inherit (pkgs.nodePackages)
      prettier
      ;
  };
}
