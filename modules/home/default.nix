{
  pkgs,
  lib,
  hostConfig,
  userName,
  userOptions,
  ...
}:
let
  moduleHelper = import ../../lib/homeModuleHelper.nix;

  # Module imports
  applicationModules = moduleHelper {
    moduleConfig = userOptions.applications;
    configDir = ./applications;
    username = userName;
  };
  configurationModules = moduleHelper {
    moduleConfig = userOptions.configurations;
    configDir = ./configurations;
    username = userName;
  };
  serviceModules = moduleHelper {
    moduleConfig = userOptions.services;
    configDir = ./services;
    username = userName;
  };
  desktopGuiModules =
    if pkgs.stdenv.isLinux then map (name: ./gui/${name}/default.nix) hostConfig.desktopGui else [ ];
in
{
  imports = applicationModules ++ configurationModules ++ serviceModules ++ desktopGuiModules;

  home = {
    username = userName;
    homeDirectory = lib.mkDefault [
      (lib.mkIf pkgs.stdenv.isLinux "/home/${userName}")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/${userName}")
    ];
    packages = pkgs.callPackage (
      if pkgs.stdenv.isDarwin then ../../pkgs/${userName}/macos.nix else ../../pkgs/${userName}/nixos.nix
    ) { };
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
