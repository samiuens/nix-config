{ hostname, ... }:
{
  networking = {
    computerName = hostname;
    hostName = hostname;
    localHostName = hostname;
    applicationFirewall = {
      enable = true;
      enableStealthMode = true;
    };
  };
  system.defaults.smb = {
    NetBIOSName = hostname;
  };
}
