{
  description = "My personal neovim flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs =
    { nixpkgs, mnw, ... }:

    {
      packages = builtins.mapAttrs (system: pkgs: rec {
        nvim = mnw.lib.wrap pkgs ./config.nix;
        default = nvim;
      }) nixpkgs.legacyPackages;

      devShells = builtins.mapAttrs (system: pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            lua-language-server
            stylua
          ];
        };
      }) nixpkgs.legacyPackages;

      formatter = builtins.mapAttrs (system: pkgs: pkgs.nixfmt-tree) nixpkgs.legacyPackages;
    };
}
