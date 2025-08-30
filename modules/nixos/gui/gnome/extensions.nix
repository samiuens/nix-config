{ pkgs, hostConfig, ... }:
let
  gnomeExtensions = map (name: pkgs.gnomeExtensions.${name}) hostConfig.guis."gnome".extensions;
in
{
  environment.systemPackages = gnomeExtensions;
}
