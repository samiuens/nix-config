{ hostConfig, pkgs, ... }:
{
  # Disable homebrew telemetry
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = false;
      cleanup = "zap";
    };
    taps = [ ];
    brews = [
      "podman"
    ];
    casks = pkgs.callPackage ../../../pkgs/casks.nix { };
    masApps = {
      "Bitwarden" = 1352778147;
    };
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = if (hostConfig.platform == "aarch64-darwin") then true else false;
    user = "samiuensay";
    autoMigrate = true;
    mutableTaps = true;
  };
}
