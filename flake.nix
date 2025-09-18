{
  description = "samiuen's nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia = {
      url = "path:/home/samiuensay/Development/caelestia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      hyprland,
      nix-homebrew,
      lanzaboote,
      nix4vscode,
      zen-browser,
      caelestia,
    }:
    let
      nixHostNames = [
        "smi-nixos"
      ];
      macHostNames = [
        "smi-mac"
      ];
      mkNixHost =
        name:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            hostname = name;
            hostConfig = import ./hosts/${name}/configuration.nix;
          };
          modules = [ ./modules/nixos ];
        };
      mkMacHost =
        name:
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs;
            hostname = name;
            hostConfig = import ./hosts/${name}/configuration.nix;
          };
          modules = [ ./modules/macos ];
        };
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (name: {
          inherit name;
          value = mkNixHost name;
        }) nixHostNames
      );
      darwinConfigurations = builtins.listToAttrs (
        map (name: {
          inherit name;
          value = mkMacHost name;
        }) macHostNames
      );
    };
}
