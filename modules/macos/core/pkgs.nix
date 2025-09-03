{ lib, hostConfig, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
    hostPlatform = lib.mkDefault hostConfig.platform;
  };
}
