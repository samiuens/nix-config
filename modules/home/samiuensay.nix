{
  pkgs,
  lib,
  hostConfig,
  userOptions,
  ...
}:
let
  userName = userOptions.username;
  applicationModules = map (name: ./applications/${name}/default.nix) userOptions.applications;
  configurationModules = map (name: ./configurations/${name}/default.nix) userOptions.configurations;
in
{
  imports =
    [ ]
    ++ applicationModules
    ++ configurationModules
    ++ (if pkgs.stdenv.isLinux then [ ./gui/${hostConfig.desktopGui} ] else [ ]);

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
