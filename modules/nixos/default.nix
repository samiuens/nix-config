{
  inputs,
  hostname,
  hostConfig,
  ...
}:
let
  coreModules = map (name: ./core/${name}.nix) hostConfig.coreModules;
  applicationModules = map (name: ./applications/${name}/default.nix) hostConfig.systemApplications;
in
{
  imports =
    coreModules
    ++ [
      # Host-specific configuration import
      ../../hosts/${hostname}

      # Flake imports
      inputs.home-manager.nixosModules.home-manager

      # Desktop GUI
      ./gui/${hostConfig.desktopGui}

      # Users
      ./users/samiuensay.nix
    ]
    ++ applicationModules;
}
