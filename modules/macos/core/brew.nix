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
    brews = [ ];
    casks = pkgs.callPackage ../../../pkgs/casks.nix { };
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = if (hostConfig.platform == "aarch64-darwin") then true else false;
    user = builtins.head (builtins.attrNames hostConfig.users);
    autoMigrate = true;
    mutableTaps = true;
  };
}
