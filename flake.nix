{
  description = "My personal neovim flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs =
    { nixpkgs, mnw, ... }:
    let
      eachSystem = f: builtins.mapAttrs (_: pkgs: f pkgs) nixpkgs.legacyPackages;
    in
    {
      packages = eachSystem (pkgs: rec {
        nvim = mnw.lib.wrap pkgs ./config.nix;
        default = nvim;
      });

      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            lua-language-server
            stylua
          ];
        };
      });

      formatter = eachSystem (pkgs: pkgs.nixfmt-tree);
    };
}
