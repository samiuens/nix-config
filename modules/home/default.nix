{ pkgs, lib, ... }:
let
  userName = "samiuensay";
in
{
  home = {
    username = userName;
    homeDirectory = lib.mkDefault [
      (lib.mkIf pkgs.stdenv.isLinux "/home/${userName}")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/${userName}")
    ];
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
