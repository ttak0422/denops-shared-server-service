{
  description = "denops-shared-server for Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    denops-vim = {
      url = "github:vim-denops/denops.vim";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (_: {
      systems = [
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem =
        { pkgs, ... }:
        {
          packages.denops-vim = pkgs.vimUtils.buildVimPlugin {
            pname = "denops-vim";
            version = inputs.denops-vim.rev;
            src = inputs.denops-vim;
          };
        };
    })
  // {
    darwinModules.default = import ./darwin.nix self;
  };
}
