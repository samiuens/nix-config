{
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  userName = "samiuensay";
in
{
  imports = [ ] ++ lib.optional pkgs.stdenv.isLinux ./gui/${hostConfig.desktopGui};

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
