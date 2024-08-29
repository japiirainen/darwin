{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;
in
{
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Put neovim configuration located in this repository into place in a way that edits to the
  # configuration don't require rebuilding the `home-manager` environment to take effect.
  xdg.configFile."nvim/lua/".source = mkOutOfStoreSymlink "${nixConfigDirectory}/configs/nvim";

  # Load the `init` module from the above configs
  programs.neovim.extraConfig = "lua require('init')";

  programs.neovim.plugins = with pkgs.vimPlugins; [
    (nvim-treesitter.withPlugins (p: [
      p.bash
      p.json
      p.lua
      p.markdown
      p.nix
      p.python
      p.rust
      p.zig
      p.vimdoc
      p.javascript
      p.typescript
      p.tsx
    ]))
    nvim-lspconfig
    conform-nvim
    neogit
    fzf-vim
    which-key-nvim
    vim-tmux-navigator
    oil-nvim
  ];

  programs.neovim.extraPackages = with pkgs; [
    nodePackages.bash-language-server
    shellcheck
    marksman
    nodePackages.typescript-language-server
    deadnix
    nixpkgs-fmt
    statix
    nil
    stylua
    nodePackages.vim-language-server
    sumneko-lua-language-server
    vscode-langservers-extracted
    yaml-language-server
    tailwindcss-language-server
    ruff-lsp
  ];


  xdg.configFile."zls.json".text = ''
    {
      "enable_build_on_save": true
    }
  '';
}
