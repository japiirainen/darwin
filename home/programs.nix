{ pkgs, lib, sp, ... }: {
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
      _ = sp.packages."aarch64-darwin".default;

      agda = pkgs.agda.withPackages (ps: [
        (ps.standard-library.overrideAttrs (_: {
          version = "2.0";
          src = pkgs.fetchFromGitHub {
            repo = "agda-stdlib";
            owner = "agda";
            rev = "177dc9e983606b653a3c6af2ae2162bbc87882ad";
            sha256 = "sha256-ovnhL5otoaACpqHZnk/ucivwtEfBQtGRu4/xw4+Ws+c=";
          };
        }))
      ]);


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
        neovide
        dhall
        ;

      inherit (pkgs)
        cloc
        github-copilot-cli
        typescript
        nodejs
        deno
        bun
        cbqn
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
      inherit (pkgs.nodePackages)
        prettier
        ;

      # a minimal python setup with commonly needed libs
      inherit (pkgs)
        pyright
        black
        pylint
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
        ]);
    };
}
