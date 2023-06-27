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

  home.packages = lib.attrValues {
    inherit (pkgs)
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
      stack
      typescript
      nodejs
      ;

    ghc = pkgs.haskell.compiler.native-bignum.ghc961;

    inherit (pkgs.haskellPackages)
      cabal-install
      cabal-fmt
      hoogle
      hpack
      implicit-hie
      haskell-language-server
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
  };
}
