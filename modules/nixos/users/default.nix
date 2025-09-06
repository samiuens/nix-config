{
  inputs,
  pkgs,
  lib,
  hostname,
  hostConfig,
  ...
}:
{
  users.users = builtins.mapAttrs (userName: userOptions: {
    isNormalUser = true;
    description = userOptions.description;
    home = "/home/${userName}";
    extraGroups = [
      "networkmanager"
    ]
    ++ lib.lists.optional (builtins.elem "docker" hostConfig.virtualisation) "docker"
    ++ lib.optionals userOptions.sudoPermission [ "wheel" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  }) hostConfig.users;

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
        inputs
        hostname
        hostConfig
        ;
    };
    backupFileExtension = "hm-backup";
  };
}
