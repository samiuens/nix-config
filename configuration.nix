let
  defaults = {
    timeZone = "Europe/Berlin";
    nixos = {
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
    macos = {
      coreModules = [
        "brew"
        "fonts"
        "nix"
        "overlays"
        "pkgs"
        "time"
      ];
      settingModules = [
        "appearance"
        "audio"
        "custom"
        "desktop"
        "dock"
        "finder"
        "input"
        "loginwindow"
        "networking"
        "power"
        "security"
      ];
    };
  };
in
{
  hosts = {
    "smi-mac" = {
      platform = "aarch64-darwin";
      timeZone = defaults.timeZone;

      # Systemwide
      coreModules = defaults.macos.coreModules;
      settingModules = defaults.macos.settingModules;
      systemApplications = [ ];
      systemServices = [ ];

      users = {
        "samiuensay" = {
          username = "samiuensay";
          description = "Sami Arda Ünsay";
          applications = [
            "firefox"
            "keepassxc"
            "kitty"
            "mullvad-vpn"
            "nextcloud"
            "vscodium"
          ];
          configurations = [
            "zsh"
            "git"
            "ssh"
          ];
          services = [ "syncthing" ];
        };
      };
    };

    "smi-nixos" = {
      platform = "x86_64-linux";
      dualBoot = true;
      timeZone = defaults.timeZone;

      desktopGui = "gnome";

      # Systemwide
      coreModules = defaults.nixos.coreModules;
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
            "mullvad-vpn"
            "nextcloud"
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
      guis = defaults.nixos.guis;
    };
  };
}
