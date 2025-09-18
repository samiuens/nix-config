let
  defaults = import ../../config/defaults.nix;
in
{
  platform = "x86_64-linux";
  timeZone = defaults.timeZone;

  options = [
    "luks"
    "secureboot"
    "dualboot"
  ];

  users = [
    "samiuensay"
    "samiarda"
  ];

  userApplicationOverrides = {
    "samiuensay" = [
      "obsidian"
      "zettlr"
    ];
    "samiarda" = [
      "bitwarden"
      "chromium"
      "signal"
    ];
  };

  desktopGui = [
    "hyprland"
  ];

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
}
