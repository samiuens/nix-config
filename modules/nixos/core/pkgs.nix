{ lib, hostConfig, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault hostConfig.platform;
  };
}
