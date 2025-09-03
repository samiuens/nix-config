{ hostConfig, ... }:
{
  nix = {
    enable = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = builtins.attrNames hostConfig.users;
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
