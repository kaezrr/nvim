{ pkgs, lib, ... }:
let
  configDir = "~/Documents/nvim";
in
{
  plugins.dev.mnw = {
    pure = lib.fileset.toSource {
      root = ./.;
      fileset = lib.fileset.unions [
        ./lua
        ./plugin
      ];
    };

    impure = configDir;
  };

  initLua = ''
    vim.g.nix = true
    vim.g.flake_path = "${configDir}";
  '';

  luaFiles = [ ./init.lua ];

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

  extraBinPath =
    with pkgs;
    [
      ripgrep
      fd
      fzf
      chafa
      git

      nixd
      nixfmt
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      pkgs.wl-clipboard
      pkgs.xclip
    ];
}
