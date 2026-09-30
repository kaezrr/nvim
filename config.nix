{ pkgs, lib, ... }:

{
  aliases = [
    "vi"
    "vim"
  ];

  plugins.dev.mnw = {
    pure = lib.fileset.toSource {
      root = ./.;
      fileset = lib.fileset.unions [
        ./lua
        ./plugin
      ];
    };

  };

  initLua = ''
    -- [[ Setting options ]]
    require 'options'

    -- [[ Basic and high powered keybinds ]]
    require 'keybinds'

    -- [[ Auto commands ]]
    require 'autocmd'
  '';

  plugins.start = with pkgs.vimPlugins; [
    kanagawa-nvim
    blink-cmp
    nvim-lspconfig
    fzf-lua
    conform-nvim
    gitsigns-nvim

    mini-ai
    mini-notify
    mini-statusline
    mini-pairs
    mini-files
    mini-icons

    nvim-treesitter.withAllGrammars
  ];

  extraBinPath = with pkgs; [
    ripgrep
    fd
    fzf
    chafa

    # For working with config files
    lua-language-server
    stylua

    # For working with nix files
    nixfmt
    nixd
  ];
}
