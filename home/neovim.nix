{ config, lib, pkgs, ... }:
let
  inherit (lib) concatStringsSep optional;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;

  # from malob's configurations
  mkLuaTableFromList = x: "{" + lib.concatMapStringsSep "," (y: "'${y}'") x + "}";
  mkNeovimAutocmd = { event, pattern, callback ? "" }: ''
    vim.api.nvim_create_autocmd(${mkLuaTableFromList event}, {
      pattern = ${mkLuaTableFromList pattern},
      callback = ${callback},
    })'';

  requireConf = p: "require '${builtins.replaceStrings [ "." ] [ "-" ] p.pname}'";

  packer =
    { use
      # Plugins that this plugin depends on.
    , deps ? [ ]
      # Used to manually specify that the plugin shouldn't be loaded at start up.
    , opt ? false
      # Whether to load the plugin when using VS Code with `vscode-neovim`.
    , vscode ? false
      # Code to run before the plugin is loaded.
    , setup ? ""
      # Code to run after the plugin is loaded.
    , config ? ""
      # The following all imply lazy-loading and imply `opt = true`.
      # `FileType`s which load the plugin.
    , ft ? [ ]
      # Autocommand events which load the plugin.
    , event ? [ ]
    }:
    let
      loadFunctionName = "load_${builtins.replaceStrings [ "." "-" ] [ "_" "_" ] use.pname}";
      autoload = !opt && vscode && ft == [ ] && event == [ ];
      configFinal =
        concatStringsSep "\n" (
          optional (!autoload && !opt) "vim.cmd 'packadd ${use.pname}'"
          ++ optional (config != "") config
        );
    in
    {
      plugin = use.overrideAttrs (old: {
        dependencies = lib.unique (old.dependencies or [ ] ++ deps);
      });
      optional = !autoload;
      type = "lua";
      config = if (setup == "" && configFinal == "") then null else
      (
        concatStringsSep "\n"
          (
            [ "\n-- ${use.pname or use.name}" ]
            ++ optional (setup != "") setup

            # If the plugin isn't always loaded at startup
            ++ optional (!autoload) (concatStringsSep "\n" (
              [ "local ${loadFunctionName} = function()" ]
              ++ optional (!vscode) "if vim.g.vscode == nil then"
              ++ [ configFinal ]
              ++ optional (!vscode) "end"
              ++ [ "end" ]
              ++ optional (ft == [ ] && event == [ ]) "${loadFunctionName}()"
              ++ optional (ft != [ ]) (mkNeovimAutocmd {
                event = [ "FileType" ];
                pattern = ft;
                callback = loadFunctionName;
              })
              ++ optional (event != [ ]) (mkNeovimAutocmd {
                inherit event;
                pattern = [ "*" ];
                callback = loadFunctionName;
              })
            ))

            # If the plugin is always loaded at startup
            ++ optional (autoload && configFinal != "") configFinal
          )
      );
    };
in
{
  programs.neovim.enable = true;

  # Config and plugins ------------------------------------------------------------------------- {{{

  # Put neovim configuration located in this repository into place in a way that edits to the
  # configuration don't require rebuilding the `home-manager` environment to take effect.
  xdg.configFile."nvim/lua/".source = mkOutOfStoreSymlink "${nixConfigDirectory}/configs/nvim";

  # Load the `init` module from the above configs
  programs.neovim.extraConfig = "lua require('init')";

  # Add NodeJs since it's required by some plugins I use.
  programs.neovim.withNodeJs = true;
  # Add `penlight` Lua module package since I used in the above configs
  programs.neovim.extraLuaPackages = ps: [ ps.penlight ];

  # neovim plugins
  programs.neovim.plugins = with pkgs.vimPlugins; map packer [
    { use = which-key-nvim; opt = true; }
    { use = NeoSolarized; opt = true; }
    { use = neogit; config = "require'neogit'.setup()"; }
    {
      use = telescope-nvim;
      deps = [
        nvim-web-devicons
        telescope-file-browser-nvim
        telescope-fzf-native-nvim
        telescope_hoogle
        telescope-symbols-nvim
        telescope-zoxide
      ];
    }
    { use = nvim-tree-lua; opt = true; }
    { use = gitsigns-nvim; config = requireConf gitsigns-nvim; }

    { use = copilot-vim; }
    { use = coq_nvim; opt = true; deps = [ coq-artifacts coq-thirdparty ]; config = requireConf coq_nvim; }

    { use = formatter-nvim; config = requireConf formatter-nvim; }

    { use = lspsaga-nvim; config = requireConf lspsaga-nvim; }
    { use = null-ls-nvim; config = requireConf null-ls-nvim; }
    { use = nvim-lspconfig; deps = [ neodev-nvim ]; config = requireConf nvim-lspconfig; }

    {
      use = cornelis;
      setup = ''
        vim.g.cornelis_use_global_binary = 1
        vim.g.cornelis_agda_prefix = '\\'
      '';
      config = requireConf cornelis;
    }

    { use = vim-commentary; opt = true; }
  ];

  programs.neovim.extraPackages = with pkgs; [
    nodePackages.bash-language-server
    shellcheck

    nodePackages.typescript-language-server

    deadnix
    nixpkgs-fmt
    statix
    nil

    nodePackages.vim-language-server
    sumneko-lua-language-server
    vscode-langservers-extracted

    proselint
    (agda.withPackages (p: [ p.standard-library ]))
    cornelis
  ];
}
