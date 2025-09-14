{ inputs, pkgs, ... }:
{
  imports = [
    ../fonts.nix
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
    settings = {
      greeter = {
        includeAll = true;
      };
    };
  };

  services.udisks2.enable = true;

  fonts.packages = with pkgs; [
    adwaita-fonts
  ];
}
