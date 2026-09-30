{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs =
    { nixpkgs, mnw, ... }:

    {
      packages = builtins.mapAttrs (system: pkgs: rec {
        neovim = mnw.lib.wrap pkgs ./config.nix;
        default = neovim;
      }) nixpkgs.legacyPackages;
    };
}
