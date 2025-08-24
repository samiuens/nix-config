{ hostname, hostConfig, ... }:
let
  coreModules = map (name: ./core/${name}.nix) hostConfig.coreModules;
in
{
  imports = coreModules ++ [
    # Host-specific configuration import
    ../../hosts/${hostname}

    # Users
    ./users/samiuensay.nix
  ];
}
