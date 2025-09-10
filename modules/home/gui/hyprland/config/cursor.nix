{ pkgs, ... }:
{
  home.packages = with pkgs; [ quintom-cursor-theme ];
  home.file.".icons/default".source = "${pkgs.quintom-cursor-theme}/share/icons/Quintom_Ink";
}
