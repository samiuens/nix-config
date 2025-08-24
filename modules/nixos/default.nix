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

    # Desktop GUI
    ./gui/${hostConfig.desktopGui}

    # Users
    ./users/samiuensay.nix
  ];
}
