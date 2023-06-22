{
  description = "japiirainen darwin configuration";
  inputs = {
    # Package sets
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
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
  };
  outputs = {
    self,
    home-manager,
    darwin,
    flake-utils,
    ...
  } @ inputs: let
    inherit (self.lib) makeOverridable optionalAttrs attrValues singleton;

    homeStateVersion = "23.05";

    nixpkgsDefaults = {
      config = {
        allowUnfree = true;
      };
      overlays = attrValues self.overlays;
    };

    primaryUserDefaults = {
      username = "japiirainen";
      fullName = "Joona Piirainen";
      email = "joona.piirainen@gmail.com";
      nixConfigDirectory = "/Users/japiirainen/dev/darwin";
    };
  in
    {
      lib = inputs.nixpkgs-unstable.lib.extend (_: _: {
        mkDarwinSystem = import ./lib/mkDarwinSystem.nix inputs;
      });

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
        apple-silicon = _: prev:
          optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            # Add access to x86 packages system is running Apple Silicon
            pkgs-x86 = import inputs.nixpkgs-unstable {
              system = "x86_64-darwin";
              inherit (nixpkgsDefaults) config;
            };
          };
      };

      darwinModules = {
        jp-darwin = import ./darwin;

        users-primaryUser = import ./modules/darwin/users.nix;
      };

      homeManagerModules = {
        jp-home = import ./home;
        jp-tmux = import ./home/tmux.nix;
        jp-kitty = import ./home/kitty.nix;
        jp-colors = import ./home/colors.nix;
        jp-fish = import ./home/fish.nix;
	jp-neovim = import ./home/neovim.nix;

        colors = import ./modules/home/colors;
        programs-kitty-extras = import ./modules/home/programs/kitty/extras.nix;
        home-user-info = {lib, ...}: {
          options.home.user-info =
            (self.darwinModules.users-primaryUser {inherit lib;}).options.users.primaryUser;
        };
      };

      # System configurations

      darwinConfigurations.jp-mbp = makeOverridable self.lib.mkDarwinSystem (primaryUserDefaults
        // {
          modules =
            (attrValues self.darwinModules)
            ++ (singleton {
              nixpkgs = nixpkgsDefaults;
              networking.computerName = "jp-mbp";
              networking.hostName = "jp-mbp";
              nix.registry.my.flake = inputs.self;
            });
          inherit homeStateVersion;
          system = "aarch64-darwin";
          homeModules = attrValues self.homeManagerModules;
        });
    }
    // flake-utils.lib.eachDefaultSystem (system: {
      legacyPackages = import inputs.nixpkgs-unstable (nixpkgsDefaults // {inherit system;});
    });
}
