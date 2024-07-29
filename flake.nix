{
  description = "denops-shared-server for Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = _: { darwinModules.default = import ./darwin.nix; };
}
