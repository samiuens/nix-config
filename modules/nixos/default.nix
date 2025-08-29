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
    ++ applicationModules
    ++ serviceModules
    ++ (if hostConfig.enableDocker then [ ./virtualisation/docker.nix ] else [ ]);
}
