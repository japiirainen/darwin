{ pkgs, lib, k, ... }: {
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
      ];
    };
  };

  home.packages =
    lib.attrValues {
      k = k.packages."aarch64-darwin".k;

      agda = pkgs.agda.withPackages (ps: [
        (ps.standard-library.overrideAttrs (_: {
          version = "2.0";
          src = pkgs.fetchFromGitHub {
            repo = "agda-stdlib";
            owner = "agda";
            rev = "e2bd4c5636962ac93c7e2b650f913c7f9155b37d";
            sha256 = "sha256-2olWXS+vlTPTLa9bUw8LYQlxfFYbDEJmtFqBtTZMf58=";
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
        ;

      latexmk = pkgs.texlivePackages.latexmk;

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
        ;

      # Nix related tools
      inherit (pkgs)
        cachix
        comma
        nix-tree
        nix-update
        statix
        nil
        ;

      # npm packages
      inherit (pkgs.nodePackages) prettier;

      inherit (pkgs)
        koka
        ;

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
          fastapi
          pydantic
          gunicorn
          sqlparse
        ]);

      inherit (pkgs) racket;
      inherit (pkgs) google-cloud-sdk;
      inherit (pkgs) azure-cli;
      inherit (pkgs) postgresql;
      inherit (pkgs) redis;

      # swift stuff
      inherit (pkgs)
        sourcekit-lsp
        ;
    };
}
