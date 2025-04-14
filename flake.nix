{
  description = "japiirainen darwin configuration";
  inputs = {
    # Package sets
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Flake utilities
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";

    # Agda mode for Neovim
    cornelis = {
      url = "github:isovector/cornelis";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
      };
    };

    # Spacebar
    spacebar.url = "github:cmacrae/spacebar/v1.4.0";
    spacebar.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };
  outputs =
    {
      self,
      flake-utils,
      ...
    }@inputs:
    let
      inherit (self.lib)
        makeOverridable
        optionalAttrs
        attrValues
        singleton
        ;

      homeStateVersion = "25.05";

      nixpkgsDefaults = {
        config = {
          allowUnfree = true;
        };
        overlays =
          attrValues self.overlays
          ++ [
            inputs.cornelis.overlays.cornelis
            inputs.spacebar.overlay.aarch64-darwin
          ]
          ++ singleton (
            final: prev:
            (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
              # Sub in x86 version of packages that don't build on Apple Silicon.
              inherit (final.pkgs-x86)
                idris2
                ;
            })
            // { }
          );
      };

      primaryUserDefaults = {
        username = "japiirainen";
        fullName = "Joona Piirainen";
        email = "joona.piirainen@gmail.com";
        nixConfigDirectory = "/Users/japiirainen/dev/darwin";
      };
    in
    {
      lib = inputs.nixpkgs-unstable.lib.extend (
        _: _: {
          mkDarwinSystem = import ./lib/mkDarwinSystem.nix inputs;
        }
      );

      overlays = {
        # Overlays to add different versions `nixpkgs` into package set
        pkgs-master = _: prev: {
          pkgs-master = import inputs.nixpkgs-master {
            inherit (prev.stdenv) system;
            inherit (nixpkgsDefaults) config;
          };
        };

        pkgs-stable = _: prev: {
          pkgs-stable = import inputs.nixpkgs-stable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsDefaults) config;
          };
        };

        pkgs-unstable = _: prev: {
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsDefaults) config;
          };
        };

        apple-silicon =
          _: prev:
          optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            # Add access to x86 packages system is running Apple Silicon
            pkgs-x86 = import inputs.nixpkgs-unstable {
              system = "x86_64-darwin";
              inherit (nixpkgsDefaults) config;
            };
          };

        # Overlay that adds various additional utility functions to `vimUtils`
        vimUtils = import ./overlays/vimUtils.nix;

        # Overlay that adds some additional Neovim plugins
        vimPlugins =
          final: prev:
          let
            inherit (self.overlays.vimUtils final prev) vimUtils;
          in
          {
            vimPlugins = prev.vimPlugins.extend (
              _: _:
              # Useful for testing/using Vim plugins that aren't in `nixpkgs`.
              vimUtils.buildVimPluginsFromFlakeInputs inputs [
                # Add flake input names here for a Vim plugin repos
              ]
              // {
                # Other Vim plugins
                inherit (inputs.cornelis.packages.${prev.stdenv.system}) cornelis-vim;
              }
            );
          };

      };

      baseDarwinModules = {
        jp-bootstrap = import ./darwin/bootstrap.nix;
        jp-general = import ./darwin/general.nix;
        jp-defaults = import ./darwin/defaults.nix;
        jp-homebrew = import ./darwin/homebrew.nix;
        jp-yabai = import ./darwin/yabai.nix;
        jp-skhd = import ./darwin/skhd.nix;
        jp-spacebar = import ./darwin/spacebar.nix;
        jp-jankyborders = import ./darwin/jankyborders.nix;

        users-primaryUser = import ./modules/darwin/users.nix;
      };

      homeManagerModules = {
        jp-home = import ./home;
        jp-packages = import ./home/packages.nix;
        jp-git = import ./home/git.nix;
        jp-tmux = import ./home/tmux.nix;
        jp-fish = import ./home/fish.nix;
        jp-neovim = import ./home/neovim.nix;
        jp-emacs = import ./home/emacs.nix;
        jp-atuin = import ./home/atuin.nix;
        jp-ghostty = import ./home/ghostty.nix;
        jp-helix = import ./home/helix.nix;

        home-user-info =
          { lib, ... }:
          {
            options.home.user-info =
              (self.baseDarwinModules.users-primaryUser { inherit lib; }).options.users.primaryUser;
          };
      };

      # System configurations

      darwinConfigurations = {
        # Personal machine
        jp-personal = makeOverridable self.lib.mkDarwinSystem (
          primaryUserDefaults
          // {
            modules =
              attrValues self.baseDarwinModules
              ++ singleton {
                nixpkgs = nixpkgsDefaults;
                networking.computerName = "jp-personal";
                networking.hostName = "jp-personal";
                nix.registry.my.flake = inputs.self;
              };
            extraModules = [ ];
            inherit homeStateVersion;
            homeModules = attrValues self.homeManagerModules;
          }
        );

        # Work machine
        jp-work = makeOverridable self.lib.mkDarwinSystem (
          primaryUserDefaults
          // {
            modules =
              attrValues self.baseDarwinModules
              ++ singleton {
                nixpkgs = nixpkgsDefaults;
                networking.computerName = "jp-work";
                networking.hostName = "jp-work";
                nix.registry.my.flake = inputs.self;
              };
            extraModules = [ ];
            username = "jp-work";
            nixConfigDirectory = "/Users/jp-work/dev/darwin";
            inherit homeStateVersion;
            homeModules = attrValues self.homeManagerModules;
          }
        );
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: {
      legacyPackages = import inputs.nixpkgs-unstable (nixpkgsDefaults // { inherit system; });
    });
}
