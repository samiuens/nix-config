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
    ]
    ++ lib.optionals hostConfig.enableDocker [ "docker" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
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
