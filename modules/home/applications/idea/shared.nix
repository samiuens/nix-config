{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jdk24
    jetbrains.idea-ultimate
  ];
}
