{
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  desktopGui = if pkgs.stdenv.isDarwin then [ ] else hostConfig.desktopGui;
  isMacOS = pkgs.stdenv.isDarwin;
in
{
  home.file = lib.mkIf (isMacOS || desktopGui != [ ]) {
    "Pictures/wallpapers".source = ../../../custom/wallpapers;
  };
}
