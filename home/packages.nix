{ pkgs, lib, ... }: {
  programs = {
    bat.enable = true;
    bat.config.style = "plain";

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    btop.enable = true;

    ssh.enable = true;
    ssh.controlPath = "~/.ssh/%C";

    # Zoxide, a faster way to navigate the filesystem
    # https://github.com/ajeetdsouza/zoxide
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
    zoxide.enable = true;
  };

  home.packages = lib.attrValues ({
    agda = pkgs.agda.withPackages (ps: [ ps.standard-library ]);

    haskell = pkgs.haskellPackages.ghcWithPackages
      (p: with p; [
        ghcid
        cabal-install
        text
        containers
        data-ordlist
        fourmolu
      ]);

    hls = pkgs.haskell-language-server;

    # a minimal python setup with commonly needed libs
    inherit (pkgs)
      pyright
      black
      pylint
      pre-commit
      poetry
      ;

    python312 = pkgs.python312.withPackages
      (p: with p; [
        numpy
        sympy
        ipython
        matplotlib
      ]);

    ocamllsp = pkgs.ocamlPackages.ocaml-lsp;

    inherit (pkgs)
      tree
      ripgrep
      vim
      fd
      jq
      curl
      less
      eza
      bottom
      wget
      dhall
      rustup
      kitty-themes
      sad
      fzf
      obsidian
      texliveFull
      nerdfetch
      cloc
      termdown
      github-copilot-cli
      typescript
      nodejs
      deno
      bun
      cbqn-replxx
      cachix
      comma
      nix-tree
      nix-update
      statix
      nil
      racket
      google-cloud-sdk
      azure-cli
      postgresql
      redis
      sourcekit-lsp
      ;

    inherit (pkgs.texlivePackages) latexmk;

    inherit (pkgs.nodePackages) prettier;
  });
}
