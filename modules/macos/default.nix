{
  inputs,
  hostname,
  hostConfig,
  ...
}:
let
  coreModules = map (name: ./core/${name}.nix) hostConfig.coreModules;
  settingModules = map (name: ./settings/${name}.nix) hostConfig.settingModules;
  applicationModules = map (name: ./applications/${name}/default.nix) hostConfig.systemApplications;
  serviceModules = map (name: ./services/${name}/default.nix) hostConfig.systemServices;
in
{
  imports = [
    # Host-specific configuration import
    ../../hosts/${hostname}

    # Flake imports
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew

    # Users
    ./users
  ]
  ++ coreModules
  ++ settingModules
  ++ applicationModules
  ++ serviceModules;
}
