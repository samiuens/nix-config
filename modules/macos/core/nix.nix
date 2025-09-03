{ hostConfig, ... }:
{
  nix = {
    enable = false;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = [ "${hostConfig.users."samiuensay".username}" ];
    optimise.automatic = false;
    gc.automatic = false;
  };
}
