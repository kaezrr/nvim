# Neovim

My personal neovim configuration, can be used either as a nix flake or a regular configuration.

## Try it out with a single command
```sh
nix run github:kaezrr/neovim
```

## Usage - Regular

```sh
git clone https://github.com/kaezrr/neovim.git $XDG_CONFIG_HOME/nvim
```

## Usage - Nix Flake

Add this flake to your inputs and then install it as a system package.

```nix
# flake.nix
{
  inputs = {
    neovim = {
      url = "github:kaezrr/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  }

  # ...

  environment.systemPackages = [
    inputs.neovim.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];
}
```
