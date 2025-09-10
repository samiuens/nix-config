{
  imports = [ ./hardware-configuration.nix ];
  system.stateVersion = "25.05";
  
  networking.hosts = {
    "127.0.0.1" = [ "keepitdeveloped.local" ];
    "::1" = [
      "keepitdeveloped.local"
    ];
  };
}
