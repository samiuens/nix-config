{ pkgs, ... }:
{
  home.packages = with pkgs; [ trayscale ];
  services.tailscale.enable = true;
}
