let
  userName = "samiuensay";
in
{
  users.users."${userName}" = {
    isNormalUser = true;
    description = "Sami Arda Ünsay";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${userName} = import ../../home;
    backupFileExtension = "hm-backup";
  };
}
