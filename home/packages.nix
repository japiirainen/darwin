{ pkgs, lib, ... }:
{
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

    haskell = pkgs.haskellPackages.ghcWithPackages (
      p: with p; [
        ghcid
        cabal-install
        text
        containers
        data-ordlist
        fourmolu
      ]
    );

    hls = pkgs.haskell-language-server;

    # a minimal python setup with commonly needed libs
    inherit (pkgs)
      pyright
      black
      pylint
      pre-commit
      poetry
      ;

    python312 = pkgs.python312.withPackages (
      p: with p; [
        numpy
        sympy
        ipython
        matplotlib
      ]
    );

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
      sad
      fzf
      texliveFull
      cloc
      termdown
      github-copilot-cli
      typescript
      typescript-language-server
      vscode-langservers-extracted
      nodejs_23
      deno
      bun
      cbqn-replxx
      cachix
      nix-index
      comma
      nix-tree
      nix-update
      statix
      nil
      google-cloud-sdk
      postgresql
      redis
      cmake
      vivid
      turbo
      openfga-cli
      uiua
      rlwrap
      terraform
      terraform-ls
      ;

    inherit (pkgs.texlivePackages) latexmk;

    inherit (pkgs.nodePackages) prettier;
  });
}
