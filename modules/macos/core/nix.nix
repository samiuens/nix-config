{ hostConfig, ... }:
{
  nix = {
    enable = false;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = builtins.attrNames hostConfig.users;
    optimise.automatic = false;
    gc.automatic = false;
  };
}
