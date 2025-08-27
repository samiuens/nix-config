{ hostname, ... }:
{
  services.syncthing = {
    enable = true;
    options = {
      listenAddresses = [ "tcp://${hostname}:22000" ];
      urAccepted = -1;
    };
    settings = {
      devices =
        with builtins;
        let
          device = name: id: {
            name = {
              addresses = [ "tcp://${name}:22000" ];
              id = "${id}";
            };
          };
        in
        listToAttrs [ ];
      folders = { };
    };
  };
}
