{
  inputs,
  pkgs,
  lib,
  hostname,
  hostConfig,
  ...
}:
let
  userHelpers = import ../../../lib/userHelpers.nix { inherit lib; };
  userConfigs = userHelpers.createUserConfigs hostConfig.users;
  primarySudoUser = userHelpers.getPrimarySudoUser hostConfig.users;
in
{
  users.users = builtins.mapAttrs (userName: userOptions: {
    isHidden = false;
    description = userOptions.nickname;
    home = "/Users/${userName}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  }) userConfigs;
  system.primaryUser = primarySudoUser;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = builtins.mapAttrs (
      userName: userOptions:
      import ../../home {
        inherit
          pkgs
          lib
          hostname
          hostConfig
          userName
          userOptions
          ;
      }
    ) userConfigs;

    extraSpecialArgs = {
      inherit
        inputs
        hostname
        hostConfig
        ;
    };
    backupFileExtension = "hm-backup";
  };
}
