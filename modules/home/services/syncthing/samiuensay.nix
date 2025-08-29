{ hostname, ... }:
{
  services.syncthing =
    let
      syncthingOptions = {
        listenAddresses = [ "tcp://${hostname}:22000" ];
        urAccepted = -1;
      };
    in
    {
      enable = true;
      settings = {
        options = syncthingOptions;
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
