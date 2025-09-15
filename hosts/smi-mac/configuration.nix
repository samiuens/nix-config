let
  defaults = import ../../config/defaults.nix;
in
{
  platform = "aarch64-darwin";
  timeZone = defaults.timeZone;

  users = [
    "samiuensay"
    "samiarda"
  ];

  userApplicationOverrides = {
    "samiuensay" = [
      "aerospace"
    ];
    "samiarda" = [
      "aerospace"
    ];
  };

  coreModules = defaults.macos.coreModules;
  settingModules = defaults.macos.settingModules;
  systemApplications = [ ];
  systemServices = [ ];
}
