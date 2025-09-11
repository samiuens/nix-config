{
  inputs,
  hostname,
  hostConfig,
  ...
}:
let
  applicationModules = map (name: ./applications/${name}/default.nix) hostConfig.systemApplications;
  coreModules = map (name: ./core/${name}.nix) hostConfig.coreModules;
  optionModules = map (name: ./options/${name}.nix) hostConfig.options;
  desktopGuiModules = map (name: ./gui/${name}/default.nix) hostConfig.desktopGui;
  serviceModules = map (name: ./services/${name}/default.nix) hostConfig.systemServices;
  virtualisationModules = map (name: ./virtualisation/${name}.nix) hostConfig.virtualisation;
in
{
  imports = [
    # Host-specific configuration import
    ../../hosts/${hostname}

    # Flake imports
    inputs.home-manager.nixosModules.home-manager

    # Users
    ./users
  ]
  ++ applicationModules
  ++ coreModules
  ++ optionModules
  ++ desktopGuiModules
  ++ serviceModules
  ++ virtualisationModules;
}
