{
  inputs,
  hostname,
  hostConfig,
  ...
}:
let
  coreModules = map (name: ./core/${name}.nix) hostConfig.coreModules;
  applicationModules = map (name: ./applications/${name}/default.nix) hostConfig.systemApplications;
  serviceModules = map (name: ./services/${name}/default.nix) hostConfig.systemServices;
  virtualisationModules = map (name: ./virtualisation/${name}.nix) hostConfig.virtualisation;
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
      ./users
    ]
    ++ applicationModules
    ++ serviceModules
    ++ virtualisationModules;
}
