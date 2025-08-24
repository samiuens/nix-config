{ hostname, hostConfig, ... }:
{
  imports = [
    # Host-specific configuration import
    ../../hosts/${hostname}
  ];
}
