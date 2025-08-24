{
  inputs,
  hostname,
  hostConfig,
  ...
}:
let
  coreModules = map (name: ./core/${name}.nix) hostConfig.coreModules;
in
{
  imports = coreModules ++ [
    # Host-specific configuration import
    ../../hosts/${hostname}

    # Flake imports
    inputs.home-manager.nixosModules.home-manager

    # Users
    ./users/samiuensay.nix
  ];
}
