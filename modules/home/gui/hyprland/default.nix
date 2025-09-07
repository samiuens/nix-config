{ inputs, pkgs, ... }:
let
  moduleNames = [
    "cursor"
    "input"
    "keybinds"
    "misc"
    "monitor"
    "variables"
  ];
  moduleImports = map (name: ./${name}.nix) moduleNames;
in
{
  imports = moduleImports;

  wayland.windowManager.hyprland = {
    enable = true;

    # using the systemwide packages
    package = null;
    portalPackage = null;

    xwayland.enable = true;
    systemd.enable = true;
  };
}
