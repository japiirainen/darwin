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
      typescript
      nodejs
      elan
      ;

    # Haskell related tools
    ghc = pkgs.haskell.compiler.ghc945;
    hls = pkgs.haskell-language-server.override {
      supportedGhcVersions = [ "945" ];
    };

    inherit (pkgs.haskellPackages)
      cabal-install
      cabal-fmt
      hoogle
      hpack
      implicit-hie
      ghcid
      fourmolu
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
