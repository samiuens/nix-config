{
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  userOptions = hostConfig.users."samiuensay";
  userName = userOptions.username;
in
{
  users.users."${userName}" = {
    isNormalUser = true;
    description = userOptions.description;
    home = "/home/${userName}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # quirk due to nix not detecting shell configuration via hm
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${userName} = import ../../home/${userName}.nix {
      inherit
        pkgs
        lib
        hostConfig
        userOptions
        ;
    };
    backupFileExtension = "hm-backup";
  };
}
