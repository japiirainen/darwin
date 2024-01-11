{ pkgs, lib, sp, k, ... }: {
  programs = {
    bat.enable = true;
    bat.config.style = "plain";

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    htop.enable = true;
    htop.settings.show_program_path = true;

    ssh.enable = true;
    ssh.controlPath = "~/.ssh/%C";

    # Zoxide, a faster way to navigate the filesystem
    # https://github.com/ajeetdsouza/zoxide
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
    zoxide.enable = true;

    vscode = {
      # only install vscode and extensions via nix for now
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        vscodevim.vim
        jnoortheen.nix-ide
        bbenoist.nix
        uiua-lang.uiua-vscode
      ];
    };
  };

  home.packages =
    lib.attrValues {
      sp = sp.packages."aarch64-darwin".default;
      k = k.packages."aarch64-darwin".k;

      agda = pkgs.agda.withPackages (ps: [
        (ps.standard-library.overrideAttrs (_: {
          version = "2.0";
          src = pkgs.fetchFromGitHub {
            repo = "agda-stdlib";
            owner = "agda";
            rev = "92f79251170958b216f6d1466d05ae5b079b646c";
            sha256 = "sha256-rFzTA504a6aFiWi92PfoC7jQJd7Ljiki+fi5DeewZ1c=";
          };
        }))
      ]);

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

      inherit (pkgs)
        tree
        ripgrep
        vim
        fd
        curl
        less
        eza
        bottom
        wget
        dhall
        ;

      inherit (pkgs)
        cloc
        termdown
        github-copilot-cli
        typescript
        nodejs
        deno
        bun
        cbqn-replxx
        pnpm
        podman
        ;

      # Nix related tools
      inherit (pkgs)
        cachix
        comma
        nix-tree
        nix-update
        statix
        ;

      # npm packages
      inherit (pkgs.nodePackages) prettier;

      inherit (pkgs) uiua;

      # a minimal python setup with commonly needed libs
      inherit (pkgs)
        pyright
        black
        pylint
        pre-commit
        poetry
        ;
      python311 = pkgs.python311.withPackages
        (p: with p; [
          numpy
          sympy
          vulture
          matplotlib
          fastapi
          pydantic
          gunicorn
          ipython
        ]);

      # racket
      inherit (pkgs) racket;

      # gcp
      inherit (pkgs) google-cloud-sdk;

      # postgresql
      inherit (pkgs) postgresql;
    };
}
