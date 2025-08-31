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
      "security"
      "time"
    ];
    guis = {
      "gnome" = {
        extensions = [
          "blur-my-shell"
          "pano"
          "open-bar"
        ];
      };
    };
  };
in
{
  hosts = {
    "smi-nixos" = {
      platform = "x86_64-linux";
      dualBoot = true;
      timeZone = defaults.timeZone;

      desktopGui = "gnome";

      # Systemwide
      coreModules = defaults.coreModules;
      systemApplications = [
        "onepassword"
        "coolercontrol"
      ];
      systemServices = [
        "tailscale"
        "localsend"
      ];
      enableDocker = true;

      # Users
      users = {
        "samiuensay" = {
          username = "samiuensay";
          description = "Sami Arda Ünsay";
          applications = [
            "cider"
            "firefox"
            "flameshot"
            "keepassxc"
            "kitty"
            "nextcloud"
            "rofi"
            "vscodium"
          ];
          configurations = [
            "zsh"
            "git"
            "ssh"
          ];
          services = [
            "syncthing"
          ];
        };
      };

      # GUIs
      guis = defaults.guis;
    };
  };
}
