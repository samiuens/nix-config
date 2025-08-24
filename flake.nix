{
  description = "samiuen's nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ self, nixpkgs }:
    let
      nixHostNames = [
        "smi-nixos"
      ];
      mkNixHost =
        name:
        nixpkgs.lib.nixosSystem {
          modules = [ ];
        };
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (name: {
          inherit name;
          value = mkNixHost name;
        }) nixHostNames
      );
    };
}
