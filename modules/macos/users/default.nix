{
  pkgs,
  lib,
  hostname,
  hostConfig,
  ...
}:
{
  users.users = builtins.mapAttrs (userName: userOptions: {
    isHidden = false;
    description = userOptions.description;
    home = "/Users/${userName}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  }) hostConfig.users;
  system.primaryUser = builtins.head (builtins.attrNames hostConfig.users);

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
    ) hostConfig.users;

    extraSpecialArgs = {
      inherit
        hostname
        hostConfig
        ;
    };
    backupFileExtension = "hm-backup";
  };
}
