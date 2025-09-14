let
  defaults = {
    timeZone = "Europe/Berlin";
    nixos = {
      coreModules = [
        "audio"
        "boot"
        "hardware"
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
        #"fonts" # Broken, at the moment
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
            "drawio"
            "gitkraken"
            "idea"
            "keepassxc"
            "kitty"
            "neovim"
            "nodejs"
            "opentofu"
            "qmk"
            "vscodium"
            "zen-browser"
            "zotero"
          ];
          configurations = [
            "git"
            "linearmouse"
            "ssh"
            "zsh"
          ];
          services = [ "syncthing" ];
        };
        "samiarda" = {
          description = "samiarda (Work)";
          applications = [
            "aerospace"
            "cursor"
            "datagrip"
            "gitkraken"
            "kitty"
            "neovim"
            "nodejs"
            "opentofu"
          ];
          configurations = [
            "git"
            "linearmouse"
            "zsh"
          ];
          services = [ ];
        };
      };
    };

    "smi-nixos" = {
      platform = "x86_64-linux";
      timeZone = defaults.timeZone;

      options = [
        "luks"
        "secureboot"
        "dualboot"
      ];

      desktopGui = [ "hyprland" ];

      # Systemwide
      coreModules = defaults.nixos.coreModules;
      systemApplications = [
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
            "drawio"
            "gitkraken"
            "idea"
            "keepassxc"
            "kitty"
            "neovim"
            "nodejs"
            "obsidian"
            "opentofu"
            "qmk"
            "vscodium"
            "zen-browser"
            "zettlr"
            "zotero"
          ];
          configurations = [
            "git"
            "ssh"
            "zsh"
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
            "cursor"
            "datagrip"
            "gitkraken"
            "kitty"
            "neovim"
            "nodejs"
            "opentofu"
            "signal"
          ];
          configurations = [
            "git"
            "zsh"
          ];
          services = [ ];
        };
      };

      # GUIs
      guis = defaults.nixos.guis;
    };
  };
}
