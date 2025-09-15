{ hostConfig, lib, ... }:
let
  userHelpers = import ../../../lib/userHelpers.nix { inherit lib; };
  sudoUsers = userHelpers.getSudoUsers hostConfig.users;
in
{
  nix = {
    enable = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      trusted-users = sudoUsers;

      # Hyprland Cachix
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };
  };
}
