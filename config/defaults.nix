{
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
      # "fonts" # Broken, at the moment
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
}
