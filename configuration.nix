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
    users = {
      "samiuensay" = {
        username = "samiuensay";
        description = "Sami Arda Ünsay";
        applications = [
          "firefox"
          "kitty"
          "vscodium"
        ];
        configurations = [
          "zsh"
          "git"
          "ssh"
        ];
      };
    };
  };
in
{
  hosts = {
    "smi-nixos" = {
      platform = "x86_64-linux";
      timeZone = defaults.timeZone;

      desktopGui = "gnome";

      # Systemwide
      coreModules = defaults.coreModules;
      systemApplications = [ "onepassword" ];

      # Users
      users = defaults.users;
    };
  };
}
