let
  defaults = {
    timeZone = "Europe/Berlin";
    coreModules = [
      "audio"
      "boot"
      "locale"
      "networking"
      "nix"
      "pkgs"
      "printing"
      "time"
    ];
  };
in
{
  hosts = {
    "smi-nixos" = {
      platform = "x86_64-linux";
      timeZone = defaults.timeZone;

      # Modules
      coreModules = defaults.coreModules;
    };
  };
}
