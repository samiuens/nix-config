{
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  userName = "samiuensay";
in
{
  users.users."${userName}" = {
    isNormalUser = true;
    description = "Sami Arda Ünsay";
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
    users.${userName} = import ../../home {
      inherit
        pkgs
        lib
        hostConfig
        ;
    };
    backupFileExtension = "hm-backup";
  };
}
