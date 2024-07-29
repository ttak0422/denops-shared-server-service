{
  description = "denops-shared-server for Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    denops-vim = {
      url = "github:vim-denops/denops.vim";
      flake = false;
    };
  };

  outputs =
    { denops-vim, ... }:
    {
      darwinModules.default = import ./darwin.nix { inherit denops-vim; };
    };
}
