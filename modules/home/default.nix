{
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  userName = "samiuensay";
  applicationModules = map (name: ./applications/${name}/default.nix) hostConfig.homeApplications;
  configurationModules = map (
    name: ./configurations/${name}/default.nix) hostConfig.homeConfigurations;
in
{
  imports =
    [ ]
    ++ applicationModules
    ++ (if pkgs.stdenv.isLinux then [ ./gui/${hostConfig.desktopGui} ] else [ ]);

  home = {
    username = userName;
    homeDirectory = lib.mkDefault [
      (lib.mkIf pkgs.stdenv.isLinux "/home/${userName}")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/${userName}")
    ];
    packages = pkgs.callPackage (
      if pkgs.stdenv.isDarwin then ../../pkgs/macos.nix else ../../pkgs/nixos.nix
    ) { };
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
