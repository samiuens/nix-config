{ hostConfig, lib, ... }:
let
  userHelpers = import ../../../lib/userHelpers.nix { inherit lib; };
  allUsers = userHelpers.createAllUsersSet hostConfig.users;
in
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = allUsers;
  };
}
