{ pkgs, ... }:

let
  fonts = import ../../../pkgs/fonts.nix { inherit pkgs; };
in
{
  fonts.packages = fonts;
}
