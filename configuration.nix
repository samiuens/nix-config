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
          description = "Sami Arda Ünsay";
          applications = [
            "aerospace"
            "firefox"
            "keepassxc"
            "kitty"
            "linearmouse"
            "vscodium"
          ];
          configurations = [
            "zsh"
            "git"
            "ssh"
          ];
          services = [ "syncthing" ];
        };
        "samiarda" = {
          description = "samiarda (Work)";
          applications = [
            "aerospace"
            "firefox"
            "kitty"
            "linearmouse"
            "vscodium"
          ];
          configurations = [ "zsh" ];
          services = [ ];
        };
      };
    };

    "smi-nixos" = {
      platform = "x86_64-linux";
      dualBoot = true;
      timeZone = defaults.timeZone;

      desktopGui = "hyprland";

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

      virtualisation = [
        "docker"
        "podman"
      ];

      # Users
      users = {
        "samiuensay" = {
          description = "Sami Arda Ünsay";
          sudoPermission = true;
          applications = [
            "cider"
            "firefox"
            "flameshot"
            "keepassxc"
            "kitty"
            "vscodium"
            "zen-browser"
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
        "samiarda" = {
          description = "samiarda (Work)";
          sudoPermission = false;
          applications = [
            "chromium"
            "kitty"
          ];
          configurations = [
            "zsh"
            "git"
          ];
          services = [ ];
        };
      };

      # GUIs
      guis = defaults.nixos.guis;
    };
  };
}
