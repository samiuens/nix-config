{
  description = "samiuen's nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
    }:
    let
      config = import ./configuration.nix;
      nixHostNames = [
        "smi-nixos"
      ];
      mkNixHost =
        name:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            hostname = name;
            hostConfig = config.hosts."${name}";
          };
          modules = [ ./modules/nixos ];
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
