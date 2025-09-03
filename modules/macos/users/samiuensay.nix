{
  pkgs,
  lib,
  hostname,
  hostConfig,
  ...
}:
let
  userOptions = hostConfig.users."samiuensay";
  userName = userOptions.username;
in
{
  users.users."${userName}" = {
    isHidden = false;
    description = userOptions.description;
    home = "/Users/${userName}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  system.primaryUser = "${userName}";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${userName} = import ../../home/${userName}.nix {
      inherit
        pkgs
        lib
        hostname
        hostConfig
        userOptions
        ;
    };
    extraSpecialArgs = {
      inherit
        hostname
        hostConfig
        userOptions
        ;
    };
    backupFileExtension = "hm-backup";
  };
}
