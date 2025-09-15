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

  userConfigs = builtins.mapAttrs (
    userName: userOptions:
    userOptions
    // {
      applications = userHelpers.getUserApplicationsWithHostOverrides userName hostConfig;
    }
  ) (userHelpers.createUserConfigs hostConfig.users);
in
{
  users.users = builtins.mapAttrs (userName: userOptions: {
    isNormalUser = true;
    description = userOptions.nickname;
    home = "/home/${userName}";
    extraGroups = [
      "networkmanager"
    ]
    ++ lib.optionals (userOptions.type == "sudo") [ "wheel" ]
    ++ lib.lists.optional (builtins.elem "docker" hostConfig.virtualisation) "docker";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  }) userConfigs;

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
