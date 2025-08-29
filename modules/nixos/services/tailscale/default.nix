{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ trayscale ];
  services.tailscale.enable = true;
}
