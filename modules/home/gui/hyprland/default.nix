{ inputs, pkgs, ... }:
let
  configNames = [
    "animations"
    "cursor"
    "decoration"
    "env"
    "exec"
    "general"
    "gtk"
    "input"
    "keybinds"
    "misc"
    "monitor"
    "rules"
  ];
  pluginNames = [
    "caelestia"
    "hypridle"
    "keyring"
    "udiskie"
  ];
  configImports = map (name: ./config/${name}.nix) configNames;
  pluginImports = map (name: ./plugins/${name}.nix) pluginNames;
in
{
  imports = configImports ++ pluginImports;
  wayland.windowManager.hyprland = {
    enable = true;

    # using the systemwide packages
    package = null;
    portalPackage = null;

    xwayland.enable = true;
    systemd.enable = true;
  };
}
