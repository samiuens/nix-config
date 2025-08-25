let
  defaults = {
    timeZone = "Europe/Berlin";
    coreModules = [
      "audio"
      "boot"
      "locale"
      "networking"
      "nix"
      "overlays"
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

      desktopGui = "gnome";

      # Modules
      coreModules = defaults.coreModules;
      systemApplications = [ "1password" ];
      homeApplications = [ "vscodium" ];
    };
  };
}
